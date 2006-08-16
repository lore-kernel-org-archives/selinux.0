Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7GFLomU001058
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 11:21:50 -0400
Received: from omr3.networksolutionsemail.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7GFLQXM026549
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 15:21:27 GMT
Received: from mail.networksolutionsemail.com (ns-omr3.mgt.netsolmail.com [10.49.6.66])
	by omr3.networksolutionsemail.com (8.13.6/8.13.6) with SMTP id k7GFLkjh018549
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 11:21:48 -0400
From: "Daniel Musgrave" <dmusgrave@abodiosoftware.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Message-ID: <W4127611390290341155741705@webmail11>
Date: Wed, 16 Aug 2006 15:21:45 +0000
Subject: Re:  Invalid context in targeted SELinux policy
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> role system_r types upgrade_t;

This did it; this isn't the first (and probably won't be the last) time that I've quickly read 'sysadm' and seen 'system'.

>Hmm...application_domain() includes a role statement for sysadm_r by
>default, and also includes a role statement for system_r if
>targeted_policy is defined, i.e. building targeted policy.  At least in
>the last release of the example policy.  But possibly that wasn't in the
>CentOS/RHEL policies as shipped.

It seems that in the global_macros.te supplied on this machine, the application_domain() only defines the sysadm_r role statement, while a later macro system_domain() defines system_r instead.  (And glancing at this second macro, it seems that it may be more appropriate for what I need anyway.)

Thanks very much for your help,

Daniel Musgrave
Abodio Software




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
