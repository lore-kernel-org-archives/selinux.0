Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i921AUrT006203
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 21:10:30 -0400 (EDT)
Received: from web14924.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i9219O4L013647
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 01:09:24 GMT
Message-ID: <20041002011030.68972.qmail@web14924.mail.yahoo.com>
Date: Fri, 1 Oct 2004 18:10:30 -0700 (PDT)
From: Tom Anderson <granite217@yahoo.com>
Subject: Re: purpose of the staff_r role?
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200410010643.20408.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- Russell Coker <russell@coker.com.au> wrote:
> r_dir_file(staff_t, logfile)

Thank you.  Is there a similar trick for seeing the full process
information under ps?  I see there's a "can_ps" macro, but so far I
haven't managed to get the arguments right.



		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
