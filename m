Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA18518
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 07:15:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA21105
	for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 11:13:39 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA21101 for <selinux@tycho.nsa.gov>; Mon, 8 Jul 2002 11:13:39 GMT
Date: Mon, 8 Jul 2002 07:14:54 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ed Street <blacknet@simplyaquatics.com>
cc: Selinux <selinux@tycho.nsa.gov>
Subject: Re: /tmp and others
In-Reply-To: <004f01c22302$150ebf70$0a01a8c0@ed>
Message-ID: <Pine.GSO.4.33.0207080711400.19100-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 3 Jul 2002, Ed Street wrote:

> I'm curious as to how Selinux deals with /tmp issues like exploits.
> Also how does Selinux deal with stack exploits and /proc exploits?

SELinux isn't exploit-specific.  It provides a general mechanism for
confining processes to least privilege.  This can be applied in many
different ways.  For /tmp files, you can use SELinux to provide rigorous
separation of temporary files created by different domains through the use
of file type transition rules.  For buffer overflows, you can use SELinux
to confine each system service (e.g. apache, sendmail, etc) to only
accessing the objects and services required for its job so that exploits
are strictly confined.  For /proc, you can use the SELinux file access
controls to limit access to only authorized domains.  Keep in mind that
the Linux root user has no special privileges with respect to the SELinux
access controls.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
