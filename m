Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MHvimP028476
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 13:57:44 -0400
Received: from web51510.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8MHvE3K004464
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 17:57:14 GMT
Message-ID: <20060922175743.5272.qmail@web51510.mail.yahoo.com>
Date: Fri, 22 Sep 2006 10:57:43 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: mkdir avc
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1158947249.7748.235.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>I would have expected the syscall audit record to have captured the path, but am
>not seeing it now either (but do see it in older audit logs).  Regression in the
>audit code?

Could be...that's why I'm asking. I wanted to get confirmation that one or the
other should be there. When you audit the mkdir syscall, a path record is there.
But in the case of the avc, its not.

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
