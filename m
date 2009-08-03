Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n73FfvCT013587
	for <selinux@tycho.nsa.gov>; Mon, 3 Aug 2009 11:41:57 -0400
Received: from mail-ew0-f211.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n73FfTY5006609
	for <selinux@tycho.nsa.gov>; Mon, 3 Aug 2009 15:41:30 GMT
Received: by ewy7 with SMTP id 7so1220095ewy.18
        for <selinux@tycho.nsa.gov>; Mon, 03 Aug 2009 08:41:55 -0700 (PDT)
Message-ID: <4A770542.3050103@gmail.com>
Date: Mon, 03 Aug 2009 08:41:54 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: best way to comile userspace to use lib64 for x86_64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As an experimanet I'm building an x86_64 system, in doing so
I'm noticing I need to have the libs point to /lib64 and /usr/lib64
what is the easiest way to do this for the
userspace from git. looking at the Makefiles seems a bit confusing,
using LIBDIR=/lib64 does make /usr/lib64 but does not  make /lib64.

any ideas?

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
