Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA07486
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 09:11:22 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA12906
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 13:10:17 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA12899
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 13:10:17 GMT
Date: Mon, 19 Aug 2002 09:10:34 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Brad Chapman <jabiru_croc@yahoo.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: psidfiles_init errors
In-Reply-To: <20020819123146.CC96F2D5@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208190909060.14458-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 19 Aug 2002, Russell Coker wrote:

> In that case why not just remove the error message on boot?  If this is the
> desired functionality then surely our log files don't need to get filled
> because of it.

I suppose we could disable printing of these messages by default.
Historical note:  The messages used to only occur once, and then the
entries would be purged, but that had to change to support the initrd
functionality that you wanted.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
