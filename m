From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>, "'kamal'" <kamalnee@iitk.ac.in>
Cc: <SELinux@tycho.nsa.gov>, "'Trent Jaeger'" <jaegert@us.ibm.com>
Subject: RE: SELinux project
Date: Mon, 15 Sep 2003 12:07:56 -0400
Message-ID: <000501c37ba3$879e2580$8100a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <1063629744.13311.47.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Rather than
> building a new tool from scratch, you might want to consider
> building extensions to existing open source tools, such as the Tresys
> tools, available from http://www.tresys.com/selinux.  I think that
> they are working on improved information flow analysis
> capabilities, so that
> would help in such work.
> 
> --
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency

We'd welcome contributions.  As Steve mentioned, we're about to release a new
version of our analysis tool that will start to address the overt information
flow problem (which is quite challenging in such a rich policy language).  One
of the directions we working toward is tools that provide ability to help
develop policies that implement desire security policies that can be
demonstrated correct (informally) in support of certifications and assessments.

Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
