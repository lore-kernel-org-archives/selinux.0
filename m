Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA03835
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2002 14:19:18 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA00482
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2002 19:18:17 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA00478
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2002 19:18:16 GMT
Date: Fri, 22 Feb 2002 14:18:24 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Samarth  Sharma <samarth7880@rediffmail.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Re: 2.2 kernel series
In-Reply-To: <20020222190022.28134.qmail@mailweb20.rediffmail.com>
Message-ID: <Pine.GSO.4.33.0202221406150.27259-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 22 Feb 2002, Samarth  Sharma wrote:

> which FAQ are u talking about.
> do u have any documentation on mandatory control specifically for IPSEC.

The SELinux FAQ is available at http://www.nsa.gov/selinux/faq.html.  But
that isn't related to the issue of IPSEC.

If you are looking for a discussion of integrating IPSEC with mandatory
access controls, I'd suggest the following master's thesis about similar
work done in Flask, a predecessor of SELinux:
http://www.cs.utah.edu/flux/papers/ajay-thesis-abs.html

SELinux is not integrated with IPSEC, although you can use FreeSWAN
orthogonally with SELinux to protect network communications, modulo
some policy customization for the FreeSWAN utilities and daemon.

An implementation by James Morris of labeled IPv4 networking using CIPSO
is available from http://www.intercode.com.au/jmorris/selopt, and will be
included with future SELinux releases.  Naturally, you would still want to
use IPSEC to protect labeled traffic.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
