Message-ID: <47025FD6.3090803@kaigai.gr.jp>
Date: Wed, 03 Oct 2007 00:12:22 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, Paul Moore <paul.moore@hp.com>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH] Improve SELinux performance when AVC misses.
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>  <200708211111.27019.paul.moore@hp.com>  <1187714269.1451.148.camel@moss-spartans.epoch.ncsc.mil>  <200708211255.45132.paul.moore@hp.com> <46CC00F4.2090501@ak.jp.nec.com>  <46E7583C.9030103@ak.jp.nec.com>  <1190136066.14037.53.camel@moss-spartans.epoch.ncsc.mil>  <46F22BEF.9050208@ak.jp.nec.com>  <1190402479.17518.130.camel@moss-spartans.epoch.ncsc.mil>  <46F89767.2090203@ak.jp.nec.com>  <1190728430.24726.13.camel@moss-spartans.epoch.ncsc.mil>  <46F9F2E2.4060406@ak.jp.nec.com> <46FB13EE.3040907@ak.jp.nec.com>  <46FB18D1.6080608@ak.jp.nec.com>  <Xine.LNX.4.64.0709271342000.21590@us.intercode.com.au>  <46FCDDF0.9090707@ak.jp.nec.com> <1190990867.22078.29.camel@moss-spartans.epoch.ncsc.mil> <46FD37F7.4020602@ak.jp.nec.com> <Xine.LNX.4.64.0709281408080.18330@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0709281408080.18330@us.intercode.com.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Sat, 29 Sep 2007, KaiGai Kohei wrote:
> 
>> Stephen Smalley wrote:
>>> On Fri, 2007-09-28 at 19:56 +0900, KaiGai Kohei wrote:
>>>> James Morris wrote:
>>>>>> ++			struct ebitmap_node *_n;
>>>>>> ++			_n = kzalloc(sizeof(*_n), GFP_KERNEL);
>>>>> Leading underscores are usually used to indicate that core code is not 
>>>>> supposed to use the symbol.  Please change it to not have a leading 
>>>>> underscore.  'tmp' or 'n2' is probably ok.
>>>> OK, I replaced all of '_n' by 'tmp'.
>>>> Rest of the part in the following patch is same as the previous one.
>>> Seems to be damaged, or at least doesn't apply for me.  What is it
>>> relative to?
>> I generated the patch against to the latest of James's git tree
>> But it seems to me that all tab chatacters are translated into
>> four white spaces, when I copied and pasted the patch.
>> I'm sorry, it was my misoperation.
>>
>> Can you receive it with tab kept in this time?
> 
> Yes, but there are compiler warnings on 64-bit.
> 
> Please test it on a 64-bit machine.
> 
> $ make -j3 SUBDIRS=security
>   CC      security/selinux/ss/ebitmap.o
>   CC      security/selinux/ss/sidtab.o
>   CC      security/selinux/ss/avtab.o
> security/selinux/ss/ebitmap.c: In function ‘ebitmap_netlbl_import’:
> security/selinux/ss/ebitmap.c:196: warning: right shift count >= width of type
> security/selinux/ss/ebitmap.c: In function ‘ebitmap_read’:
> security/selinux/ss/ebitmap.c:393: warning: format ‘%Zd’ expects type ‘signed size_t’, but argument 3 has type ‘u32’
> security/selinux/ss/ebitmap.c:399: warning: format ‘%Zd’ expects type ‘signed size_t’, but argument 3 has type ‘u32’
> security/selinux/ss/ebitmap.c:437: warning: right shift count >= width of type

The attached patch kills these warnings.

While killing them, I faced to a serious bug.
At first, I expected the following while { ... } block is never looped
multiple time in 64-bit architecture.

--------
+#if EBITMAP_UNIT_SIZE == 64
+		n->maps[index] = map;
+#else
  		while (map) {
  			n->maps[index] = map & (-1UL);
  			map = map >> EBITMAP_UNIT_SIZE;
  			index++;
  		}
+#endif
--------

However, I might misunderstand about the works of shift operations.
When we tries to shift a variable with the width of it, this operation
does not give us any effect.

See the following small code.

[kaigai@masu ~]$ cat hoge.c
#include <stdio.h>

int main(int argc, char *argv[]) {
         unsigned long code = -1UL;

         printf("code       = %016lx\n", code);
         printf("code >> 16 = %016lx\n", code >> 16);
         printf("code >> 63 = %016lx\n", code >> 63);
         printf("code >> 64 = %016lx\n", code >> 64);
         printf("code >> 65 = %016lx\n", code >> 65);

         return 0;
}
[kaigai@masu ~]$ env LANG=C gcc hoge.c
hoge.c: In function 'main':
hoge.c:9: warning: right shift count >= width of type
hoge.c:10: warning: right shift count >= width of type
[kaigai@masu ~]$ ./a.out
code       = ffffffffffffffff
code >> 16 = 0000ffffffffffff
code >> 63 = 0000000000000001
code >> 64 = ffffffffffffffff
code >> 65 = 7fffffffffffffff
[kaigai@masu ~]$ uname -m
x86_64

I was suprised at. :-)
It is the reason why I put #if block to separate 64bit/32bit cases.

Do you have any idea to write it more simply?

----------------------------------------
[PATCH] kills warnings in Improve SELinux performance when AVC misses

This patch kills ugly warnings when the "Improve SELinux performance
when ACV misses" patch.

Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
---
  security/selinux/ss/ebitmap.c |   12 ++++++++++--
  1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index ae44c0c..2e21ca1 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -191,10 +191,14 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
  			delta = c_pos - e_iter->startbit;
  			e_idx = delta / EBITMAP_UNIT_SIZE;
  			e_sft = delta % EBITMAP_UNIT_SIZE;
+#if EBITMAP_UNIT_SIZE == 64
+			e_iter->maps[e_idx] |= map;
+#else
  			while (map) {
  				e_iter->maps[e_idx++] |= map & (-1UL);
  				map >>= EBITMAP_UNIT_SIZE;
  			}
+#endif
  		}
  		c_iter = c_iter->next;
  	} while (c_iter != NULL);
@@ -389,13 +393,13 @@ int ebitmap_read(struct ebitmap *e, void *fp)

  		if (startbit & (mapunit - 1)) {
  			printk(KERN_ERR "security: ebitmap start bit (%d) is "
-			       "not a multiple of the map unit size (%Zd)\n",
+			       "not a multiple of the map unit size (%u)\n",
  			       startbit, mapunit);
  			goto bad;
  		}
  		if (startbit > e->highbit - mapunit) {
  			printk(KERN_ERR "security: ebitmap start bit (%d) is "
-			       "beyond the end of the bitmap (%Zd)\n",
+			       "beyond the end of the bitmap (%u)\n",
  			       startbit, (e->highbit - mapunit));
  			goto bad;
  		}
@@ -432,11 +436,15 @@ int ebitmap_read(struct ebitmap *e, void *fp)
  		map = le64_to_cpu(map);

  		index = (startbit - n->startbit) / EBITMAP_UNIT_SIZE;
+#if EBITMAP_UNIT_SIZE == 64
+		n->maps[index] = map;
+#else
  		while (map) {
  			n->maps[index] = map & (-1UL);
  			map = map >> EBITMAP_UNIT_SIZE;
  			index++;
  		}
+#endif
  	}
  ok:
  	rc = 0;

-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
