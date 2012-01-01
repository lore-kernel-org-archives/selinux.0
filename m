Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q018SKrx006300
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2012 03:28:21 -0500
Received: from mail.copilotco.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id q018SJMx022455
	for <selinux@tycho.nsa.gov>; Sun, 1 Jan 2012 08:28:20 GMT
Date: Sun, 1 Jan 2012 00:28:16 -0800
From: Tracy Reed <treed@ultraviolet.org>
To: Sven Vermeulen <sven.vermeulen@siphos.be>
Cc: selinux@tycho.nsa.gov
Subject: Re: transition from crond
Message-ID: <20120101082815.GA10436@tracyreed.org>
References: <20111230185146.GY10436@tracyreed.org>
 <20111231103415.GA3510@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111231103415.GA3510@siphos.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Dec 31, 2011 at 11:34:15AM +0100, Sven Vermeulen spake thusly:
> This seems wrong. There's no need for an "ifdef" here. 
> 
> You probably want something like the following in your .te file:

Ah, thanks! I was just copying from the only example I could find of transitioning from crond:

http://www.linuxtopia.org/online_books/writing_SELinux_policy_guide/case_study_13.html

This is from 2003 or so and very outdated, no doubt. But it is the only such
example I could find. Is there any better documentation? 

Also, while your suggestion seems to have worked and I have eliminated quite a
few avc denials I am still getting this one:

type=AVC msg=audit(1325404861.508:99794): avc:  denied  { getattr } for  pid=5065 comm="perl" path="/automated_tasks/etc/mysql_auth.pm" dev =md0 ino=240014 scontext=system_u:system_r:crond_t:s0-s0:c0.c1023 tcontext=system_u:object_r:automated_tasks_db_t:s0 tclass=file

mysql_auth.pm is a perl module included by email2feedback.pl. I would have
thought that this perl module would have been run under the email2feedback_t
type of the program it was being used in. What is the correct way to handle
this?

-- 
Tracy Reed

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
