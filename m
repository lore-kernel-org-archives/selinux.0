Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBADI8Ii020088
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 08:18:08 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBADGUwg021655
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 13:16:30 GMT
Subject: Re: Adding a new user domain
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Nick Gray <nick-lists@austin.rr.com>
Cc: SE Linux list <selinux@tycho.nsa.gov>
In-Reply-To: <1102631518.24067.29.camel@hawaii.grays-systems.com>
References: <1102624510.24067.8.camel@hawaii.grays-systems.com>
	 <1102624952.32175.249.camel@moss-spartans.epoch.ncsc.mil>
	 <1102631518.24067.29.camel@hawaii.grays-systems.com>
Content-Type: text/plain
Message-Id: <1102684377.1628.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 10 Dec 2004 08:12:57 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-09 at 17:31, Nick Gray wrote:
> It appears that the file was in the wrong place
> 
> Now I am getting:
> 
> domains/user.te:3:ERROR 'syntax error' at token 'allow' on line 6742:
> allow sysadm_r tomcat_r
> allow system_r tomcat_r
> /usr/bin/checkpolicy:  error(s) encountered while parsing configuration
> make: *** [policy.18] Error 1

First, note that user domains don't exist in targeted policy, so if you
want to use them, you first have to convert to strict.  But you don't
need them if all you want to do is confine a daemon.

Second, you are missing semicolons above.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
