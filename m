Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2AJRoLT008824
 for <selinux@tycho.nsa.gov>; Thu, 10 Mar 2016 14:27:50 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (Postfix) with ESMTPS id 41569C1F65
 for <selinux@tycho.nsa.gov>; Thu, 10 Mar 2016 19:27:45 +0000 (UTC)
Received: from dhcp-10-19-62-196.boston.devel.redhat.com
 (dhcp-25-88.bos.redhat.com [10.18.25.88])
 by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 u2AJRiUV020671
 for <selinux@tycho.nsa.gov>; Thu, 10 Mar 2016 14:27:45 -0500
To: SELinux <selinux@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Subject: We have a pretty big bug between SELinux and the User Namespace
Message-ID: <56E1CAB0.9020002@redhat.com>
Date: Thu, 10 Mar 2016 14:27:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

But our people have limited time to work on it, it has been back 
burner-ed since last summer.

https://bugzilla.redhat.com/show_bug.cgi?id=1236256

Basically User Namespace introduces a new concept of Namespaced 
capabilities.  SELinux currently blocks the use of all capabilities
and does not differentiate.  If someone is looking to cut their teeth on 
Kernel and Security work, I think it would be a good project
to try to differentiate in policy and the kernel between the two 
Capabilities.

The current problem I am seeing is with a confined user.  staff_t does 
not have any capabilities, but when he runs Chrome, it uses
usernamespace to isolate the chrome_sandbox and protect the host. Non 
privilege users on Fedora are allowed to setup User Namespaces
but some of the activity of setting up the User Namespace requires 
Namespaced SYS_ADMIN.  Since SELinux blocks SYS_ADMIN for staff_t
I can not run Chrome with out temporarily setenforce 0, or adding 
SYS_ADMIN to staff_t.  Neither is an attractive solution.

Wearing my best Tom Sawyer hat, white washing this fence would be fun.

Anyone want to take a shot?

Dan
