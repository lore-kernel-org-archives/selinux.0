Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2RLnwR6014783
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 17:49:58 -0400
Received: from web51503.mail.re2.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2RLnv1f022926
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2007 21:49:57 GMT
Message-ID: <20070327214937.98781.qmail@web51503.mail.re2.yahoo.com>
Date: Tue, 27 Mar 2007 14:49:37 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: promoting printk for FS mounting back from KERN_DEBUG
To: Eric Paris <eparis@parisplace.org>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1175027419.13618.45.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>If we don't think a printk is the right way maybe I could make the one
>case in question an audit message and get the setroubleshoot gui to make
>a semi-intelligent comment about it...

No, no, no. Audit is not a dumping ground for messages. It is only for security
relavent events and mounting an unlabled file system is only of interest when
doing LSPP due to import/export to labeled/unlabeled media. I know we already
solved the issue for LSPP.

-Steve


 
____________________________________________________________________________________
Don't pick lemons.
See all the new 2007 cars at Yahoo! Autos.
http://autos.yahoo.com/new_cars.html 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
