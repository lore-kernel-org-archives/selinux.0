Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA10003
	for <selinux@tycho.nsa.gov>; Thu, 27 Feb 2003 07:55:48 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA22471
	for <selinux@tycho.nsa.gov>; Thu, 27 Feb 2003 12:52:18 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-156.nas-smoothtransition.com [66.95.157.156] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id MAA22466
	for <selinux@tycho.nsa.gov>; Thu, 27 Feb 2003 12:52:17 GMT
From: "david caplan" <dac@tresys.com>
To: "Russell Coker" <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: RE: sendmail policy
Date: Thu, 27 Feb 2003 07:54:50 -0500
Message-ID: <GBEAJBKHFOBIBBJBCGAGCEOOCJAA.dac@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200302271121.27632.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When I remove that capability I get:

 avc:  denied  { name_bind } for  pid=14564 exe=/usr/sbin/sendmail port=6400
scontext=root:sysadm_r:sysadm_mail_t tcontext=system_u:object_r:smtp_port_t
tclass=tcp_socket

That's on an older machine (sendmail policy is pre-Coker mods, 2.4.18
kernel/policy).  It was set up to run as a sendmail server, but I'm not sure
how well configured/correct it is at this point.  Sendmail fails to start in
enforcing mode without that capability. If I toggle the box into permissive
mode, sendmail starts and still appears to work (i.e., it sends and receives
mail) when I toggle it back to enforcing mode.  I'm not real familiar with
configuring sendmail, and I couldn't tell from a quick search what it wants
to do with port 6400.

The line in the sendmail macro file in that version of the policy was:

allow $1_mail_t $1_mail_t:capability { setuid setgid net_bind_service
chown };

David

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
> Behalf Of Russell Coker
> Sent: Thursday, February 27, 2003 5:21 AM
> To: selinux@tycho.nsa.gov
> Subject: sendmail policy
>
>
> # Use capabilities
> allow $1_mail_t self:capability net_bind_service;
>
> Why is the above in macros/program/sendmail_macros.te?
>
> I may have written the policy like that to keep the functionality of the
> previous sendmail policy.  However I don't have a Sendmail machine for
> testing and I can't think of any good reason for allowing such access.
>
> Maybe this should be removed?
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
