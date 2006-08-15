Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7FLoeEo008489
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 17:50:40 -0400
Received: from omr2.networksolutionsemail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7FLoRFK010345
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 21:50:27 GMT
Received: from mail.networksolutionsemail.com (ns-omr2.mgt.netsol.com [10.49.6.65])
	by omr2.networksolutionsemail.com (8.13.6/8.13.6) with SMTP id k7FLoUvp014563
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 17:50:38 -0400
From: "Daniel Musgrave" <dmusgrave@abodiosoftware.com>
To: selinux@tycho.nsa.gov
Message-ID: <W7685912732296271155678629@webmail16>
Date: Tue, 15 Aug 2006 21:50:29 +0000
Subject: Invalid context in targeted SELinux policy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am in the process of writing an application and associated policy in Centos 4.3, running a targeted SELinux environment at version 1.17.30-2.126.  After succesfully creating the necessary rules in my .te file, and the associated file contexts in the .fc file, I am attempting to resolve one last problem.  After compiling my policy and running the application, I get the following error:

audit(...): security_compute_sid: invalid context root:system_r:upgrade_t for scontext=root:system_r:unconfined_t tcontext=system_u:object_r:upgrade_exec_t tclass=process

The domain for this executable is 'upgrade' and the file context of the binary is 'upgrade_exec_t' (there are some associated *_log_t and *_tmp_t files as well).  The .te file defines upgrade using the application_domain macro.

I have thus far been unable to find any sort of documentation or discussion that relates to this specific problem (most file_context issues seem to come from improperly-formatted .fc files during labeling, rather than at runtime).  Am I forgetting to include some line in my .te file?  Do I need to include the new domain/type I've created in some other location?  Any insight you can provide would be greatly appreciated.

Thanks,

Daniel

PS - here is my .fc file, in case my problem somehow *does* involve it.

upgrade.fc
# upgrade
/usr/bin/upgrade      --  system_u:object_r:upgrade_exec_t
/var/log/upgrade.log  --  system_u:object_r:upgrade_log_t
/tmp/upgrade(/.*)?    --  system_u:object_r:upgrade_tmp_t




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
