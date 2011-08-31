Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7VH2Vcv007294
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 13:02:31 -0400
Received: from mx-out-manc2.simplymailsolutions.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7VH2UKk028004
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 17:02:30 GMT
Received: from [10.1.10.3] (helo=unx-s-manc3.ifeltd.com)
	by mx-out-manc2.simplymailsolutions.com with esmtp (Exim 4.63)
	(envelope-from <roy.badami@roboreus.com>)
	id 1QyoBJ-0002rU-Qt
	for selinux@tycho.nsa.gov; Wed, 31 Aug 2011 18:02:29 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by unx-s-manc3.ifeltd.com (Postfix) with ESMTP id C33F38C8019
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 18:02:29 +0100 (BST)
Received: from unx-s-manc3.ifeltd.com ([127.0.0.1])
	by localhost (unx-s-manc3.ifeltd.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b3Jmasw7uyHu for <selinux@tycho.nsa.gov>;
	Wed, 31 Aug 2011 18:02:29 +0100 (BST)
Received: from [192.168.1.113] (unknown [87.224.85.62])
	by unx-s-manc3.ifeltd.com (Postfix) with ESMTPSA id 9258C8C8018
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 18:02:29 +0100 (BST)
Message-ID: <4E5E68DB.1030101@roboreus.com>
Date: Wed, 31 Aug 2011 18:01:15 +0100
From: Roy Badami <roy.badami@roboreus.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: CentOS 5 RBAC
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to understand the RBAC features in the version of the mls 
(and also strict) policies that ship with CentOS 5.6 - I'm not sure if 
this is the best place to ask or if there's a more appropriate list.

Starting with the mls policy, and setting the secure_mode_loadpolicy 
boolean to 'on'  I then get that *neither* sysadm_r *nor* secadm_r can 
issue commands such as setenforce.  Yet userdomain.te contains the 
following code:

ifdef(`strict_policy',`
[...]
         optional_policy(`
                 seutil_run_restorecon(sysadm_t,sysadm_r,admin_terminal)
                 seutil_run_runinit(sysadm_t,sysadm_r,admin_terminal)

                 ifdef(`enable_mls',`
                         
userdom_security_administrator(secadm_t,secadm_r,{ secadm_tty_device_t 
sysadm_devpts_t })
#                       tunable_policy(`allow_sysadm_manage_security',`
                                 
userdom_security_administrator(sysadm_t,sysadm_r,admin_terminal)
#                       ')
                 ', `
                         
userdom_security_administrator(sysadm_t,sysadm_r,admin_terminal)
                 ')
         ')
[...]
')

Now as far as I can see from the specfile the mls policy passes NAME=mls 
TYPE=strict-mls to the makefile, and the makefile in turn defines 
strict_policy and enable_mls in response to TYPE=strict-mls - and yet as 
far as I can tell from running apol the actual binary policy in the 
selinux-policy-mls RPM ends up not containing any TE rule to allow 
sysadm_t or secadm_t to run setenforce - despite the fact that it would 
appear that the userdom_security_administrator macro should appear to 
expand into such rules.

What am I overlooking here?

Just out of interest, I then went and tried the strict policy.  Yet this 
policy doesn't even have a secadm_r and again I don't understand why.  
The specfile builds it with NAME=strict TYPE=strict-mcs and from my 
reading of the makefile an -mcs policy should again set enable_mls.    
And kernel.ke continas the following, so I don't quite see why the 
policy doesn't end up containing these roles.

ifdef(`enable_mls',`
         role secadm_r;
         role auditadm_r;
')

Any pointers to what I'm missing here would be appreciated.

Regards

Roy


-- 
Roy Badami
Roboreus Ltd
1 New Oxford Street
London WC1A 1NU


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
