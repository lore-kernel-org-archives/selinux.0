Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA23187
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 11:47:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA08579
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 16:46:24 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA08575
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 16:46:24 GMT
Date: Wed, 20 Mar 2002 11:47:30 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Shaun Savage <savages@pcez.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: package configuration (for dpkg - rpm will have the same issues)
In-Reply-To: <20020320133514.46E8075B8@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203201145570.11981-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 20 Mar 2002, Russell Coker wrote:

> Another thing is that I need to patch setfiles to take a list of file names
> on standard input.  Checking the entire file system after replacing a single
> package does not make sense.

I'd suggest using chcon or chsid for that purpose.  Just provide a script
with each package that runs chcon/chsid with the appropriate context for
each file installed by the package.  I would also recommend updating the
setfiles configuration for any future 'make relabel' commands, but not
necessarily running it each time.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
