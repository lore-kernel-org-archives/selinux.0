Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0OItYTe009523
	for <selinux@tycho.nsa.gov>; Thu, 24 Jan 2008 13:55:34 -0500
Received: from web51502.mail.re2.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m0OItXJP012419
	for <selinux@tycho.nsa.gov>; Thu, 24 Jan 2008 18:55:33 GMT
Date: Thu, 24 Jan 2008 10:48:47 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: I am more worried about open then read and write, SELinux needs open access checks.
To: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <964182.26945.qm@web51502.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I would like to propose that we add one or more avc's to deal with
> opening a file.  open or open_read open_write.  


There are situations where apps should only do an open_append to make sure they don't erase anything. syslog, auditd, apache are a few apps that come to mind.

-Steve



      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
