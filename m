Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA25905
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 14:33:49 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA11697
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 19:32:42 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA11691
	for <selinux@tycho.nsa.gov>; Wed, 27 Feb 2002 19:32:41 GMT
Date: Wed, 27 Feb 2002 14:33:19 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Metrix <metrix007@yahoo.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: your mail
In-Reply-To: <20020227190209.4638.qmail@web20604.mail.yahoo.com>
Message-ID: <Pine.GSO.4.33.0202271429230.12300-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 27 Feb 2002, Metrix wrote:

> with selinux is it possible to say make a file or
> directory unable to be viewed, deleted or moved, or
> even altered, the ONLY operation allowed is
> appending....is this possible to implement with
> selinux?

You can certainly define a type, only grant append permission to it in
the policy configuration, and label a file with it.

> i am a bit unsure oh what MAC and such is, is there a
> guide somewhere that clearly explains it?

I'd suggest reading the papers available from
http://www.nsa.gov/selinux/docs.html.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
