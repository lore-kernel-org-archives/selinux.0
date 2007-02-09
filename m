Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l19Enbtv022943
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 09:49:37 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l19Eojh4009163
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 14:50:46 GMT
Subject: Re: ANN: SETools Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <45CB88E0.4020203@mentalrootkit.com>
References: <1170958915.31164.45.camel@sgc.columbia.tresys.com>
	 <45CB88E0.4020203@mentalrootkit.com>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 09:50:50 -0500
Message-Id: <1171032650.21799.10.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-08 at 15:32 -0500, Karl MacMillan wrote:
> Christopher J. PeBenito wrote:
> > 
> > libseaudit:
> > 
> >   * Rewrite of library to have proper namespaces.  libseaudit is now
> >     fully documented and suitable for third-party users.
> > 
> 
> Do you now handle USER_AVC and AVC_PATH audit messages? Also, any 
> thoughts of using the new audit parsing library in the future?

No, we don't handle those messages yet, as we didn't change the parsing.
We will be working on adding support for the various audit log message
types via libaudit for the next release.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
