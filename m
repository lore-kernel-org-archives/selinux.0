Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i53CgRrT011263
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 08:42:28 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i54CgBTV002528
	for <selinux@tycho.nsa.gov>; Fri, 4 Jun 2004 08:42:11 -0400 (EDT)
Subject: Re: issue with SE/Linux - sshd not giving access to /dev/pts/[n]
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200406031404.35028.russell@coker.com.au>
References: <20040601090345.GM8312@lkcl.net>
	 <200406021631.50230.russell@coker.com.au>
	 <1086196986.15871.106.camel@moss-spartans.epoch.ncsc.mil>
	 <200406031404.35028.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1086266468.17657.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 03 Jun 2004 08:41:08 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-06-03 at 00:04, Russell Coker wrote:
> I don't think it occurred on 3.6.x.  It occurs on both Fedora and Debian, but 
> does not always happen.  I'm not sure of the exact cause.

Fedora is still using openssh 3.6.  Are you sure it occurs on Fedora?

In any event, looking briefly at 3.6 vs. 3.8, I see that:
1) in 3.6, session.c:do_exec_pty() calls do_pam_session() with the
username and tty.  auth-pam.c:do_pam_session() then sets PAM_TTY prior
to calling pam_open_sesson(), so the tty is available to pam_selinux for
relabeling.
2) in 3.8, session.c:do_setusercontext() calls do_pam_session() with no
arguments, and auth-pam.c:do_pam_session() calls pam_open_session()
without setting PAM_TTY (as no information is available at this point),
so pam_selinux lacks the tty information.  
The implication is that pam_selinux cannot perform tty relabeling for
openssh 3.8.  Thus, we must revert to using a direct patch.  Someone
want to port the old 3.6 patch?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
