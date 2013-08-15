Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r7FBSilN010312
	for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2013 07:28:44 -0400
Received: by mail-wi0-f170.google.com with SMTP id hi8so392789wib.3
        for <selinux@tycho.nsa.gov>; Thu, 15 Aug 2013 04:28:42 -0700 (PDT)
Date: Thu, 15 Aug 2013 13:27:26 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: setools and gold linker
Message-ID: <20130815112726.GA1104@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all

I have a bug report regarding SETools not being able to build when the "gold
linker" is used [1]. The build output is as follows:

x86_64-pc-linux-gnu-ranlib libqpol.a
/usr/lib/gcc/x86_64-pc-linux-gnu/4.7.2/../../../../x86_64-pc-linux-gnu/bin/ld:
error: symbol qpol_policy_open_from_memory has undefined version 
collect2: error: ld returned 1 exit status

It doesn't like the following (unversioned) symver:

__asm__(".symver qpol_policy_open_from_memory_old,qpol_policy_open_from_memory@");

Handling these things is a bit beyond my comprehension, so I'm asking here.
Would it be a good idea to, like the FUSE example mentioned in the
bugreport, create a QPOL_UNVERSIONED in libqpol.map (with no content) and
refer to that, like so:

__asm__(".symver qpol_policy_open_from_memory_old,qpol_policy_open_from_memory@QPOL_UNVERSIONED");

Same of course for the other unversioned ones.

Wkr,
	Sven Vermeulen

[1] https://bugs.gentoo.org/show_bug.cgi?id=467136

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
