Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA29909
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 11:59:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA08949
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 15:59:09 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA08945
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 15:59:07 GMT
Date: Mon, 29 Jul 2002 11:59:35 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Michelle Gosselin <mgoss@mitre.org>
cc: giovanni <giovanni@unirel.it>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Apache on SELinux
In-Reply-To: <3D456490.F870B1C7@mitre.org>
Message-ID: <Pine.GSO.4.33.0207291158310.10600-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 29 Jul 2002, Michelle Gosselin wrote:

> MITRE has written policy statements for the Apache Web Server.  A paper
> describing the Apache policy is available from both Sourceforge and the
> MITRE public server.
>
> http://selinux.sourceforge.net/devel/policy.php3
> http://www.mitre.org/support/papers/tech_papers_01/gosselin_apache/index.shtml
>
> I've also attached an apache.te file and a brief summary of the policy.
> These files will be available on Sourceforge and the MITRE public server soon.

The apache.te file is already included in the example policy that is in
the upstream SELinux release.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
