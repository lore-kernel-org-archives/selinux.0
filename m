Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA15023
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 12:58:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA02068
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 16:56:57 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA02064
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 16:56:57 GMT
Date: Wed, 23 Oct 2002 12:57:47 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: kernel compile error with latest ver
In-Reply-To: <200210231831.57210.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210231256040.7042-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 23 Oct 2002, Russell Coker wrote:

> The ip_warn() macro defined in selopt.h seems to demand at least 3 parameters
> but in selopt.c it's often given only 2...

selopt compiles fine for me either built-in or as a module, and the only
thing that changed about the ip_warn() definition was fixing the handling
of __FUNCTION__.  What version of gcc are you using and what is the
precise output from gcc?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
