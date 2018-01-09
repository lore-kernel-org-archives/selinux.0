Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w09HWVmE001592
 for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2018 12:32:31 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID13.oob.disa.mil (Postfix) with SMTP id 3zGK2z14gfz3S6DY
 for <selinux@tycho.nsa.gov>; Tue,  9 Jan 2018 17:32:27 +0000 (UTC)
Received: from USFB19PA01.eesmg.mil (unknown [192.168.16.8])
 by USFBF3ID13.oob.disa.mil (Postfix) with ESMTP id 3zGK2z0XZ5z3S6DS
 for <selinux@tycho.nsa.gov>; Tue,  9 Jan 2018 17:32:27 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A7FD7F7A2
 for <selinux@tycho.nsa.gov>; Tue,  9 Jan 2018 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.18.25.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D55EB7F80A
 for <selinux@tycho.nsa.gov>; Tue,  9 Jan 2018 17:32:11 +0000 (UTC)
Reply-To: dwalsh@redhat.com
To: selinux <selinux@tycho.nsa.gov>
From: Daniel Walsh <dwalsh@redhat.com>
Message-ID: <954edd73-6121-1a12-9252-527795e0d828@redhat.com>
Date: Tue, 9 Jan 2018 12:32:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: I am being asked does SELinux provide any protection on
 Meltdown/Spectre.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Or SECCOMP for that matter.  From my limited reading, I have not seen 
what an application needs to access to trigger this vulnerabiltiy.  Is 
this just using standard SYSCALLS, that we could not block without 
breaking the applications?

Anyone have thoughts on this?


Dan
