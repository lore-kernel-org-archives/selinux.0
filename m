Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA18856
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 10:20:36 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA07292
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 14:18:48 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA07286
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 14:18:47 GMT
Date: Fri, 26 Apr 2002 10:19:40 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: crond_domain()
In-Reply-To: <20020425232129.C32464646@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204261018420.24756-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 26 Apr 2002, Russell Coker wrote:

> In the crond_domain() macro, shouldn't we have the following line?
>
> file_type_auto_trans($1_crond_t, tmp_t, $1_tmp_t)

Yes, good point.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
