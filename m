Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBCF1WRb009091
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 10:01:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBCF1VRV007971
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 15:01:31 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hBCF1Vta007968 for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 15:01:31 GMT
Subject: Re: syslog()
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ed Street <edstreet@street-tek.com>
Cc: Selinux <selinux@tycho.nsa.gov>
In-Reply-To: <00ae01c3c0be$3bbda770$9a01a8c0@TECRA>
References: <00ae01c3c0be$3bbda770$9a01a8c0@TECRA>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1071241285.14716.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 12 Dec 2003 10:01:26 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-12-12 at 09:42, Ed Street wrote:
> I have a ‘mod’ that makes a syslog() call, in permissive mode it works
> fine.  In enforcing mode it does not log nor does it display an avc
> message.  I’m not clear on where I need to look for the policy change
> that’s needed.  Also do I need to make any extra calls for this?

The unprivileged user domains aren't allowed to read or generate
log messages.  There are dontaudit rules to suppress the auditing of
these denials (look in macros/user_macros.te).  You need to put your
program into a domain and authorize it to log messages.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
