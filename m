Date: Fri, 24 Aug 2007 11:33:44 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: James Morris <jmorris@namei.org>
Subject: Re: [patch] Tuning avtab to reduce memory usage
Cc: ynakam@hitachisoft.jp, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>, busybox@kaigai.gr.jp,
        Eric Paris <eparis@parisplace.org>, kaigai@ak.jp.nec.com
In-Reply-To: <Xine.LNX.4.64.0708230745220.27506@us.intercode.com.au>
References: <20070823094904.1AB9.YNAKAM@hitachisoft.jp> <Xine.LNX.4.64.0708230745220.27506@us.intercode.com.au>
Message-Id: <20070824113311.5B86.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 23 Aug 2007 07:46:52 -0700 (PDT)
James Morris  wrote:
> On Thu, 23 Aug 2007, Yuichi Nakamura wrote:
> 
> > +static inline int avtab_hash(struct avtab_key *keyp, u16 mask)
> > +{
> > +	return ((keyp->target_class + (keyp->target_type << 2) + \
> > +		 (keyp->source_type << 9)) & mask);
> > +}
> 
> As you'll need to resubmit the patch, please remove the \ (I had fixed it 
> up in my local tree).
I will fix in next patch.
 
> Please also provide a short description of the patch (one paragraph at the 
> most), to go in the git log.
I see.

> 
> - James
> -- 
> James Morris
> <jmorris@namei.org>

-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
Japan SELinux Users Group(JSELUG): http://www.selinux.gr.jp/
SELinux Policy Editor: http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
