Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA08008
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 13:01:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA17764
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 17:00:44 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA17760
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 17:00:44 GMT
Date: Mon, 15 Jul 2002 13:01:12 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Simon Han <simonhan@ee.ucla.edu>
cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fwd: locales
In-Reply-To: <Pine.GSO.4.10.10207150946250.8335-100000@centauri.ee.ucla.edu>
Message-ID: <Pine.GSO.4.33.0207151259260.29432-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 15 Jul 2002, Simon Han wrote:

> Just wonder if 'base_file_read_access(domain)' is supposed to be
>
> base_file_read_access($1)

Yes.  I posted a patch correcting this error earlier today.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
