Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA23145
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 08:46:49 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA26021
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 13:46:43 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id NAA26017
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 13:46:42 GMT
Date: Tue, 6 Nov 2001 08:46:11 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Ryan Senior <slax@ksni.net>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Problem making the kernel w/ the SELinux modules added
In-Reply-To: <3BE74419.46DBEAA@ksni.net>
Message-ID: <Pine.GSO.4.33.0111060840460.11349-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 5 Nov 2001, Ryan Senior wrote:

> I am running Red Hat 7.1 and am attempting to compile the SELinux
> additions into the kernel,  I get the following error message when it
> gets to part of the SELinux section:
>
> make[3]: Entering directory `/usr/src/selinux/module/selinux_plug/ss'
> gcc -o checkpolicy ebitmap.cp.o queue.cp.o hashtab.cp.o symtab.cp.o
> sidtab.cp.o avtab.cp.o policydb.cp.o services.cp.o y.tab.cp.o
> lex.yy.cp.o checkpolicy.cp.o -lfl
> /usr/bin/ld: cannot find -lfl
> collect2: ld returned 1 exit status

By the way, the error that you are encountering is during the linking of
the checkpolicy program.  checkpolicy is a separate userspace program that
draws heavily from the security server sources (plus the policy scanner
and parser).  In the current release (and older releases), it lives in
the security server directory and is compiled during the kernel build,
but it has now been separated out in our internal tree and will be built
separately in future releases.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
