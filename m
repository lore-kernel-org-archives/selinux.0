Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6149VPq029557
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 00:09:31 -0400
Received: from qw-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6149EdJ011453
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 04:09:14 GMT
Received: by qw-out-1920.google.com with SMTP id 4so333168qwk.30
        for <selinux@tycho.nsa.gov>; Tue, 30 Jun 2009 21:09:31 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 1 Jul 2009 12:09:31 +0800
Message-ID: <2cd8d8530906302109g57ece921i8a9fcd72261c6f88@mail.gmail.com>
Subject: Problem about PAM-selinux
From: Andy <hewanxiang@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, all,
I have a pam-selinux problem. I know I should post it to pam list, but
no response from them.

Things happened like this:
I want to upgrade my pam in Fedora Core 6,  when I make my
Linux-PAM-1.1.0, I encountered a error.

pam_selinux.c: In function `mls_range_allowed':
pam_selinux.c:239: error: `CONTEXT__CONTAINS' undeclared (first use in
this function)
pam_selinux.c:239: error: (Each undeclared identifier is reported only once
pam_selinux.c:239: error: for each function it appears in.)
pam_selinux.c:246: error: `SECCLASS_CONTEXT' undeclared (first use in
this function)

And I grep "CONTEXT__CONTAINS" in the whole Linux-PAM-1.1.0 source
code packet, nowhere defines it.
It seems to be some issues about selinux.
Anybody can give me a help ?  Thanks.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
