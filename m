Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i523r5rT000998
	for <selinux@tycho.nsa.gov>; Tue, 1 Jun 2004 23:53:05 -0400 (EDT)
Received: from smtp804.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i52Blabn010253
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 07:47:36 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 1 Jun 2004 09:06:20 -0000
Date: Tue, 1 Jun 2004 09:03:45 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: openssh-unix-dev@mindrot.org, pam-list@redhat.com,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: issue with SE/Linux - sshd not giving access to /dev/pts/[n]
Message-ID: <20040601090345.GM8312@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi there,

i have an issue on my newly created Debian/SELinux/unstable system.

i have pam 0.77 se1 installed
ssh            3.8.1p1-4      (OpenSSH)
and libselinux1 1.12-1.

i can log in as root, fine.

but i cannot log in as an ordinary user, and i had to grant
special permission to the _user_ process (NOT sshd or pam
before a setuid and exec is carried out) to access
/dev/pts/0.

in other words, if i understand this correctly, there is a
bug somewhere in either sshd or pam where control of the
tty is given at the wrong point, or is not given at all.

(russell talks of relabelling the tty, i'm not sure what that
would involve.)

... except if the user is root :) :) whereupon magically
it works fiine :)

okay, so does anyone on the openssh or pam lists understand
what this might about?  does it ring any bells?

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
