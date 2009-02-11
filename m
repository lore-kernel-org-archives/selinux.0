Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1BFx958031467
	for <selinux@tycho.nsa.gov>; Wed, 11 Feb 2009 10:59:09 -0500
Received: from smtp104.prem.mail.sp1.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id n1BFx8AP023408
	for <selinux@tycho.nsa.gov>; Wed, 11 Feb 2009 15:59:08 GMT
Message-ID: <4992F5C8.9070507@schaufler-ca.com>
Date: Wed, 11 Feb 2009 07:59:04 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Dennis Wronka <linuxweb@gmx.net>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Question about su
References: <200902111650.39754.linuxweb@gmx.net>
In-Reply-To: <200902111650.39754.linuxweb@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dennis Wronka wrote:
> ...
>
> So, what the heck is the use of su on a SELinux-system?
An aspect of su that is frequently overlooked is that su provides
a mechanism to Switch User (that's what it's short for) and that
there are cases where you might want to perform an action as another
unprivileged user. On SELinux su should properly be thought of as
either a DAC tool or an I&A mechanism, depending on the needs of
the people to whom you're explaining the system.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
