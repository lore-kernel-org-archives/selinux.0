Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8UJVsrT026140
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 15:31:54 -0400 (EDT)
Received: from web14926.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i8UJUmng005963
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 19:30:48 GMT
Message-ID: <20040930193153.22233.qmail@web14926.mail.yahoo.com>
Date: Thu, 30 Sep 2004 12:31:53 -0700 (PDT)
From: Tom Anderson <granite217@yahoo.com>
Subject: Re: purpose of the staff_r role?
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1096550221.969.5.camel@nexus.verbum.private>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> It's the role that a person who can become sysadm_r should do their
> daily work in like reading mail, working on source code, etc.  The
> reason is because it basically isn't allowed to interact with user_t
> at all; for example, staff_t can't read user_tmp_t.  This prevents 
> /tmp races from working.

Ah, that makes sense.  But I'd like my staff_t user able to read
logfiles, without needing to become sysadm_r first ('cuz I can do some
real damage inadvertently).  Is there a "correct" way to do this?  I've
tried granting read access to var_log_t, but several daemons have their
own logfile types.



		
_______________________________
Do you Yahoo!?
Express yourself with Y! Messenger! Free. Download now. 
http://messenger.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
