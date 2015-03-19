Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2JKVFLd011544
 for <selinux@tycho.nsa.gov>; Thu, 19 Mar 2015 16:31:15 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.vivaldi.net (Postfix) with ESMTP id 6B48A800C64
 for <selinux@tycho.nsa.gov>; Thu, 19 Mar 2015 20:31:11 +0000 (GMT)
Received: from mail.vivaldi.net ([127.0.0.1])
 by localhost (wagner.vivaldi.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T9fPSPNJwHNq for <selinux@tycho.nsa.gov>;
 Thu, 19 Mar 2015 20:31:11 +0000 (GMT)
Received: from mail.vivaldi.net (localhost [127.0.0.1])
 (Authenticated sender: john.chludzinski)
 by mail.vivaldi.net (Postfix) with ESMTPA id 22A8C80019D
 for <selinux@tycho.nsa.gov>; Thu, 19 Mar 2015 20:31:09 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 19 Mar 2015 21:31:09 +0100
From: John Chludzinski <john.chludzinski@vivaldi.net>
To: selinux@tycho.nsa.gov
Subject: Trying to update sysadm module in CLIP
Message-ID: <e4247c48f0174b6f77f05c5b28bbcb9e@vivaldi.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

First thing ... I'm a newbie to SELinux.

I'm trying to update the sysadm module in a CLIP image. I downloaded the 
SELinux policy code from: https://github.com/QuarkSecurity/CLIP.  I 
modified the sysadm policy code and built (in 
~/clip/packages/clip-selinux-policy/clip-selinux-policy) using:

$ make modules APPS_MODS="sysadm"

Then I tried to install in the CLIP image using:

$ semodule -i /mnt/hdd/SELinix/sysadm.pp

and got: "tried to link in a non-MLS module with an MLS base". (I assume 
this means the CLIP image I'm working with is MLS?)
Next I built using:

$ make modules APPS_MODS="sysadm" TYPE="mls"

Tried to load/install the module and got: "sensitivy s10 not declared by 
base."

Next I tried:

$ make modules APPS_MODS="auditadm sysadm" TYPE="mls" MLS_SENS=15

and !still! got "sensitivy s10 not declared by base".

Any suggestions/thoughts?

---John
