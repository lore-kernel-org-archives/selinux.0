Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n61FCB0I002750
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 11:12:11 -0400
Received: from g4t0014.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n61FCa4N028613
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 15:12:39 GMT
From: Paul Moore <paul.moore@hp.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: The problem with TUN/TAP devices
Date: Wed, 1 Jul 2009 11:11:47 -0400
Cc: selinux@tycho.nsa.gov
References: <200906301734.31986.paul.moore@hp.com> <4A4AD8CE.3000604@schaufler-ca.com>
In-Reply-To: <4A4AD8CE.3000604@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200907011111.48002.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 30 June 2009 11:32:30 pm Casey Schaufler wrote:
> Paul Moore wrote:
> > Unfortunately we have a problem with the network access controls and
> > TUN/TAP devices.  The basic issue is that packets entering the stack via
> > a TUN device, e.g. QEMU/KVM guest instance operating with a bridged
> > network configuration, do not have a fully initialized sock associated
> > with them.  I say "fully initialized" because the basic initialization
> > has been done (memory allocated, initial values set to
> > SECINITSID_UNLABELED, etc.) but the last step where we assign the sock a
> > label/SID never happens.  Why?  Because the TUN driver code only calls
> > sk_alloc() and nothing else in the TUN code paths finish the SELinux sock
> > setup.
>
> So what should it be calling and why is the fact that it isn't not a bug
> in the TUN driver?

...

> As this would appear to be a flaw in the TUN driver, get the TUN
> developers to fix their broken driver. I certainly dislike a special
> purpose LSM hook for this.

I do too.

> Do you see this as a problem for all users of labeled networking,
> or is it isolated to SELinux?

The issue first came up with respect to SELinux so that is where I've been 
looking/thinking.  While there is a potential for Smack to be affected I doubt 
that will be he case since Smack doesn't really care about stuff at the 
postrouting level; although Smack may want to enforce some level of access 
control but I need to go re-remember how Smack does outbound access control.  
TOMOYO should be unaffected since they don't mess with labels.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
