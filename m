Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA11029
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 11:02:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA19184
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 15:01:44 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id PAA19180 for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 15:01:44 GMT
Date: Fri, 19 Apr 2002 11:02:34 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
In-Reply-To: <20020418183258.B7029@lemuria.org>
Message-ID: <Pine.GSO.4.33.0204191055190.18117-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 18 Apr 2002, Tom wrote:

> If that is so, then my question is answered. Is execution really the
> only point for a domain transition? That would make sense, but I also
> see reasons for doing transitions during other file access operations
> (e.g. maybe you want to get a higher protection level while certain
> files are open).

I answered the more general question (can a process change its own SID) in
the following message:
http://marc.theaimsgroup.com/?l=selinux&m=101343633303503&w=2

This is also discussed in the original design document, and is a criteria
for secure systems identified in the background documents (in particular,
the DTOS General System Security and Assurability Assessment Report,
available from
http://www.cs.utah.edu/flux/fluke/html/dtos/HTML/technical-docs.html).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
