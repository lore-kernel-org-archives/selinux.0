Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i924firT007124
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 00:41:44 -0400 (EDT)
Received: from web14923.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i924fhlM023463
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 04:41:44 GMT
Message-ID: <20041002044139.8086.qmail@web14923.mail.yahoo.com>
Date: Fri, 1 Oct 2004 21:41:39 -0700 (PDT)
From: Tom Anderson <granite217@yahoo.com>
Subject: Re: purpose of the staff_r role?
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200410021243.02995.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- Russell Coker <russell@coker.com.au> wrote:
> can_ps(staff_t, domain) probably does what you want.

That seems to have done it.  Thanks!



		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
