Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9H8BDOn027969
	for <selinux@tycho.nsa.gov>; Sat, 17 Oct 2009 04:11:13 -0400
Received: from mail-ew0-f228.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n9H8CtE0005084
	for <selinux@tycho.nsa.gov>; Sat, 17 Oct 2009 08:12:56 GMT
Received: by ewy28 with SMTP id 28so2757812ewy.18
        for <selinux@tycho.nsa.gov>; Sat, 17 Oct 2009 01:11:11 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 17 Oct 2009 11:41:09 +0330
Message-ID: <bb74313d0910170111r1fd7f59cl3556e59be1d2f7a8@mail.gmail.com>
Subject: bounds domain
From: michel m <michel.mcgregor@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

as I was studying on how to assign different security context on
threads defined in a process, I found that there is a concept named
BOUNDS DOMAIN which does this for me.
now I would like to know for implementing a userspace object manager
that uses this mechanism for its threads, how requests for OS
resources are protected. that is, if my single OS process changes its
security context per thread request or I should consult AVC before any
action taken by my threads if that action is legal.

is there any documentation on this topic?

Best Regards.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
