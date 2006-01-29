Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0TDXSXf024232
	for <selinux@tycho.nsa.gov>; Sun, 29 Jan 2006 08:33:29 -0500 (EST)
Received: from web51510.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k0TDWEQA010630
	for <selinux@tycho.nsa.gov>; Sun, 29 Jan 2006 13:32:14 GMT
Message-ID: <20060129133318.64917.qmail@web51510.mail.yahoo.com>
Date: Sun, 29 Jan 2006 05:33:18 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: labeling of compilers etc
To: russell@coker.com.au, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <200601291156.13076.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>If it's considered worth-while then I'm willing to write a policy patch for >the
first one and a bash patch for the second one.

A setuid shell script is an extremely bad idea. I think bash refuses to run them.
Is it really necessary to add a SE Linux patch to bash when it already refuses to
do this?

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
