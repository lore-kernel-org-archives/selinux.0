Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0HCvAXf002165
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 07:57:10 -0500 (EST)
Received: from e2.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0HCu2P2011127
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 12:56:02 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0HCv8SD004172
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 07:57:08 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0HCv7lI118028
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 07:57:08 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k0HCv7fs028181
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 07:57:07 -0500
Date: Tue, 17 Jan 2006 06:57:06 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] sereference: enable local login
Message-ID: <20060117125706.GC20632@sergelap.austin.ibm.com>
References: <20060111213646.GA30428@sergelap.austin.ibm.com> <200601171908.04196.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200601171908.04196.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Russell Coker (russell@coker.com.au):
> On Thursday 12 January 2006 08:36, "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> > Following is a patch which allows me to log in locally on a gentoo
> > system with the reference policy.
> >
> > Index: refpolicy/policy/modules/system/authlogin.if
> > ===================================================================
> > --- refpolicy.orig/policy/modules/system/authlogin.if
> > +++ refpolicy/policy/modules/system/authlogin.if
> > @@ -115,6 +115,8 @@ template(`authlogin_per_userdomain_templ
> >  	allow $2 self:netlink_audit_socket { create_netlink_socket_perms
> > nlmsg_relay };
> >
> >  	dontaudit $2 shadow_t:file { getattr read };
> > +	typeattribute $2 can_read_shadow_passwords;
> > +	allow $2 shadow_t:file { getattr read };
> >
> >  	# Transition from the user domain to this domain.
> >  	domain_auto_trans($2,chkpwd_exec_t,$1_chkpwd_t)
> > @@ -253,6 +255,8 @@ interface(`auth_domtrans_chk_passwd',`
> >  	allow system_chkpwd_t $1:process sigchld;
> >
> >  	dontaudit $1 shadow_t:file { getattr read };
> > +	typeattribute $1 can_read_shadow_passwords;
> > +	allow $1 shadow_t:file { getattr read };
> >
> >  	dev_read_rand($1)
> >  	dev_read_urand($1)
> 
> This is bad.  We don't want to allow such domains access to shadow_t, a 
> significant aim of SE Linux is to restrict access to shadow_t.  If your PAM 
> system is correctly patched then it will try to access /etc/shadow directly 
> and then run a helper program which is both SETUID and has a 
> domain_auto_trans() to give it the access it needs.

I see.  Will look into why that doesn't seem to be happening then...

> > Index: refpolicy/policy/modules/kernel/terminal.fc
> > ===================================================================
> > --- refpolicy.orig/policy/modules/kernel/terminal.fc
> > +++ refpolicy/policy/modules/kernel/terminal.fc
> > @@ -1,5 +1,6 @@
> >
> >  /dev/.*tty[^/]*		-c	gen_context(system_u:object_r:tty_device_t,s0)
> > +/dev/.*tty[^/]*		-l	gen_context(system_u:object_r:tty_device_t,s0)
> >  /dev/[pt]ty[abcdepqrstuvwxyz][0-9a-f]	-c
> > gen_context(system_u:object_r:bsdpty_device_t,s0)
> > /dev/adb.*		-c	gen_context(system_u:object_r:tty_device_t,s0)
> >  /dev/capi.*		-c	gen_context(system_u:object_r:tty_device_t,s0)
> 
> Best to leave the symlinks as type device_t.  I don't think that there's any 

Yes.  It seemed as though I needed this in order to log in over serial,
but apparently something else must have changed at the same time that I
made this change, as backing it out still lets me log in and also lets
screen work.

> > @@ -14,6 +15,7 @@
> >  /dev/rfcomm[0-9]+	-c	gen_context(system_u:object_r:tty_device_t,s0)
> >  /dev/tty		-c	gen_context(system_u:object_r:devtty_t,s0)
> >  /dev/ttySG.*		-c	gen_context(system_u:object_r:tty_device_t,s0)
> > +/dev/tts/[0-9]		-c	gen_context(system_u:object_r:tty_device_t,s0)
> >
> >  /dev/pty/.*		-c	gen_context(system_u:object_r:bsdpty_device_t,s0)
> 
> Is Gentoo still using devfs device names?  If so you might want to make it 
> work for more than 10 serial ports.

(I'm using udev)  Makes no absolutely sense in hindsight, but I was
erring on the 'safe' side.  I almost picked [0-4]  :)

> Also Gentoo specific changes should have ifdef(`distro_gentoo' around them.

Ok - I didn't think these were distro specific, but if in fact gentoo's
pam is patched differently, the authlogin.if patch would certainly be.
Hopefully there's a better way to fix that problem though.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
