Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA06422
	for <selinux@tycho.nsa.gov>; Sun, 10 Feb 2002 23:56:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id EAA13932
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 04:55:09 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id EAA13928
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 04:55:07 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 0E2499265F
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 15:55:52 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id F19B2101A
	for <selinux@tycho.nsa.gov>; Mon, 11 Feb 2002 14:56:46 +1000 (EST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: vixie cron patch and also MLS
Date: Mon, 11 Feb 2002 07:59:41 +1000
MIME-Version: 1.0
Message-Id: <20020211045646.F19B2101A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>From a quick code inspection it appears that if the user name matches the 
start of a line in /etc/security/cron_context then the context of that line 
will be used.

So for the default setup if I get the sysadmin to give me an account named 
"sy" then my cron jobs will be run as system_u:system_r:system_crond_t, or if 
I get an account named "roo" (actually had a user with that account name 
once) then I'd get my cron jobs run as root:sysadm_r:sysadm_crond_t!

I think that in the get_user_sid() function the following code:
         if (strncmp(name, bufp, name_len) == 0) {
Should be changed to:
         if (strncmp(name, bufp, name_len) == 0 && bufp[name_len] == ':') {


Also is there any way to determine programmatically if we are running in MLS 
mode?  Having #ifdef CONFIG_FLASK_MLS in the cron code is ugly and is likely 
to cause pain (I don't want to recompile my daemons when switching to/from 
MLS mode).

Also in libsecure/src/get_user_sid.c there's a lot of #ifdef CONFIG_FLASK_MLS 
code.  So it looks like changing to/from MLS requires a recompile of the 
library code and a recompile of all programs linked with -lsecure!

Is the plan to make MLS mandatory in the near future (IE to drop support for 
SE Linux without MLS)?  If so then the current situation will probably do (no 
point coding too much support for something that's going away).  But if the 
plan is to continue to support a choice of MLS or non-MLS then I think it 
needs to be improved.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
