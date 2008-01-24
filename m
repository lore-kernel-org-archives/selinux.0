Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0OKZPre020799
	for <selinux@tycho.nsa.gov>; Thu, 24 Jan 2008 15:35:25 -0500
Received: from office.cardomain.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0OKZOgt016228
	for <selinux@tycho.nsa.gov>; Thu, 24 Jan 2008 20:35:25 GMT
Received: from cardomain.com (exnode01.intra.cardomain.com [172.21.0.4])
	by office.cardomain.com (Postfix) with ESMTP id DE91185A8
	for <selinux@tycho.nsa.gov>; Thu, 24 Jan 2008 12:35:23 -0800 (PST)
Subject: Re: I am more worried about open then read and write, SELinux
	needs open access checks.
From: Brett Lentz <blentz@cardomain.com>
To: Steve G <linux_4ever@yahoo.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <964182.26945.qm@web51502.mail.re2.yahoo.com>
References: <964182.26945.qm@web51502.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Thu, 24 Jan 2008 12:35:23 -0800
Message-Id: <1201206923.3002.55.camel@blentz>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-24 at 10:48 -0800, Steve G wrote:
> > I would like to propose that we add one or more avc's to deal with
> > opening a file.  open or open_read open_write.  
> 
> 
> There are situations where apps should only do an open_append to make sure they don't erase anything. syslog, auditd, apache are a few apps that come to mind.
> 
> -Steve
> 


As far as I'm aware, SELinux, and this requested addition, doesn't
govern _how_ you write, just whether you _can_ write.

_______________________________
Brett Lentz | CarDomain Network
System Administrator

blentz@cardomain.com | tel 206.926.2109 | cell 206.851.6669
http://www.cardomain.com/id/wakko666

"A University without students is like an ointment without a fly."
	-- Ed Nather, professor of astronomy at UT Austin

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
