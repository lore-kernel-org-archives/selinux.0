Message-ID: <4703AA70.8080805@kaigai.gr.jp>
Date: Wed, 03 Oct 2007 23:42:56 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@namei.org>, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        selinux@tycho.nsa.gov, Paul Moore <paul.moore@hp.com>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH] Improve SELinux performance when AVC misses.
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>	 <200708211111.27019.paul.moore@hp.com>	 <1187714269.1451.148.camel@moss-spartans.epoch.ncsc.mil>	 <200708211255.45132.paul.moore@hp.com> <46CC00F4.2090501@ak.jp.nec.com>	 <46E7583C.9030103@ak.jp.nec.com>	 <1190136066.14037.53.camel@moss-spartans.epoch.ncsc.mil>	 <46F22BEF.9050208@ak.jp.nec.com>	 <1190402479.17518.130.camel@moss-spartans.epoch.ncsc.mil>	 <46F89767.2090203@ak.jp.nec.com>	 <1190728430.24726.13.camel@moss-spartans.epoch.ncsc.mil>	 <46F9F2E2.4060406@ak.jp.nec.com> <46FB13EE.3040907@ak.jp.nec.com>	 <46FB18D1.6080608@ak.jp.nec.com>	 <Xine.LNX.4.64.0709271342000.21590@us.intercode.com.au>	 <46FCDDF0.9090707@ak.jp.nec.com>	 <1190990867.22078.29.camel@moss-spartans.epoch.ncsc.mil>	 <46FD37F7.4020602@ak.jp.nec.com>	 <Xine.LNX.4.64.0709281408080.18330@us.intercode.com.au>	 <47025FD6.3090803@kaigai.gr.jp> <1191338915.6799.17.camel@moss-spartans.epoch.ncsc.mil> <47039C26.1040903@kaigai.gr.jp>
In-Reply-To: <47039C26.1040903@kaigai.gr.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>> I was suprised at. :-)
>>
>> Me too.  But see:
>> http://gcc.gnu.org/ml/gcc/2004-11/msg01133.html
>> http://marc.info/?t=118688311400003&r=1&w=2
> 
> #if ... #endif block was removed in the previous patch.
> I added a macro that shifts a variable by the width of unsigned long,
> defined as follows:
> 
>   #define EBITMAP_SHIFT_UNIT_SIZE(x)            \
>       (((x) >> EBITMAP_UNIT_SIZE / 2) >> EBITMAP_UNIT_SIZE / 2)
> 
> [PATCH] kills warnings in Improve SELinux performance when AVC misses

Sorry, tab character were polluted again.

It seems to me that Thunderbird replace tab character into four white
spaces when I use "Content-Type: text/plain; charset=UTF-8".

I resend this one as follows.

[PATCH] kills warnings in Improve SELinux performance when AVC misses

This patch kills ugly warnings when the "Improve SELinux performance
when ACV misses" patch.

Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>
---
 security/selinux/ss/ebitmap.c |   11 +++++------
 security/selinux/ss/ebitmap.h |    2 ++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index ae44c0c..c1a6b22 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -193,7 +193,7 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
 			e_sft = delta % EBITMAP_UNIT_SIZE;
 			while (map) {
 				e_iter->maps[e_idx++] |= map & (-1UL);
-				map >>= EBITMAP_UNIT_SIZE;
+				map = EBITMAP_SHIFT_UNIT_SIZE(map);
 			}
 		}
 		c_iter = c_iter->next;
@@ -389,13 +389,13 @@ int ebitmap_read(struct ebitmap *e, void *fp)

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
@@ -433,9 +433,8 @@ int ebitmap_read(struct ebitmap *e, void *fp)

 		index = (startbit - n->startbit) / EBITMAP_UNIT_SIZE;
 		while (map) {
-			n->maps[index] = map & (-1UL);
-			map = map >> EBITMAP_UNIT_SIZE;
-			index++;
+			n->maps[index++] = map & (-1UL);
+			map = EBITMAP_SHIFT_UNIT_SIZE(map);
 		}
 	}
 ok:
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index e38a327..f283b43 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -21,6 +21,8 @@
 #define EBITMAP_UNIT_SIZE	BITS_PER_LONG
 #define EBITMAP_SIZE		(EBITMAP_UNIT_NUMS * EBITMAP_UNIT_SIZE)
 #define EBITMAP_BIT		1ULL
+#define EBITMAP_SHIFT_UNIT_SIZE(x)					\
+	(((x) >> EBITMAP_UNIT_SIZE / 2) >> EBITMAP_UNIT_SIZE / 2)

 struct ebitmap_node {
 	struct ebitmap_node *next;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
