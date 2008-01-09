Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m09Hpttq000740
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2008 12:51:55 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m09HptQY003734
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2008 17:51:55 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Sudo Changes for SELinux
Date: Wed, 9 Jan 2008 12:51:54 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880153F49C@exchange.columbia.tresys.com>
In-Reply-To: <4784EFE8.9050106@redhat.com>
References: <4784EFE8.9050106@redhat.com>
From: "Todd Miller" <Tmiller@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>, "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I have a working demonstration of  My version of RBAC in Rawhide/FC8.
> In my view of the world, users have two roles.  User Role and Admin
> Role. 
> 
> So I might login as a staff_t user and be able to transition to
> webadm_r:webadm_r.
> 
> In Rawhide right now staff_t can only run sudo to become root.
> Staff_t is not allowed to execute su.  staff_t users should not know
> the root password. I have hacked up a script /usr/bin/webadm which
> executes newrole -r webadm_r -t webadm_t and newrole's pam has
> pam_rootok. 
> 
> Now I edit the /etc/sudoers and allow
> 
> dwalsh ALL=(ALL) /usr/bin/webadm
> 
> This allows me to use sudo to become webadm_t as root.  (Policy
> obviously has to be correct.  But this is very cumbersome for the
> administrator and does not scale.
> 
> I think we need to add SELinux support to sudo, so the administrator
> could easily add something to /etc/sodoers like
> 
> dwalsh ALL=(ALL) ROLE=webadm_r TYPE=webadm_t /bin/sh
> 
> then sudo would execute the code that newrole does to very the
> transition and
> 
> setexeccon(dwalsh:webadm_t:webadm_t)
> exec(/bin/sh)
> 
> I was told that you are the upstream maintainer of sudo, so I wanted
> your input/help on making sudo selinux aware.

I suppose it depends on what you really want to be able to do.  Do you

a) wish to be able to run arbitrary commands via sudo but be able to
   specify a role and type ala newrole via -r and -t flags?

or

b) want to be able to force a command run by sudo to use a role and type
   that is specified in the sudoers file?

Doing a) is probably easier than b) though the two are not mutually
exclusive.

 - todd


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
