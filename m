Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i922h7rT006591
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 22:43:07 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i922h4EZ021593
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 02:43:04 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom Anderson <granite217@yahoo.com>
Subject: Re: purpose of the staff_r role?
Date: Sat, 2 Oct 2004 12:43:02 +1000
Cc: selinux@tycho.nsa.gov
References: <20041002011030.68972.qmail@web14924.mail.yahoo.com>
In-Reply-To: <20041002011030.68972.qmail@web14924.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410021243.02995.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2 Oct 2004 11:10, Tom Anderson <granite217@yahoo.com> wrote:
> --- Russell Coker <russell@coker.com.au> wrote:
> > r_dir_file(staff_t, logfile)
>
> Thank you.  Is there a similar trick for seeing the full process
> information under ps?  I see there's a "can_ps" macro, but so far I
> haven't managed to get the arguments right.

can_ps(staff_t, domain) probably does what you want.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
