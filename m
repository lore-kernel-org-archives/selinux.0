Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA00241
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 09:35:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA22633
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 14:34:36 GMT
Received: from jsmith.org (pool-141-158-43-243.phil.east.verizon.net [141.158.43.243])
	by jazzband.ncsc.mil  with ESMTP id OAA22629
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 14:34:35 GMT
Subject: Re: simple Perl script to converse messages to access rules
From: Justin Smith <jsmith@mcs.drexel.edu>
To: Stephen Smalley <sds@tislabs.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <Pine.GSO.4.33.0112040913380.28408-100000@raven>
References: <Pine.GSO.4.33.0112040913380.28408-100000@raven>
Content-Type: text/plain
Date: 04 Dec 2001 09:32:43 -0500
Message-Id: <1007476363.2135.0.camel@jsmith.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2001-12-04 at 09:24, Stephen Smalley wrote:
> While this script should be helpful in customizing the policy
> configuration, you should carefully examine its output to ensure that the
> resulting rules do not violate your security objectives.  Frequently,
> rather than granting the permission between the existing domain and type,
> you will want to define a new domain for the process and/or a new type for
> the file and only grant the permission for the new domain and/or type.
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 
> 

I envisioned this script as a quick and dirty way to get a system
working in enforcing mode AFTER one has defined a bunch of new domains
(that trigger lots of denied messages).

Naturally users should examine the output of this script to confirm that
it will do what they want. 

One great thing about SELinux is that it gives a detailed account of
what is taking place in a system. For instance, I discovered that web
users were trying to access files over symbolic links via my web server.
I hadn't been aware that my web server had symbolic link access enabled.
--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
