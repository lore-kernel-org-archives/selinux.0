Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA01423
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 13:38:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA28621
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 17:36:33 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA28617 for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 17:36:32 GMT
Date: Mon, 26 Aug 2002 13:37:12 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: patch
In-Reply-To: <20020826003627.2259F74D7@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208261335090.24426-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 26 Aug 2002, Russell Coker wrote:

> This patch adds some new attributes and appropriate use of them.  Also it
> corrects some errors in attribute usage.

Two other changes to this patch:
1) The patch omitted the necessary corresponding change to can_create_pty.
2) The patch left some redundant ssh-related rules later in user_macros.te
after adding duplicates to an earlier ssh-related section.

These should now be fixed in CVS.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
