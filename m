Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s379qiXA018254
 for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2014 05:52:44 -0400
Received: from c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net
 [66.36.250.115])
 by c-sl428.itechfrontiers.net (ITechFrontiers-Post) with ESMTP id DF48D5E120
 for <selinux@tycho.nsa.gov>; Mon,  7 Apr 2014 05:52:43 -0400 (EDT)
Received: from c-sl428.itechfrontiers.net ([66.36.250.114])
 by c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net [66.36.250.115])
 (ITech Frontiers SecureMail)
 with ESMTP id hGalDXbwRCn2 for <selinux@tycho.nsa.gov>;
 Mon,  7 Apr 2014 05:52:41 -0400 (EDT)
Received: from c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net
 [66.36.250.115])
 by c-sl428.itechfrontiers.net (ITechFrontiers-Post) with ESMTP id AB6745E10A
 for <selinux@tycho.nsa.gov>; Mon,  7 Apr 2014 05:52:41 -0400 (EDT)
Received: from c-sl428.itechfrontiers.net ([66.36.250.114])
 by c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net [66.36.250.115])
 (ITech Frontiers SecureMail)
 with ESMTP id bstRDR4CXw-O for <selinux@tycho.nsa.gov>;
 Mon,  7 Apr 2014 05:52:36 -0400 (EDT)
Received: from rhea.itechfrontiers.com ([10.7.14.47])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: cto@itechfrontiers.com)
 by c-sl428.itechfrontiers.net (ITechFrontiers-Post) with ESMTPSA id DFB6B5DC57
 for <selinux@tycho.nsa.gov>; Mon,  7 Apr 2014 05:52:35 -0400 (EDT)
Message-ID: <53427577.1070704@itechfrontiers.com>
Date: Mon, 07 Apr 2014 05:52:55 -0400
From: "Patrick K., ITF" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: What do you mean by a 'domain'.
References: <53426EC3.6020109@gmail.com>
In-Reply-To: <53426EC3.6020109@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 4/7/2014 5:24 AM, dE wrote:
> Hi!
>
> Sorry for the trival question; but on reading various SELinux resources,
> it appears everyone talks about some 'domain' but no one defines what is
> it.
>
> So I wanna what what is a domain in SELinux.
>
>
> Thank you!

Hello,

Generally a domain is a scope or realm, consisting of related contexts 
in which you define and operate your security components (depending on 
your security model) using a combination of:

SELinux  user, role, type and level (optionally, MLS sensitivity level)


Particularly, a domain is also used interchangeably with SELinux "type"

In addition, in RBAC (Role-based security model) to some extent a "role" 
can serve as an intermediary between domains (types) and be part of it.

Representations:

SELinux User :  SELinux Role :  SELinux Type :  Sensitivity Level
unconfined_u :  unconfined_r : unconfined_t  : s0-s0:c0.c1024


# ps -eZ
# ls -laZ




Best Regards,


-- 
  Patrick K.
