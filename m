Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA26167
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 14:27:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA08680
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 18:27:13 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id SAA08676
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 18:27:12 GMT
Date: Fri, 12 Jul 2002 14:27:17 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Simon Han <simonhan@ee.ucla.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: sshd 
In-Reply-To: <Pine.GSO.4.10.10207121115050.24390-100000@centauri.ee.ucla.edu>
Message-ID: <Pine.GSO.4.33.0207121424570.28541-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Jul 2002, Simon Han wrote:

> 	Before installing selinux, I used to have sshd running.  However,
> with current selinux, sshd seems to refuse starting and response following
> message
>
> Privilege separation user sshd does not exist
>
> Has anyone encounter similiar problem?  Can you give me a hand on this?

Read selinux/utils/openssh-3.4p1/README.privsep.  This isn't specific to
SELinux; the sshd pseudo user is needed by the privilege separation
support in the new OpenSSH version.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
