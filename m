Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jACA9HMA018179
	for <selinux@tycho.nsa.gov>; Sat, 12 Nov 2005 05:09:17 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jACA2NBT009518
	for <selinux@tycho.nsa.gov>; Sat, 12 Nov 2005 10:02:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: Small patch for runuser: disallow suid operation
Date: Sat, 12 Nov 2005 21:02:11 +1100
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <20051019201719.GA9176@thorium.jmh.mhn.de>
In-Reply-To: <20051019201719.GA9176@thorium.jmh.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200511122102.18638.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 20 October 2005 06:17, Thomas Bleher 
<bleher@informatik.uni-muenchen.de> wrote:
> I think the following small patch should be applied to the coreutils
> package, on top of the existing patch:

Sounds reasonable to me.  Have you filed a bugzilla?

> --- runuser.c.orig	2005-10-19 22:01:57.000000000 +0200
> +++ runuser.c	2005-10-19 22:00:53.000000000 +0200
> @@ -19,6 +19,8 @@
>  	return PAM_SUCCESS;
>  }
>  int pam_open_session(pam_handle_t *pamh, int flags){
> +	if (getuid() != geteuid()) /* safety net: deny operation if we are suid
> by accident */ +		error(EXIT_FAIL, 1, "runuser may not be setuid");
>  	return PAM_SUCCESS;
>  }
>  int pam_close_session(pam_handle_t *pamh, int flags){

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
