Date: Thu, 27 Sep 2007 13:47:43 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Paul Moore <paul.moore@hp.com>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH] Improve SELinux performance when AVC misses.
In-Reply-To: <46FB18D1.6080608@ak.jp.nec.com>
Message-ID: <Xine.LNX.4.64.0709271342000.21590@us.intercode.com.au>
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp>
 <200708211111.27019.paul.moore@hp.com>  <1187714269.1451.148.camel@moss-spartans.epoch.ncsc.mil>
  <200708211255.45132.paul.moore@hp.com> <46CC00F4.2090501@ak.jp.nec.com>
 <46E7583C.9030103@ak.jp.nec.com>  <1190136066.14037.53.camel@moss-spartans.epoch.ncsc.mil>
  <46F22BEF.9050208@ak.jp.nec.com>  <1190402479.17518.130.camel@moss-spartans.epoch.ncsc.mil>
  <46F89767.2090203@ak.jp.nec.com> <1190728430.24726.13.camel@moss-spartans.epoch.ncsc.mil>
 <46F9F2E2.4060406@ak.jp.nec.com> <46FB13EE.3040907@ak.jp.nec.com>
 <46FB18D1.6080608@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Sep 2007, KaiGai Kohei wrote:

> However, there are several ugly manner like as:
> 
> -+				c_iter->startbit = e_startbit & ~(NETLBL_CATMAP_SIZE - 1);
> ++				c_iter->startbit
> ++				  = e_startbit & ~(NETLBL_CATMAP_SIZE - 1);
> If both side of the formula is in a same line, the width of the line get overs
> the 80-char limitation.

This is pretty common, so don't worry.

> 
> 
> ++	char *nm;
>            :
> ++				if (head != prev) {
> ++					nm = policydb.p_cat_val_to_name[prev];
> ++					len += strlen(nm) + 1;
> ++				}
> 
> If the temporary char * variable is named as "cat_name", the above longest
> line overs 80-char limitation, so I named it as "nm".
> This naming may be unclear for its purpose.

I think it's better to keep the 80 column limit here.

> ++			struct ebitmap_node *_n;
> ++			_n = kzalloc(sizeof(*_n), GFP_KERNEL);

Leading underscores are usually used to indicate that core code is not 
supposed to use the symbol.  Please change it to not have a leading 
underscore.  'tmp' or 'n2' is probably ok.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
