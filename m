Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA28315
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 10:07:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA29963
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 14:06:26 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA29959 for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 14:06:26 GMT
Date: Tue, 9 Jul 2002 10:07:01 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: automatic type transitions for pts in devfs
In-Reply-To: <3D2AE806.7020106@evoworks.evoserve.com>
Message-ID: <Pine.GSO.4.33.0207091003250.27193-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 9 Jul 2002, Debian User wrote:

> Are all the stuff involved in this restricted to hooks.c?

You can implement a quick-and-dirty solution entirely by modifying
hooks.c.  A more general solution will require changes to the security
server and the policy configuration to support such hybrid schemes.

> Im afraid im not familiar with lsm. I have
> to look for an introduction somewhere.

lsm.immunix.org has some documentation about LSM.  The NSA SELinux site
has a technical report describing the implementation of the LSM-based
SELinux module, although it is not entirely up-to-date.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
