Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA21678
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 07:50:09 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA03280
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 11:48:38 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA03276 for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 11:48:38 GMT
Date: Tue, 23 Jul 2002 07:49:10 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Rogelio M. Serrano Jr." <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: busybox policy and multicall binaries
In-Reply-To: <Pine.LNX.4.44.0207231743590.17801-100000@coffeesaur2.evoserve.com>
Message-ID: <Pine.GSO.4.33.0207230738550.29998-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 23 Jul 2002, Rogelio M. Serrano Jr. wrote:

> Whats the best way to handle multicall binaries like busybox? The basic
> problem is that the context used in permission checking is the context of
> the main binary instead of the links. The policy I have right now is a
> little too permissive. I tried using wrappers for security relevant
> applets but i find it too heavy in an embedded system. The average size of
> the wrappers is 3k. I also tried hard links which looks promising but I
> am not familiar with the issues related to links to executables. I am
> considering modifying busybox to make it more of a shared library, so i
> can create skeleton programs that get its functionality from the library.
> That way I can assign permissions to the skeleton programs in a way thats
> external to busybox.

A file security context is bound to an inode, not a link name, so using
multiple hard links does not permit you to associate multiple file
security contexts with a single executable file.  However, you can
run a single executable file in multiple process contexts.  This can
happen either by default when the program is executed by processes that
are originally in different contexts (e.g. netscape is run in different
domains depending on the domain of the caller) or by explicit request
using execve_secure (e.g. exec_s or runas).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
