Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB8JasIi007838
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 14:36:54 -0500 (EST)
Received: from web50208.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id iB8Jauu3001037
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 19:36:57 GMT
Message-ID: <20041208193658.89005.qmail@web50208.mail.yahoo.com>
Date: Wed, 8 Dec 2004 11:36:58 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: getfilecon() and friends in libselinux
To: Stephen Smalley <sds@epoch.ncsc.mil>, Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1102526433.26951.86.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Be careful of virtual file systems (e.g. autofs,
automount) as some implementations have semantics
that differ between the mount point and contained
objects. I have seen device file system
implementations that claimed to implement extended
attributes but that had enormously odd behaviors.


=====
Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
