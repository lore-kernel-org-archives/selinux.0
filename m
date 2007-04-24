Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OHxGUQ031065
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 13:59:16 -0400
Received: from web51502.mail.re2.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3OHxFSG021941
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 17:59:15 GMT
Message-ID: <20070424175850.49065.qmail@web51502.mail.re2.yahoo.com>
Date: Tue, 24 Apr 2007 10:58:50 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: splice syscall
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I was looking at sys_splice, do_splice, and do_splice_to/from. None of which seem
to have a SE Linux permission check. Is the splice syscall controlled by SE Linux
other than the initial creation of the descriptors?

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
