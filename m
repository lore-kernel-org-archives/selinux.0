Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA16973
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2001 10:30:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA07298
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2001 14:30:41 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA07294
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2001 14:30:41 GMT
Date: Mon, 21 May 2001 10:29:29 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Jonathan Day <jd9812@my-deja.com>
cc: selinux@tycho.nsa.gov
Subject: RE: Re[2]: SELinux as a desktop / workstation?
In-Reply-To: <200105211333.GAA01899@mail6.bigmailbox.com>
Message-ID: <Pine.SOL.3.95.1010521102035.26161D-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>SELinux would certainly help (in that it would quarantine any infected
>region), but that is not its primary role.

I haven't been following this thread closely, but I get the
impression that there may be some misunderstandings on this topic.  Since
SELinux can be used to confine an application to least privilege, it can 
be very effective at limiting the potential damage that can be done either
by a malicious application or by an exploit of a flaw (e.g. a buffer
overflow) in a legitimate application.  SELinux can also be used to
protect the integrity of system software, configuration files, and logs.
And it can be used to protect users from executing untrustworthy software.

>BTW, since this is a SELinux mailing list, I'll throw in the obligatory
>plea. Is SELinux holding off for 2.4.5, or will we see a 2.4.4 version?

We are waiting for 2.4.5.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
