Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA08274
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2001 12:07:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA17677
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2001 16:06:59 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id QAA17673
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2001 16:06:58 GMT
Date: Tue, 10 Apr 2001 12:06:25 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Jonathan Day <jd9812@my-deja.com>
cc: selinux@tycho.nsa.gov
Subject: Re: Assorted ramblings
In-Reply-To: <200104041841.LAA21943@mail24.bigmailbox.com>
Message-ID: <Pine.SOL.3.95.1010410120457.27235H-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>First off, any news on when the next SELinux snapshot is likely? And
>will it play nice with devfs? (The existing version can get nasty, as the
>filing system holding the devices is virtual and gets recreated on each
>boot.)

I haven't looked at devfs at all.  I would expect that we would
address it by inserting calls to obtain a SID from the security
server based on the device and then setting the SID in the inode.
But my preference would be for other people to contribute
by adding support for things like devfs or reiserfs if they
are using those features.

>Second, I'm trying to shoe-horn the SELinux kernel patch into an -ac
>kernel. (2.4.3-ac2, with the International patches applied, to be exact.)
>2.4.3 patched OK (well, apart from one #ifdef'ed comment, which doesn't
>seem too catastrophic :), but the -ac stuff is sufficiently different to
>really muck things up. Anyone tried this? And, if so, are there any
>kernel burps that crop up that I need to watch for?

I haven't tried the -ac patches, so I don't know.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com


On Wed, 4 Apr 2001, Jonathan Day wrote:

> Hi,

   First off, any news on when the next SELinux snapshot is likely? And will it play nice with devfs? (The existing version can get nasty, as the filing system holding the devices is virtual and gets recreated on each boot.)

   Second, I'm trying to shoe-horn the SELinux kernel patch into an -ac kernel. (2.4.3-ac2, with the International patches applied, to be exact.) 2.4.3 patched OK (well, apart from one #ifdef'ed comment, which doesn't seem too catastrophic :), but the -ac stuff is sufficiently different to really muck things up. Anyone tried this? And, if so, are there any kernel burps that crop up that I need to watch for?

Thanks



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
