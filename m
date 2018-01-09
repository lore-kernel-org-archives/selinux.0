Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w09HeYVn008175
 for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2018 12:40:34 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID16.oob.disa.mil (Postfix) with SMTP id 3zGKDG45YNz1P759
 for <selinux@tycho.nsa.gov>; Tue,  9 Jan 2018 17:40:30 +0000 (UTC)
Received: from USFB19PA17.eemsg.mil (unknown [192.168.16.15])
 by USFBF3ID16.oob.disa.mil (Postfix) with ESMTP id 3zGKDG2XYnz1P73y
 for <selinux@tycho.nsa.gov>; Tue,  9 Jan 2018 17:40:30 +0000 (UTC)
Received: from c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net
 [66.36.250.115])
 by c-sl428.itechfrontiers.net (ITechFrontiers-Post) with ESMTP id 580D256418
 for <selinux@tycho.nsa.gov>; Tue,  9 Jan 2018 12:40:25 -0500 (EST)
Received: from c-sl428.itechfrontiers.net ([66.36.250.114])
 by c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net [66.36.250.115])
 (ITech Frontiers SecureMail)
 with ESMTP id E7ShyW4poCET for <selinux@tycho.nsa.gov>;
 Tue,  9 Jan 2018 12:40:22 -0500 (EST)
Received: from c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net
 [66.36.250.115])
 by c-sl428.itechfrontiers.net (ITechFrontiers-Post) with ESMTP id C852A56419
 for <selinux@tycho.nsa.gov>; Tue,  9 Jan 2018 12:40:22 -0500 (EST)
Received: from c-sl428.itechfrontiers.net ([66.36.250.114])
 by c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net [66.36.250.115])
 (ITech Frontiers SecureMail)
 with ESMTP id wxakwP3quMCs for <selinux@tycho.nsa.gov>;
 Tue,  9 Jan 2018 12:40:16 -0500 (EST)
Received: from rhea.itechfrontiers.com ([10.7.14.47])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: cto@itechfrontiers.com)
 by c-sl428.itechfrontiers.net (ITechFrontiers-Post) with ESMTPSA id 3DC7556418
 for <selinux@tycho.nsa.gov>; Tue,  9 Jan 2018 12:40:16 -0500 (EST)
To: selinux@tycho.nsa.gov
References: <954edd73-6121-1a12-9252-527795e0d828@redhat.com>
From: "Patrick K., ITF" <cto@itechfrontiers.com>
Message-ID: <08299ead-8a49-d9b2-cf4f-5b21bbe2c52c@itechfrontiers.com>
Date: Tue, 9 Jan 2018 12:40:18 -0500
MIME-Version: 1.0
In-Reply-To: <954edd73-6121-1a12-9252-527795e0d828@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: I am being asked does SELinux provide any protection on
 Meltdown/Spectre.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Daniel,

Here is the sample code to trigger Meltdown

https://bugs.chromium.org/p/project-zero/issues/detail?id=1272

Plus KVM exploit.

Implementation of both using the original papers

https://spectreattack.com/


Best regards,

-- 
  Patrick K.

On 1/9/2018 12:32 PM, Daniel Walsh wrote:
> Or SECCOMP for that matter.  From my limited reading, I have not seen 
> what an application needs to access to trigger this vulnerabiltiy.  Is 
> this just using standard SYSCALLS, that we could not block without 
> breaking the applications?
>
> Anyone have thoughts on this?
>
>
> Dan
>
>
>
