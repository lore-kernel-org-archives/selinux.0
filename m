Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA11363
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2001 08:37:20 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA18483
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2001 12:35:37 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id MAA18479
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2001 12:35:37 GMT
Date: Tue, 2 Oct 2001 08:36:40 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Justin R. Smith" <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Questions
In-Reply-To: <1002012936.1248.15.camel@vorpal>
Message-ID: <Pine.GSO.4.33.0110020822190.2296-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 2 Oct 2001, Justin R. Smith wrote:

> I am considering installing SELinux on my system and have a few
> questions:
>
> 1. Is extensive reconfiguration required whenever one adds new software
> to ones machine?

That depends on the software and your security objectives.  For example,
if the software package includes a program that must run with privilege,
then you will likely need to add a domain for the program or at least put
the program into an existing domain for similar programs.  If you want
to limit your software to least privilege, then you will naturally need to
define a domain and types for it.

> 2. Has anyone run SELinux with Tomcat and JSP and servlets?

We have not tried this.  I would expect that you would want to define
a domain and types for the Tomcat server, as has been done for apache by
MITRE.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
