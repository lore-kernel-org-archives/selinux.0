Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA12850
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 13:25:58 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA16573
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 18:24:59 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA16569 for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 18:24:58 GMT
Date: Mon, 25 Feb 2002 13:25:18 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: devfs permissions
In-Reply-To: <20020225181326.AD2C713553@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0202251322430.16566-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 25 Feb 2002, Russell Coker wrote:

> new hardware or drivers).  On a devfs system there are only three programs
> that should create anything under /dev, they are init, the devfsd startup
> script, and devfsd itself.

So what happens to other programs that try to create sockets in /dev?  Are
they transparently redirected through devfsd?

Given the behavior you describe, it doesn't sound as though the existing
file_type_auto_trans rules for runtime files in /dev would work anyway
when using devfs, so perhaps it doesn't matter that you are using devfs_t.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
