Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA23087
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 08:34:49 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA21265
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 13:34:14 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id NAA21261
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 13:34:13 GMT
Date: Tue, 6 Nov 2001 08:34:30 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Ryan Senior <slax@ksni.net>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Problem making the kernel w/ the SELinux modules added
In-Reply-To: <3BE74419.46DBEAA@ksni.net>
Message-ID: <Pine.GSO.4.33.0111060832020.11349-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 5 Nov 2001, Ryan Senior wrote:

> I am running Red Hat 7.1 and am attempting to compile the SELinux
> additions into the kernel,  I get the following error message when it
> gets to part of the SELinux section:

> /usr/bin/ld: cannot find -lfl
> collect2: ld returned 1 exit status

'fl' refers to the flex library.  On my RedHat 7.1 systems, libfl.a is in
/usr/lib.

As a side note, the 2.4.14 kernel is out, so a new SELinux release
shouldn't be too far in the future.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
