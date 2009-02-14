Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1E2ftu7019765
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 21:41:55 -0500
Received: from smtp108.prem.mail.sp1.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n1E2cWDH010007
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2009 02:38:37 GMT
Message-ID: <49962F60.3090206@schaufler-ca.com>
Date: Fri, 13 Feb 2009 18:41:36 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: chanson@TrustedCS.com
CC: paul.moore@hp.com, refpolicy@oss.tresys.com, selinux@tycho.nsa.gov
Subject: Re: [refpolicy] [PATCH] refpolicy: Add missing network related MLSconstraints
References: <20090212211531.619341973@hp.com> <170D6ABBBA770349AA49582A86FCED15BA0199@HAVOC.tcs-sec.com>
In-Reply-To: <170D6ABBBA770349AA49582A86FCED15BA0199@HAVOC.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

chanson@TrustedCS.com wrote:
>  
> Traditionally network objects in a MLS system are not usually subject to
> the usual privilege overrides.
Hum. That wasn't true of Trusted Irix where sockets were the network
objects.
Of course, you can only apply privilege on the sending end because the
privilege state isn't transmitted.

On Smack the network object is the process, and privilege is required to
muck with the attributes of your own sockets, but otherwise it's the same,
again the privilege isn't getting transmitted, so you can't determine if
it's there on the other end.

If you want to transmit the privilege state, and SELinux (appears to)
allow that, you really ought to allow for that on the other end.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
