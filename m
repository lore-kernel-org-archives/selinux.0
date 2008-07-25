Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6P1N7OJ031902
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 21:23:07 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6P1N6m4003886
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 01:23:06 GMT
Received: by py-out-1112.google.com with SMTP id a78so8396532pyh.32
        for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 18:23:06 -0700 (PDT)
Subject: Re: [patch] SELinux: trivial, unify iterator variable naming, part
	3
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <Pine.LNX.4.64L.0807241800060.14689@ruuvi.it.helsinki.fi>
References: <Pine.LNX.4.64L.0807210220280.8567@ruuvi.it.helsinki.fi>
	 <Xine.LNX.4.64.0807242320060.8246@us.intercode.com.au>
	 <Pine.LNX.4.64L.0807241800060.14689@ruuvi.it.helsinki.fi>
Content-Type: text/plain
Date: Thu, 24 Jul 2008 21:20:37 -0400
Message-Id: <1216948850.5185.10.camel@sulphur>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-07-24 at 19:00 +0300, Vesa-Matti J Kari wrote:
> Hello,
> 
> On Thu, 24 Jul 2008, James Morris wrote:
> 
> > I'm not applying these variable renaming patches, as they peturb the code
> > for no established benefit.
> 
> That's all right.
> 
> > I suggest reading the following carefully on how to submit patches:
> > http://www.zipworld.com.au/~akpm/linux/patches/stuff/tpp.txt
> 
> Thanks a lot. I try to be more careful. I suppose I have to resend one
> patch, as I forgot to CC the kernel list, and the patch was not really
> conforming to the rules specified above, either.
> 
> > It's also generally best to simply use git to create patches (e.g. via
> > git-format-patch).
> 
> OK, I have to learn how to use git.
> 
> > Something that would be particularly useful at this stage would be to see
> > if you can reproduce a long delay in booting the current git tree possibly
> > related to SELinux policy loading:
> >
> > [    6.904650] EXT3-fs: mounted filesystem with ordered data mode.
> > [    7.076411] type=1404 audit(1216904882.076:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
> > [   59.445985] SELinux: 8192 avtab hash slots, 1815416 rules.
> > [   60.812559] SELinux: 8192 avtab hash slots, 1979772 rules.
> 
> It boots quite quickly on my Fedora 9, but the boot log shows
> significantly less rules than yours. If you really have that much rules, I
> guess your hash chains will have to be much longer too...
> 
> The 171021 vs 1979772 is strange, ratio being approx. 1:11.
> 
> Here is what I have:
> 
> EXT3-fs: mounted filesystem with ordered data mode.
> type=1404 audit(1216911601.748:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295
> SELinux: 8192 avtab hash slots, 171021 rules.
> SELinux: 8192 avtab hash slots, 171021 rules.

Yes, that looks more reasonable than James' output.
James - semodule -l output?  rpm -V selinux-policy-targeted output?
If you move aside the policy.N file and run semodule -B, do you end up
with the same size policy or one that is more reasonable?

Also, libsepol version is of interest here.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
