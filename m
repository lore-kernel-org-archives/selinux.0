Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA29962
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2001 08:26:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA21840
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2001 12:26:22 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id MAA21836
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2001 12:26:22 GMT
Date: Wed, 29 Aug 2001 08:26:02 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: policy configurations files
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A1015241D5@csoc-mail-box.csoconline.com>
Message-ID: <Pine.SOL.3.95.1010829082053.19714A-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 28 Aug 2001, Westerman, Mark wrote:

> file: domains/user/user.te
> 
> define(`user_domain',`
> ....
> sinclude(includes/user-common.inc)
> ....
> ')

The problem is that the sinclude is within the quotes, so it is
not being expanded until the substitution occurs.  You need to 
unquote the sinclude so that it is expanded as part of the macro
definition, e.g.:

define(`user_domain',`
....
'
sinclude(includes/user-common.inc)
`
....
')

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
