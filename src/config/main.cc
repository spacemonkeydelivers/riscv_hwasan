#include <cstdio>
#include <cstdint>
#include <cstdlib>
#include <sys/prctl.h>

void print_help() {
    fprintf(stderr, "Usage:\n");
    fprintf(stderr, "\t<bin> <disable/enable pm> <update csr> <apply tag> <mask size> <tag position>\n");
}

void set_pmm(int enable, int pmm_size) {
    prctl(55, enable, pmm_size, 0, 0);
}

int get_pmm() {
    return prctl(56, 0, 0, 0, 0);
}

int main(int argc, char *argv[]) {
    if (argc != 6) {
        print_help();
        return 0;
    }
    int pmm_en = atoi(argv[1]);
    int update_csr = atoi(argv[2]);
    int apply_tag = atoi(argv[3]);
    int mask_size = atoi(argv[4]);
    if (mask_size != 7 && mask_size != 16) {
        fprintf(stderr, "Wrong mask size: %d\n", mask_size);
        return 0;
    }
    int tag_position = atoi(argv[5]);
    if (tag_position > 63 || tag_position < 48) {
        fprintf(stderr, "Wrong tag position: %d\n", tag_position);
        return 0;
    }
    uint64_t tag_val = 0xAB;

    fprintf(stderr, "PM enabled %d\n", pmm_en);
    fprintf(stderr, "Apply tag %d\n", apply_tag);
    fprintf(stderr, "Mask size %d\n", mask_size);
    fprintf(stderr, "Tag posigion %d\n", tag_position);
    fprintf(stderr, "=====\n");

    int pmlen = (mask_size == 7) ? 2 : 3;
    if (update_csr) {
        set_pmm(pmm_en, pmlen);
    }
    fprintf(stderr, "Enable tagging: %d\n", get_pmm());

    uint64_t val = 0x55;
    uint64_t* val_ptr = &val;
    uint64_t tmp = reinterpret_cast<uint64_t>(val_ptr);
    
    if (apply_tag) {
        tmp |= 0xABUL << tag_position;
    }
    uint64_t* tagged_val_ptr = reinterpret_cast<uint64_t*>(tmp);

    fprintf(stderr, "Original ptr %p\n", val_ptr);
    fprintf(stderr, "Tagged ptr   %p\n", tagged_val_ptr);

    fprintf(stderr, "Original ptr:  0x%llx,0x%lx\n", val_ptr, *val_ptr);
    fprintf(stderr, "Tagged ptr:    0x%llx,0x%lx\n", tagged_val_ptr, *tagged_val_ptr);
    
    return 0;
}
