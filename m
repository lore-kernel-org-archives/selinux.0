Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA14206
	for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2001 12:51:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA26883
	for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2001 17:51:24 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id RAA26879
	for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2001 17:51:22 GMT
Date: Fri, 2 Mar 2001 12:50:22 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Mark Slagell <ms@iastate.edu>
cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Adding users
In-Reply-To: <3A9FD9A4.D05B301E@iastate.edu>
Message-ID: <Pine.SOL.3.95.1010302124755.3984P-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


You need to do a 'make load' in the policy directory to load the
new policy configuration.  

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com


On Fri, 2 Mar 2001, Mark Slagell wrote:

> Hi all,
> 
> Just tried adding a new user, the first one besides those that were in
> place when installing SELinux. Did useradd -m username, then added the
> relevant info to policy/users and to /etc/security/default_context. 
> When logging the user on for the first time it would prompt with the
> correct default context, but then say "That security context is invalid"
> regardless of whether the default was used or something else entered. 
> Tried doing "make install" in the policy directory, no effect. Then
> rebooted and everything was fine, the new user could log in normally.
> 
> Surely the reboot shouldn't have been necessary (this ain't Windows) -
> what did I miss?
> 
>   Mark


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
