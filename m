Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OJ6LDV004513
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 15:06:21 -0400
Received: from web51507.mail.re2.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3OJ6LJc011168
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 19:06:21 GMT
Message-ID: <20070424190620.37853.qmail@web51507.mail.re2.yahoo.com>
Date: Tue, 24 Apr 2007 12:06:20 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: splice syscall
To: selinux@tycho.nsa.gov
In-Reply-To: <20070424175850.49065.qmail@web51502.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Is the splice syscall controlled by SE Linux other than the initial creation of
>the descriptors?

On second thought, you can mimick this syscall in user space, so I guess it
doesn't matter. (The thought was that maybe it could be used to upgrade/downgrade
information.)

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
