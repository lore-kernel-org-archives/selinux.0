Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA00900
	for <selinux@tycho.nsa.gov>; Thu, 1 Nov 2001 07:23:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA18646
	for <selinux@tycho.nsa.gov>; Thu, 1 Nov 2001 12:23:31 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA18642
	for <selinux@tycho.nsa.gov>; Thu, 1 Nov 2001 12:23:30 GMT
Date: Thu, 1 Nov 2001 07:22:32 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: 2.4.13?
In-Reply-To: <20011031215347.1D3698D2@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0111010710350.18915-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 31 Oct 2001, Russell Coker wrote:

> Are you planning to release a 2.4.13 patch for selinux any time soon?
>
> I am wondering whether I should delay my work and wait for it or whether I
> should apply the 2.4.12 patch to 2.4.13 and keep going...

We updated internally to lsm-2001_10_24 against 2.4.13 back when it came
out, but the NSA didn't make a new release, probably because we had just
released on 10/16 and new stable versions seem to be rather frequent right
now.  Looks like 2.4.14 might be out soon, so I would expect us to wait
for it.  If you really need a patch for 2.4.13 now, let me know - as I
recall, you'll need a patch to the SELinux module to add a new hook
defined by lsm-2001_10_24.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
