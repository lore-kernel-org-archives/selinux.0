To: SELinux@tycho.nsa.gov
From: mm19827 <mm19827@gmail.com>
Subject: selinux and thread local storage
Date: Tue, 14 Apr 2015 18:45:10 +0000 (UTC)
Message-ID: <loom.20150414T202953-219@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all,

I am trying to figure out something about Red Hat Bugzilla â€“ Bug 1195074,
where nvidia libGL.so.304.125 hangs in an endless loop when loaded by
gnome-shell 3.14.

Sequence is: gnome-shell loads libGL.so which for some reason calls
is_selinux_enabled in libselinux.so at library load time, which runs into a
spinlock within init_thread_destructor when accessing the thread-local
variable destructor_initialized.

gdb print of destructor_initialized reports:
The inferior has not yet allocated storage for thread-local variables in the
shared library `/lib64/libselinux.so.1'

gdb backtrace is:

#0  0x0000003f12412495 in tls_get_addr_tail (ti=0x3509221f58,
dtv=0x7ffff7f83390, the_map=0x7ffff7f9c000)
    at dl-tls.c:751
#1  0x00003ğÀÌÔÀäÀÁ…˜ØÌ¥¸•ÑÁÉ½…ÑÑÉ½¹}É…Ü€ ¤…ĞÁÉ½…ÑÑÈ¹ŒèÜÌ(ŒÈ€€ÁàÀÀÀÀÀÀÌÔÀäÀÁ…˜ØÌ¥¸•ÑÁÉ½…ÑÑÉ½¹}É…Ü(¡½¹Ñ•áĞõ½¹Ñ•áÑ•¹ÑÉäôÁàİ™™™™™™™å˜À°Á¥õÁ¥‘•¹ÑÉäôÀ°)…ÑÑÈõ…ÑÑÉ•¹ÑÉäôÁàÌÔÀäÀÄå”İˆ€‰ÕÉÉ•¹Ğˆ¤…ĞÁÉ½…ÑÑÈ¹ŒèÄÈÄ(ŒÌ€€ÁàÀÀÀÀÀÀÌÔÀäÀÁˆÈÑ”¥¸•Ñ½¹}É…İ}¥¹Ñ•É¹…°€¡Œõ•¹ÑÉäôÁàİ™™™™™™™å˜À¤…Ğ)ÁÉ½…ÑÑÈ¹ŒèÌÌĞ(ŒĞ€€ÁàÀÀÀÀÀÀÌÔÀäÀÁ„Ù”¥¸¥Í}Í•±¥¹Õá}•¹…‰±•‘}¥¹Ñ•É¹…°€ ¤…Ğ•¹…‰±•¹ŒèÈØ(ŒÔ€€ÁàÀÀÀÀÀÀÌÔÁÁ„ÕŒÀØ¥¸€€ ¤…Ğ€½±¥ˆØĞ½±¥‰0¹Í¼¸Ä(ŒØ€€ÁàÀÀÀÀÀÀÌÔÁÀàÑŒİˆ¥¸€€ ¤…Ğ€½±¥ˆØĞ½±¥‰0¹Í¼¸Ä(ŒÜ€€ÁàÀÀÀÀÀÀÍ˜ÄÈĞÁ™••¥¸…±±}¥¹¥Ğ€¡°ôÁàİ™™™˜İ˜ääå„à°…ÉŒõ…É•¹ÑÉäôÈ°)…ÉØõ…ÉÙ•¹ÑÉäôÁàİ™™™™™™™‘ŒÄà°•¹Øõ•¹Ù•¹ÑÉäôÁàİ™™™™™™™‘ŒÌÀ¤…Ğ‘°µ¥¹¥Ğ¹ŒèØÈ(Œà€€ÁàÀÀÀÀÀÀÍ˜ÄÈĞÄÀÀÍˆ¥¸}‘±}¥¹¥Ğ€¡•¹Øôñ½ÁÑ¥µ¥é•½ÕĞø°…ÉØôñ½ÁÑ¥µ¥é•)½ÕĞø°…ÉŒôñ½ÁÑ¥µ¥é•½ÕĞø°°ôñ½ÁÑ¥µ¯×¦VB÷WCâ’BFÂÖ–æ—Bæ3£3@¢3’ƒ6c#C6"–âöFÅö–æ—B†Ö–åöÖÓƒ6c#c#3C‚Â&v3Ó"À¦&wcÓƒvfffffffF3‚ÂVçcÓƒvfffffffF33’BFÂÖ–æ—Bæ3£#@¢3ƒ6c#CC&–âöFÅ÷7F'E÷W6W"‚’BöÆ–#cBöÆBÖÆ–çW‚×ƒƒbÓcBç6òã ¢3ƒ"–â‚¢3"ƒvfffffffFfFB–â‚¢32ƒvfffffffFfc"–â‚¢3Bƒ–â‚ ¥F†—2ö67W'2BÆ–'&'’ÆöBF–ÖRÂ6ò&Vf÷&RvWGF–ærFòÖ–â‚’à¤FF—F–öæÂæ÷FR—2F†B’†fRF†—2&ö&ÆVÒv—F‚væöÖR×6†VÆÂÂ'WBÖç’÷F†W ¦W†V7WF&ÆW2†–æ6ÇVF–ærvæöÖR×6W76–öâÂvÇ†–æfòÂvÇ†vV'2’Æö@¦Æ–$tÂç6òã3Bã#RæB'Vâ§W7Bf–æRà ¥F†—2&ö&ÆVÒ—26–Ö–Æ"FòF†RöæRFW67&–&VB–à¦‡GG¢òöÖ&2æ–æfòó÷CÓC##S#c“s2g#ÓgsÓ ¦ÇF†÷Vv‚–â×’66Rv†BVæÆö6·2F†R7–æÆö6²—2FòFòÄEõ$TÄôBf÷"Æ–$tÂç6òà¤’FöâwBF†–æ²ÄEõ$TÄôB—2&VÆÇ’ÈÛÛÙÛÛ][Û‹ˆ[HİYÙÙ\İ[ÛœÏÂ‚•Ú]XZÙ\È]Y™šXİ[\™H\È]šYXHX‘ÓœÛËŒÌ
ŒLH\ÈÛÜÙYœÛİ\˜ÙK[™][ÛÈØYÈÛÛYHX›šYXK]ÈÚXÚÛİ[™Èİ\ÜXİ]˜Ûİ[\ÈİYÙÙ\İÛÛYHÈ[š]X[^˜][Ûˆ›Ø›[HÚ[H[˜[ZXÈØY[™ÈÙ‚›XœÙ[[^
