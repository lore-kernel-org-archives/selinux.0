Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA02381
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 14:41:20 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA21396
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 19:39:58 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA21390
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2002 19:39:57 GMT
Date: Thu, 21 Mar 2002 14:41:09 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: addition for xdm.te
In-Reply-To: <20020321155442.2550225CCC@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203211437180.19336-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 21 Mar 2002, Russell Coker wrote:

> I think it makes more sense to have all the xdm policy in the xdm file.  Then
> someone who doesn't use a xdm type program can remove the file and everything
> else will be fine.

This isn't as straightforward as it might appear.  Consider the
xdm-related rules in user_macros.te and netscape_macros.te.  We can
relocate those rules to xdm.te through the use of type attributes (to
cover all user domains and all netscape domains), but you then have a
little piece of the netscape policy in the xdm.te file.  Perhaps that is
more acceptable than having a little piece of the xdm policy in the
netscape_macros.te file.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
