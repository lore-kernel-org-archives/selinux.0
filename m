Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA25453
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 15:51:31 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA22301
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 20:50:09 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id UAA22295
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 20:50:09 GMT
Date: Wed, 20 Mar 2002 15:51:06 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: uses_shlib
In-Reply-To: <20020320102215.9DEB4232E@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203201550290.11981-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 20 Mar 2002, Russell Coker wrote:

> The libc on my system uses a file named /etc/ld.so.preload.
> I have added the following line to my file_contexts:
> /etc/ld.so.preload              system_u:object_r:ld_so_t

You mean ld_so_cache_t not ld_so_t, right?

> Also I added the following to uses_shlib():
> allow $1 ld_so_cache_t:file r_file_perms;

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
