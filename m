Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA26767
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2001 12:09:56 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA29009
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2001 17:09:22 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA29005
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2001 17:09:20 GMT
Date: Thu, 4 Jan 2001 12:08:25 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Harald von Fellenberg - Sun Switzerland Zurich - Technology Strategy Office <Harald.Von-Fellenberg@swiss.sun.com>
cc: selinux@tycho.nsa.gov
Subject: Re: Missing header files
In-Reply-To: <200101041638.RAA10295@ezrh04.Swiss.Sun.COM>
Message-ID: <Pine.SOL.3.95.1010104115102.3571K-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Thu, 4 Jan 2001, Harald von Fellenberg - Sun Switzerland Zurich - Technology Strategy Office wrote:

> I am trying to compile, of course. However, I seem to lack a few header files:
> namely the files 
> slinux/utils/pwdb-0.60/include/pwdb/pwdb_{unix,shadow,common}.h, all of which 
> are called from slinux/utils/pwdb-0.60/include/pwdb/pwdb_map.h
> Or did I miss something else?

On our RedHat 6.1 systems, the pwdb_{unix,shadow,common}.h header files
are picked up from the existing /usr/include/pwdb directory.  The only
modification that was made to the RedHat 6.1 pwdb package was to
change the location of the shadow password file in
libpwdb/pwdb/pwdb_config.h.  This is discussed in Section 3.3.3 of the
policy document.  See the discussion of the etc_auth_t type and the
shadow password file at the bottom of the first paragraph on page 8 of
that document.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
