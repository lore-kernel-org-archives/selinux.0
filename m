Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        "'Howard Holm'" <hdholm@epoch.ncsc.mil>, SELinux@tycho.nsa.gov
Subject: Re: SELinux RPM Version
Date: Tue, 23 Apr 2002 14:39:00 +0200
References: <72222DC86846D411ABD300A0C9EB08A101524357@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524357@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020423123901.2AB33B1A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 23 Apr 2002 14:24, Westerman, Mark wrote:
> > Why have the kernel version in the package name?  The NSA is  only making
> > releases for the latest kernel.  I've backported a couple of  the changes
>
> to
>
> > an older kernel, but AFAIK no-one else is doing so.
>
> While it is true that the NSA is only making releases for the latest kernel
> we might need in the future the older version. A user might not want to
> upgrade there kernel version. If is not to hard to keep the kernel version
> I think it just adds to less confusion.

Choosing not to update the kernel is not related to the choice of which 
version of the selinux package to use (apart from the checkpolicy program and 
it's relationship to the policy version used by the kernel).

Therefore putting a kernel version in the name of the "selinux" package will 
lead users to believe that there is a dependency when in fact none exists.

> > > If future releases of selinux I think we should sub-divided into
> > > more packages
> > > 	selinux-kernel-<kernel version>-<NSA Release number>
> > > 	selinux-policy-<version number>-<release>
> > > 	selinxu-utils-<version number>-<release>
> > > 		To include newrole, run_init and ......
> > > 		Or a separate rpm for utility ?
> >
> > Why split the sample policy from the utilities?  Why would
> > you use one
> > without the other?
>
> There might be different verions of a policy. Such as a policy
> for just bind (i.e. a DNS server only). If we have package for
> policy then maybe different policies will be built.

There is nothing preventing other packages from installing their own 
directories in /usr/share/selinux/policy and putting appropriate policy files 
in them!

However splitting it out would mean that people who don't want the default 
policy can save 622K of disk space (for the case of the policy files I 
distribute), so I may split it for that reason.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
