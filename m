Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA14746
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 08:49:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA17044
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 12:48:38 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA17040
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 12:48:37 GMT
Date: Fri, 26 Jul 2002 08:49:08 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Brian May <bam@snoopy.apana.org.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy questions
In-Reply-To: <20020726030213.GB27354@snoopy.apana.org.au>
Message-ID: <Pine.GSO.4.33.0207260839350.15954-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 26 Jul 2002, Brian May wrote:

> I think it might be better, by default to only allow httpd (and user
> scripts) to access files under ~/public_html?

Yes.  Russell is already working on splitting up the home directory into
multiple types, but this is not trivial, since you need to ensure that
these multiple types are preserved.

> The writeable_t type is also a source of puzzlement to me, those files
> need to be read by most/all processes, not written!

I need to look into this further.  As I recall, many domains were
requesting write access to several files under /usr/lib/locale.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
