Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA12284
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 10:00:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA05189
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 13:59:04 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA05185
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 13:59:03 GMT
Date: Thu, 25 Apr 2002 10:00:44 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: new Debian package
In-Reply-To: <20020425134319.E0A8A3943@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204250958130.13538-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 25 Apr 2002, Russell Coker wrote:

> Also with the current Makefile rules we need the following empty files:
> file_contexts/program/custom.fc
> file_contexts/program/kernel.fc
> file_contexts/program/kmod.fc
>
> I haven't worked out how to remove this need so I've just added the empty
> files to my package.

Yes, I did the same in our internal tree (except I didn't need custom.fc,
whatever that is, and I also needed an empty mail.fc since sendmail.fc
covered both the daemon domain and the user program domains for sendmail).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
