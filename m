Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA14565
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 08:21:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA04455
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 12:20:18 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA04451 for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 12:20:17 GMT
Date: Thu, 11 Jul 2002 08:20:54 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: automatic type transitions for pts in devfs
In-Reply-To: <20020711032626.549F481F9E@coffeesaur2.evoserve.com>
Message-ID: <Pine.GSO.4.33.0207110817300.822-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 11 Jul 2002, Debian User wrote:

> my patch works with russell's devfsd-se.so disabled. just remove any selinux*
> file in /etc/devfs/conf.d. i will see if removing only the pts entry in the selinux
> conf.d file will work.

This makes sense.  As long as devfsd does not intercept the registration
of pts nodes and perform a lookup at that time, your patch should work for
labeling pts nodes with transition SIDs.

This is good, as it removes the immediate need to patch devfsd.  However,
it will still be necessary to patch the kernel devfs code to preserve SIDs
on devfs entries when they are evicted from the dcache.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
