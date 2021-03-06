#!/bin/bash

if [ -n "$1" ]
then PORT="$1"
else PORT=8004
fi

export STAR_TERMINAL_ID=9b59bbb0-5a45-11e4-8ed6-0800200c9a66
export STAR_PUBLIC_KEY=AQEAAAAAAAABAP//////////aKqsilqOchUQBfqYGCbSFeVqlep8SZU5GBdYlfbLK97JUkxv8F3FtY+iB+yigyebA4YOGCx3nuM7zjYuRl6QMnwhGMoIbHTxBJi8Sk41DGdtlpZwBynVnrtShSBW82Iclq2j3CNdZYNfzyT9qD8WaZrTVRw2SNqYBb9jobh8AMI9W+TsUWYoSeYfS3wRJJ+upZ+JWvtrOO7ttwb0tlz/C2vtN6bpQkz0xn5eYna1heRFwlFtbTXhTzcUX/JtCiswG0M6zbMZle/dBDSOeQhKUSKbEzumvgsCdMxnighOAinRHNyAi2LGxDTCaCGi2g/J//////////8AAAAAAgAAAAABAAAAAAEBAQAAAAAAAAEAH+39SWjC8H7O90AStKgGfx99exaKTRDi9qaLpDjxz+QPNggIM7ymyb8P4i2TVnKSs0hBemr+CFm7HT2D7/wXP7W2X/aSwT6rqcsl7WfIh8A30qgn0aWwBesUT8Kr15iNdw6oRfLJZJj1QSQgsVx8HkdPBxiadloxoHb+R90yRuRW1MteVdndsWA4BhCw/uug46976l5goKE6Ibh1AT7VKKsm3K860kv7aqMECCqvz/W8CTwgk4W8sr2vVxEI/H13cApLqi7OX7gm7zeAK5pMmlj77HG9ItP0y0+02UdTAKBQbdmIKrDVHJLGOjybJBv71JxSfRL08pswlUZfB+xt4A==
export STAR_INIT_PUBLIC_HASH=fcc578c708d198baecd7024be8dae72639d1560f3eaeac24f651e7be69c2b886
export STAR_INIT_INTERNAL_HASH=7ab9c86899a0007945ee13cd00b565b35d6dc3807ac9eaf08b9729b3a1267ffd
export STAR_PUBLIC_SALT=7ff1adc82440511d520c1116df34fee4e88003ccc3e73ac95f29958df06eefce
export STAR_POST_VOTE_URL=http://localhost:8003/fillOut
export STAR_REGISTER_URL=http://localhost:8003/registerTerminal

# star-terminal -p "$PORT"
../star-terminal/.stack-work/install/*/*/*/bin/star-terminal -p "$PORT"

#curl -X POST http://localhost:8000/ballots/oregon-2014/codes/25682 --data param=whatever

echo "done"
