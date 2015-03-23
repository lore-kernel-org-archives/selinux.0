Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2NKCu1Y006605
 for <selinux@tycho.nsa.gov>; Mon, 23 Mar 2015 16:12:56 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.vivaldi.net (Postfix) with ESMTP id 9DA60800998
 for <selinux@tycho.nsa.gov>; Mon, 23 Mar 2015 20:12:53 +0000 (GMT)
Received: from mail.vivaldi.net ([127.0.0.1])
 by localhost (wagner.vivaldi.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H7akYxOsnQUq for <selinux@tycho.nsa.gov>;
 Mon, 23 Mar 2015 20:12:53 +0000 (GMT)
Received: from mail.vivaldi.net (localhost [127.0.0.1])
 (Authenticated sender: john.chludzinski)
 by mail.vivaldi.net (Postfix) with ESMTPA id 713D48000D6
 for <selinux@tycho.nsa.gov>; Mon, 23 Mar 2015 20:12:51 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 23 Mar 2015 21:12:51 +0100
From: John Chludzinski <john.chludzinski@vivaldi.net>
To: Selinux <selinux@tycho.nsa.gov>
Subject: Added project policy code and got =?UTF-8?Q?=22semodule=5Fpackage?=
 =?UTF-8?Q?=3A=20=20=2E=2E=2E=22?=
Message-ID: <fb97f2e61c52ce5eb386dfe0ccd36cae@vivaldi.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I added project specific policy code to policy/module/<project-dir>.

Then I ran:

packages/clip-selinux-policy/clip-selinux-policy> make conf

>>> "make conf" added all the project module to "module" (e.g., projmod1 
>>> = module, projmod2 = module, etc.) in policy/modules.conf.

then I ran:

packages/clip-selinux-policy/clip-selinux-policy> make modules 
TYPE="mls" MLS_SENS=1

and got "semodule_package:  Failed to mmap tmp/<projmod1>.mod.fc:  
Invalid argument"

Any suggestions?

---John
