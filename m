Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8U1cTrT020558
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 21:38:29 -0400 (EDT)
Received: from web14925.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i8U1bOnY016729
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 01:37:24 GMT
Message-ID: <20040930013829.10463.qmail@web14925.mail.yahoo.com>
Date: Wed, 29 Sep 2004 18:38:29 -0700 (PDT)
From: Tom Anderson <granite217@yahoo.com>
Subject: purpose of the staff_r role?
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Can anyone explain the purpose/benefit of having an account under the
staff_r role?  I thought it was to allow limited administrative
functions, but I've discovered that it doesn't even allow reading the
logfiles under /var/log/.  What purpose does it serve, other than to
limit who can transition to sysadm_r?

SE Linux appears to be quite powerful, but dear $deity it's confusing. 
I'd sell my soul for a nice, readable O'Reilly Press title covering
this stuff!


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
