Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA12407
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 12:41:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA14148
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 17:40:35 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA14144 for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 17:40:35 GMT
Date: Mon, 25 Feb 2002 12:40:32 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: devfs permissions
In-Reply-To: <20020224121902.AC8E4286E3@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0202251238390.16566-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 24 Feb 2002, Russell Coker wrote:

> In either case we need to have devfsd manage SIDs on devfs nodes, currently
> /dev/initctl and /dev/log don't get assigned a SID on devfs (also other pipes
> and sockets would have the same problem - but aren't as important and don't
> fail as spectacularly).

Files created at runtime, such as /dev/initctl and /dev/log, should be
labeled based on the file_type_auto_trans() rules that already exist for
the appropriate domains.  Of course, the current rules assume that the
parent directory type is device_t.  I see that you changed the / entry in
devfs_contexts from device_t to devfs_t.  I'm not sure I agree with that
change - it will require additional file_type_auto_trans rules for the
devfs case.  Why not use device_t for both devfs and traditional /dev?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
