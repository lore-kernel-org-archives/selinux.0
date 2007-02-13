Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1DGbGUY010252
	for <selinux@tycho.nsa.gov>; Tue, 13 Feb 2007 11:37:16 -0500
Received: from web36614.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1DGcLUI003959
	for <selinux@tycho.nsa.gov>; Tue, 13 Feb 2007 16:38:22 GMT
Message-ID: <20070213163811.55225.qmail@web36614.mail.mud.yahoo.com>
Date: Tue, 13 Feb 2007 08:38:11 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC] security_getprocattr() API idiocy
To: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@ftp.linux.org.uk
Cc: selinux@tycho.nsa.gov, Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org
In-Reply-To: <20070213134555.GG4095@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Al Viro <viro@ftp.linux.org.uk> wrote:

> 	security_getprocattr() ...
> 
> So, do we want to keep the original variant and add
> a saner one in parallel
> to it or should we just switch to saner API?

The current API lacks sufficient merit to
warrent retention. I agree with Stephen,
replace the current API with the saner.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
