Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1NJDxsk026502
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 14:13:59 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1NJFJ0Z028704
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 19:15:19 GMT
Subject: Re: audit/logging changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DB2FD3.80005@redhat.com>
References: <45DB2FD3.80005@redhat.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 19:15:34 +0000
Message-Id: <1172258134.15371.86.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 12:28 -0500, Daniel J Walsh wrote:
> audit needs fsetid
> 
> syslog needs to be able to create a tcp_socket for off machine logging.
> 
> ssh transitioning dirrectly to auditctl needs additional privs.

Merged the first two parts.  We want the general solution for last one.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
