Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBCJqfRb010704
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 14:52:41 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBCJpsYV013855
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 19:51:54 GMT
Received: from mail.simplyaquatics.com ([209.192.59.11])
	by jazzswing.ncsc.mil  with ESMTP id hBCJprBN013852
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 19:51:53 GMT
From: "Ed Street" <edstreet@street-tek.com>
To: "'Stephen Smalley'" <sds@epoch.ncsc.mil>
Cc: "'Selinux'" <selinux@tycho.nsa.gov>
Subject: RE: syslog()
Date: Fri, 12 Dec 2003 14:50:18 -0500
Message-ID: <00bd01c3c0e9$2c16a3a0$9a01a8c0@TECRA>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <1071241285.14716.35.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I should have said this is a bash mod.  Logs keyboard activity to
syslog()for testing purposes.  All I need is to append to the syslog and
disallow any thing else.  Question is, is there anyway to allow an append
but not allow the user access to the file?

Ed

-----Original Message-----
From: Stephen Smalley [mailto:sds@epoch.ncsc.mil] 
Sent: Friday, December 12, 2003 10:01 AM
To: Ed Street
Cc: Selinux
Subject: Re: syslog()

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

---
Incoming mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.548 / Virus Database: 341 - Release Date: 12/05/2003
 

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.548 / Virus Database: 341 - Release Date: 12/05/2003
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
