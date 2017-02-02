Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v12HMsjk019805
 for <selinux@tycho.nsa.gov>; Thu, 2 Feb 2017 12:22:54 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1826B80464
 for <selinux@tycho.nsa.gov>; Thu,  2 Feb 2017 17:22:50 +0000 (UTC)
Received: from [10.40.3.114] ([10.40.3.114])
 by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 v12HMlrL013346
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <selinux@tycho.nsa.gov>; Thu, 2 Feb 2017 12:22:49 -0500
To: SELinux <selinux@tycho.nsa.gov>
From: Vit Mojzis <vmojzis@redhat.com>
Subject: possible regression in "semanage user"
Message-ID: <3837461d-1104-fcd3-eb01-77faf3bb4b0b@redhat.com>
Date: Thu, 2 Feb 2017 18:22:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi list,
we have a report about a possible regression in "semanage user" and I'd 
like to hear your opinion on what the correct behaviour should be.

Given that local changes have been made to a SELinux user definition 
(originally defined in policy)
e.g. # semanage user -m staff_u -r "s0"
and the SELinux user is mapped to some Linux user
# semanage login -a -s staff_u staff
both
# semanage user -d staff_u
and
# semanage user --deleteall
will fail to remove the local change with the following message:
"libsemanage.lookup_seuser: staff_u is being used by staff login record 
(Invalid argument)."

Is this the intended behaviour?

I would assume that this error message was intended only for locally 
defined SELinux users (in which case "semanage user -d selinux_user" 
would remove the only definition of "selinux_user"). If so, is there any 
way to determine if a SELinux user has been defined only locally (as 
opposed to being defined in policy) after some local changes have been made?


Best regards,

Vit Mojzis
