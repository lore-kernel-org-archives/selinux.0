Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA19053
	for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 07:34:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA00745
	for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 11:33:56 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA00741
	for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 11:33:56 GMT
Date: Wed, 17 Jul 2002 07:34:03 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Rogelio M. Serrano Jr." <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: cant gain sysadm_r via ssh
In-Reply-To: <Pine.LNX.4.44.0207170806270.444-100000@coffeesaur>
Message-ID: <Pine.GSO.4.33.0207170733160.18645-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 17 Jul 2002, Rogelio M. Serrano Jr. wrote:

> Im phasing out devfsd in my system. Thats why Im trying to access the
> devices directly. I laso dont want to add permissions for accessing links
> all over my policy. I thought pppd had access permissions to access ttySn
> devices so I thought I give the same type to tts/n devices but I could not
> find any except devtty_t.

You may want to define a new type for this purpose, and update the pppd
domain accordingly.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
