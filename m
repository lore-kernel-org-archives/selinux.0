Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97HSeWt013248
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 13:28:40 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h97HSd7d010612
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 17:28:39 GMT
Received: from web41011.mail.yahoo.com (web41011.mail.yahoo.com [66.218.93.10])
        by jazzband.ncsc.mil  with SMTP id h97HScRn010608 for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 17:28:38 GMT
Message-ID: <20031007172834.24557.qmail@web41011.mail.yahoo.com>
Date: Tue, 7 Oct 2003 10:28:34 -0700 (PDT)
From: Vikram K <vikramatiitkdotacdotin@yahoo.com>
Subject: A few clarifications - SID, Precondition functions
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

We had a few doubts regarding the SELinux kernel code.

1. The need for having a SID ( instead of having a
struct context* ) in
each of the *_security_struct structures. (* = task,
inode, etc.) As we
see it, the SID is just a means of referring to the
corresponding context
structure and seems to have no other utility.

2. If once an object is created, what would happen if
we change its SID.
Is it at all safe to change the SID?
(maybe because the struct context to which it was
referring has a
few fields changed and this structure is being
referred to by other
objects)

3. There is a lot of documentation about "Precondition
Functions" which
are called whenever an SID needs to be dereferenced.
This would help in
initializing security fields of objects that were
created before the
SELinux module is loaded (or starts - if SELinux is
built into the kernel)
We couldn't find these precondition functions in the
code, though. Can
anybody tell us if they have been implemented and if
yes, then in which
version?


Thanks in advance,
Vikram
Kamalneet


__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
