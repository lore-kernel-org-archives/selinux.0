Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA28572
	for <selinux@tycho.nsa.gov>; Wed, 23 May 2001 10:55:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA18430
	for <selinux@tycho.nsa.gov>; Wed, 23 May 2001 14:55:21 GMT
Received: from smtpproxy1.mitre.org (mb-20-100.mitre.org [129.83.20.100])
	by jazzband.ncsc.mil  with ESMTP id OAA18426
	for <selinux@tycho.nsa.gov>; Wed, 23 May 2001 14:55:19 GMT
Received: from avsrv1.mitre.org (avsrv1.mitre.org [129.83.20.58])
	by smtpproxy1.mitre.org (8.9.3/8.9.3) with ESMTP id KAA15837
	for <selinux@tycho.nsa.gov>; Wed, 23 May 2001 10:55:21 -0400 (EDT)
Received: from mailsrv1.mitre.org (mailsrv1.mitre.org [129.83.20.6])
	by smtpsrv1.mitre.org (8.9.3/8.9.3) with ESMTP id KAA01402
	for <selinux@tycho.nsa.gov>; Wed, 23 May 2001 10:55:10 -0400 (EDT)
Message-ID: <3B0BCFE4.B587EB03@mitre.org>
Date: Wed, 23 May 2001 10:57:40 -0400
From: Jon Crowley <jonathan@mitre.org>
MIME-Version: 1.0
To: "Hugo F. Martinez" <hmartinez@cti.com.ar>
CC: selinux@tycho.nsa.gov
Subject: Re: policy
References: <3B0AF61B.BC396C0F@cti.com.ar>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Did you modify file_contexts?  It appears that is simply a typo... try
changing that line in file_contexts to the following, note the lack of
"i" on the end:

system_u:object_r:cron_log_t 

Jon Crowley




"Hugo F. Martinez" wrote:
> 
> Hi:
> Im  trying to relabel my file system but im getting this kind of errors
> 
> ....
> ./set files: invalid context system_u:object_r:cron_log_ti on line
> number 368
> make: *** [relabel] Error 1
> 
> I check the file_contexts but i cant see any clue of where the problem
> 
> Thanks in advance.
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
