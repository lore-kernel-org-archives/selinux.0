Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8UKhOrT026903
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 16:43:24 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8UKhMog009024
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 20:43:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom Anderson <granite217@yahoo.com>
Subject: Re: purpose of the staff_r role?
Date: Fri, 1 Oct 2004 06:43:20 +1000
Cc: selinux@tycho.nsa.gov
References: <20040930193153.22233.qmail@web14926.mail.yahoo.com>
In-Reply-To: <20040930193153.22233.qmail@web14926.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410010643.20408.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 1 Oct 2004 05:31, Tom Anderson <granite217@yahoo.com> wrote:
> > It's the role that a person who can become sysadm_r should do their
> > daily work in like reading mail, working on source code, etc.  The
> > reason is because it basically isn't allowed to interact with user_t
> > at all; for example, staff_t can't read user_tmp_t.  This prevents
> > /tmp races from working.
>
> Ah, that makes sense.  But I'd like my staff_t user able to read
> logfiles, without needing to become sysadm_r first ('cuz I can do some
> real damage inadvertently).  Is there a "correct" way to do this?  I've
> tried granting read access to var_log_t, but several daemons have their
> own logfile types.

r_dir_file(staff_t, logfile)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
