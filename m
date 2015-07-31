Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6V4utVr002649
 for <selinux@tycho.nsa.gov>; Fri, 31 Jul 2015 00:56:55 -0400
To: selinux@tycho.nsa.gov
From: Dan <dtdevore64@yahoo.com>
Subject: Does it matter where .cil modules are build.
Message-ID: <55BB0009.4030809@yahoo.com>
Date: Fri, 31 Jul 2015 00:56:41 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello everyone,

      I have been reading up on the cil documentation and am starting to 
get the hang of it and have successfully built my first module. I have a 
a module called test.cil. Now my only question on is where exactly would 
I put this module to build it or does it not matter where you stick them 
at? I know when you take the .pp packages and convert them to .cil  they 
get stored in /var/lib/selinux/targeted/active/modules/400, but I'm just 
using the secilc compiler and nothing else to build policy.

Thanks.
