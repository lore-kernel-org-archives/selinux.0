Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA19163
	for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 07:46:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA01218
	for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 11:45:58 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA01185
	for <selinux@tycho.nsa.gov>; Wed, 17 Jul 2002 11:45:58 GMT
Date: Wed, 17 Jul 2002 07:45:56 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ryan Bergauer <privateryan@mindspring.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: user mount permissions
In-Reply-To: <000001c22cfa$cf985bb0$0300a8c0@donkey>
Message-ID: <Pine.GSO.4.33.0207170742190.18645-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 16 Jul 2002, Ryan Bergauer wrote:

> I'm want to allow users to be able to mount an encrypted directory in
> their home directory. Unfortunately, this requires allowing normal users
> to transition into mount_t via a mount executable, which I think would
> be wise to avoid. Is there a good way to allow users to mount only a
> certain type, say user_home_t (or in my case, crypt_home_t)? Thanks!

You could create a user_mount_t domain (copied from mount_t, defining a
domain transition to it from user_t, and then reducing the permissions).
You may be able to use the directory 'mounton' and the filesystem 'mount'
permissions to limit the user to particular types, but I'm not sure about
the specific permission requirements for what you describe.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
