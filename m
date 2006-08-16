Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7GD30cr029457
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 09:03:00 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7GD2kjK022514
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 13:02:47 GMT
Subject: Re: Invalid context in targeted SELinux policy
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Daniel Musgrave <dmusgrave@abodiosoftware.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <W7685912732296271155678629@webmail16>
References: <W7685912732296271155678629@webmail16>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 09:02:57 -0400
Message-Id: <1155733377.10971.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-15 at 21:50 +0000, Daniel Musgrave wrote:
> I am in the process of writing an application and associated policy in Centos 4.3, running a targeted SELinux environment at version 1.17.30-2.126.  After succesfully creating the necessary rules in my .te file, and the associated file contexts in the .fc file, I am attempting to resolve one last problem.  After compiling my policy and running the application, I get the following error:
> 
> audit(...): security_compute_sid: invalid context root:system_r:upgrade_t for scontext=root:system_r:unconfined_t tcontext=system_u:object_r:upgrade_exec_t tclass=process
> 
> The domain for this executable is 'upgrade' and the file context of the binary is 'upgrade_exec_t' (there are some associated *_log_t and *_tmp_t files as well).  The .te file defines upgrade using the application_domain macro.
> 
Did you authorize your type for the system_r role?

role system_r upgrade_t;

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
