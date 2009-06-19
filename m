Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5JLA1Bb025930
	for <selinux@tycho.nsa.gov>; Fri, 19 Jun 2009 17:10:01 -0400
Received: from mail-gx0-f211.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5JL9mqI012722
	for <selinux@tycho.nsa.gov>; Fri, 19 Jun 2009 21:09:48 GMT
Received: by gxk7 with SMTP id 7so3021981gxk.18
        for <selinux@tycho.nsa.gov>; Fri, 19 Jun 2009 14:09:59 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 19 Jun 2009 14:02:12 -0700
Message-ID: <dd18b0c30906191402o12100191x10dac3abcfbbcb56@mail.gmail.com>
Subject: SELinux and no capabilities
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

How dangerous is this:
(using captest:)

Current capabilities: none
Securebits flags NOROOT: 0, NOROOT_LOCKED: 0
Attempting direct access to shadow...SUCCESS
Attempting to access shadow by child process...SUCCESS
Child capabilities: none
Securebits flags NOROOT: 0, NOROOT_LOCKED: 0

I have security capability allowed
libcap and libcap-ng installed as well.
(The only thing I can think of, is the system is so small(1 gig)
that there isn't much on, to turn on any capabilities)

I've refpolicy running with mcs, just a bit concerned when
I see  Attempting direct access to shadow...SUCCESS
(nice)

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
