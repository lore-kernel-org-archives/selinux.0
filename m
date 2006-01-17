Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0H88FXf029600
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 03:08:16 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0H875P2010044
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 08:07:06 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [PATCH] sereference: enable local login
Date: Tue, 17 Jan 2006 19:07:45 +1100
Cc: SELinux <selinux@tycho.nsa.gov>
References: <20060111213646.GA30428@sergelap.austin.ibm.com>
In-Reply-To: <20060111213646.GA30428@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601171908.04196.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 12 January 2006 08:36, "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> Following is a patch which allows me to log in locally on a gentoo
> system with the reference policy.
>
> Index: refpolicy/policy/modules/system/authlogin.if
> ===================================================================
> --- refpolicy.orig/policy/modules/system/authlogin.if
> +++ refpolicy/policy/modules/system/authlogin.if
> @@ -115,6 +115,8 @@ template(`authlogin_per_userdomain_templ
>  	allow $2 self:netlink_audit_socket { create_netlink_socket_perms
> nlmsg_relay };
>
>  	dontaudit $2 shadow_t:file { getattr read };
> +	typeattribute $2 can_read_shadow_passwords;
> +	allow $2 shadow_t:file { getattr read };
>
>  	# Transition from the user domain to this domain.
>  	domain_auto_trans($2,chkpwd_exec_t,$1_chkpwd_t)
> @@ -253,6 +255,8 @@ interface(`auth_domtrans_chk_passwd',`
>  	allow system_chkpwd_t $1:process sigchld;
>
>  	dontaudit $1 shadow_t:file { getattr read };
> +	typeattribute $1 can_read_shadow_passwords;
> +	allow $1 shadow_t:file { getattr read };
>
>  	dev_read_rand($1)
>  	dev_read_urand($1)

This is bad.  We don't want to allow such domains access to shadow_t, a 
significant aim of SE Linux is to restrict access to shadow_t.  If your PAM 
system is correctly patched then it will try to access /etc/shadow directly 
and then run a helper program which is both SETUID and has a 
domain_auto_trans() to give it the access it needs.

> Index: refpolicy/policy/modules/kernel/terminal.fc
> ===================================================================
> --- refpolicy.orig/policy/modules/kernel/terminal.fc
> +++ refpolicy/policy/modules/kernel/terminal.fc
> @@ -1,5 +1,6 @@
>
>  /dev/.*tty[^/]*		-c	gen_context(system_u:object_r:tty_device_t,s0)
> +/dev/.*tty[^/]*		-l	gen_context(system_u:object_r:tty_device_t,s0)
>  /dev/[pt]ty[abcdepqrstuvwxyz][0-9a-f]	-c
> gen_context(system_u:object_r:bsdpty_device_t,s0)
> /dev/adb.*		-c	gen_context(system_u:object_r:tty_device_t,s0)
>  /dev/capi.*		-c	gen_context(system_u:object_r:tty_device_t,s0)

Best to leave the symlinks as type device_t.  I don't think that there's any 
benefit in having different types for different symlinks, and it just means 
that more access has to be granted.  It can take ages to fix all domains that 
access certain device nodes and this alone is a good reason to minimise 
changes.

> @@ -14,6 +15,7 @@
>  /dev/rfcomm[0-9]+	-c	gen_context(system_u:object_r:tty_device_t,s0)
>  /dev/tty		-c	gen_context(system_u:object_r:devtty_t,s0)
>  /dev/ttySG.*		-c	gen_context(system_u:object_r:tty_device_t,s0)
> +/dev/tts/[0-9]		-c	gen_context(system_u:object_r:tty_device_t,s0)
>
>  /dev/pty/.*		-c	gen_context(system_u:object_r:bsdpty_device_t,s0)

Is Gentoo still using devfs device names?  If so you might want to make it 
work for more than 10 serial ports.

Also Gentoo specific changes should have ifdef(`distro_gentoo' around them.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
