Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA11746
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 11:35:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA10660
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 16:34:17 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA10656 for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 16:34:17 GMT
Date: Mon, 25 Feb 2002 11:34:26 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: devfs permissions
In-Reply-To: <20020224121902.AC8E4286E3@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0202251133330.16566-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 24 Feb 2002, Russell Coker wrote:

> Another potential solution is to keep the current method of assigning SIDs to
> devfs nodes, but use it only for the early stages of boot after which devfsd
> takes over.

I'm inclined toward this approach.

> For interest I have attached the latest devfs_contexts file I am using.  I
> have attempted to make it give the same result as the file_contexts entries
> for non-devfs systems as much as possible (but as it doesn't do regular
> expressions it's impossible to distinguish between CDs and hard drives).

Thanks, merged.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
