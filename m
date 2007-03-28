Date: Wed, 28 Mar 2007 17:40:46 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: ynakam@hitachisoft.jp, Stephen Smalley <sds@tycho.nsa.gov>,
        "Christopher  J. PeBenito" <cpebenito@tresys.com>,
        busybox@kaigai.gr.jp, selinux@tycho.nsa.gov,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Chad Sellers <csellers@tresys.com>
Subject: Re: Separating libselinux/libsepol (Was:  Re: BusyBox: load_policy
 applet)
Message-Id: <20070328174046.bb463392.ynakam@hitachisoft.jp>
In-Reply-To: <4609CB85.1060401@ak.jp.nec.com>
References: <20070323151513.395798cf.ynakam@hitachisoft.jp>
	<1174654177.31436.188.camel@moss-spartans.epoch.ncsc.mil>
	<20070326102809.e4f80126.ynakam@hitachisoft.jp>
	<1174918097.3864.83.camel@moss-spartans.epoch.ncsc.mil>
	<1174925566.28830.61.camel@sgc>
	<1174926929.3864.149.camel@moss-spartans.epoch.ncsc.mil>
	<20070327095945.1c4245ec.ynakam@hitachisoft.jp>
	<1174997707.3864.261.camel@moss-spartans.epoch.ncsc.mil>
	<4609CB85.1060401@ak.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Mar 2007 10:57:25 +0900
KaiGai Kohei  wrote:
> Currently, I don't have actual measurement of the minimum binary size of
> libsepol needed to handle preserving boolean variables and so on.
> Who can estimate it?

It seems that "sepol_genbools_array" libsepol function 
is necessary to preserve boolean.

And sepol_genbools_array uses following:
-From policydb.o
 policydb_init
 policydb_destroy
- From policydb_convert.o
 policydb_from_image
- From policydb_public.o
 policydb_write
-From conditional.o
 evaluate_conds
-From  hashtab.o
 hashtab_search

Then:
$ ls -l policydb.o hashtab.o conditional.o  policydb_convert.o policydb_public.o
-rw-rw-r-- 1 ynakam ynakam  6856 Mar 27 05:10 conditional.o
-rw-rw-r-- 1 ynakam ynakam  2540 Mar 27 05:10 hashtab.o
-rw-rw-r-- 1 ynakam ynakam 29284 Mar 27 05:10 policydb.o
-rw-rw-r-- 1 ynakam ynakam  2576 Mar 27 05:10 policydb_convert.o
-rw-rw-r-- 1 ynakam ynakam  2396 Mar 27 05:10 policydb_public.o
Above are compiled with -Os option.

So, to preserve bool at least 43.6 k is necessary.

I want boolean to be enabled/disabled by build option of libselinux/sepol and BusyBox.

> I want to mention that separating libselinux/libsepol is not the only way
> to reduce binary size.
> Is it possible to replace some functions rare needed in the target system
> by empty implemented functions, isn't it? I think this approach enables
> more flexible selection of functionalities than the simple separation.
Yes, this implementation is one possibility. 
This may be better than only separating libselinux/sepol.

BTW, in Japanese chat, 
you and Shinji said too fine-grained selection will not be understood by 
embedded developers.

I've come up with three selections.
1) Full-featured SELinux
2) Tiny-SELinux for embedded device with poor resource
= 1) - semanage - boolean - user space object manager etc
3) Tiny-SELinux for mobile PDA(richer embedded device)
 2) + boolean

Regards,
-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
Japan SELinux Users Group(JSELUG)
SELinux Policy Editor: http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
