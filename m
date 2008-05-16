Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4GCElXF022617
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2008 08:14:47 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m4GCEkns022509
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2008 12:14:46 GMT
Subject: rbacsep: RFC cron jobs execute under user domain
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 16 May 2008 08:14:17 -0400
Message-Id: <1210940057.11188.73.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think this has been talked about a little, but I'd like some feedback
on having cron jobs execute directly in the user domain rather than in a
special cron job domain.  Was there a specific reason cron jobs were not
done this way from the start?

To be more specific, right now cron jobs will execute under
user_crond_t, staff_crond_t, etc.  My thought is to have them run under
user_t, staff_t, etc.  It seems logical since that tends to be how users
see cron jobs: running as the user/having the same permissions as the
user.

The system cron jobs (system_crond_t) would be unchanged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
