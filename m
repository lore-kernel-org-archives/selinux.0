Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA27488
	for <selinux@tycho.nsa.gov>; Tue, 17 Sep 2002 10:04:04 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA01923
	for <selinux@tycho.nsa.gov>; Tue, 17 Sep 2002 14:02:36 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA01916
	for <selinux@tycho.nsa.gov>; Tue, 17 Sep 2002 14:02:35 GMT
Date: Tue, 17 Sep 2002 10:03:48 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <tim@bird.org>, <selinux@tycho.nsa.gov>
Subject: Re: Fwd: Re: Any assured channel work for Linux
In-Reply-To: <200209170051.51285.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0209170959220.11411-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 17 Sep 2002, Russell Coker wrote:

> For secure networking you need encryption of course.  SE Linux apparently has
> some support for labelled networking over IPSec, but I haven't got IPSec
> working yet so I don't know what it does exactly.

Unfortunately, FreeSWAN does not presently support IP options.  Hence, the
Selopt labeled networking support does not work with FreeSWAN IPSEC.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
