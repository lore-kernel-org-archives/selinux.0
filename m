Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA05431
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 08:15:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA18908
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 12:14:20 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA18904 for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 12:14:20 GMT
Date: Mon, 15 Jul 2002 08:15:45 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fwd: locales
In-Reply-To: <20020715045504.19D666DD8@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0207150804500.29432-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 15 Jul 2002, Russell Coker wrote:

> I suggest making the following change seeing as so many programs
> require read access to the locale files:
>
> (still to resolve: execute permission for /usr/lib/gconv/*.so)

Access to writeable_t is granted by the general_file_write_access()
macro.  'allow domain' rules should be minimized or completely avoided, as
they prevent people from writing domains that are truly limited to least
privilege.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
