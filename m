Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA12537
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2001 15:28:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA11987
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2001 19:28:36 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id TAA11983
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2001 19:28:35 GMT
Date: Fri, 8 Jun 2001 15:27:53 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Frank Zecca <frank@aimster.com>
cc: selinux@tycho.nsa.gov
Subject: Re: setting up selinux
In-Reply-To: <003601c0f04f$a3166390$cf391d18@darkbritannia.com>
Message-ID: <Pine.SOL.3.95.1010608152411.15810N-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 8 Jun 2001, Frank Zecca wrote:

> Ok I'm a little lost on this... it tells me to edit 
>security policies, but my question is where? The installation guide on
>nsa.gov is a little hard to follow :)  I've compiled the kernel OK but
>this first step seems to have thrown the whole thing off. 

If you downloaded and expanded the entire distribution, you
should have a slinux/policy directory that contains the
example security policy configuration.  The INSTALL document
says to follow the instructions relative to the slinux
directory, and it says to edit the policy/users file
for your users.  What exactly is your question?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
