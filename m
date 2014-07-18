Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6I0WRu9030222
 for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2014 20:32:27 -0400
Message-ID: <1405643284.28501.YahooMailNeo@web120705.mail.ne1.yahoo.com>
Date: Thu, 17 Jul 2014 17:28:04 -0700
From: Andy Ruch <adruch2002@yahoo.com>
Subject: why does kernel call setenforce
To: SELinux ML <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: Andy Ruch <adruch2002@yahoo.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

This is more of an educational question. I'm running a custom policy on RHEL 6.5.


Why does the kernel call setenforce only after the selinux policy RPM has been updated? Out of the box, I don't see any AVCs. Once I update the policy, I see an AVC for "kernel_t security_t:security setenforce". Is the kernel setting SELinux to permissive or enforcing during those calls? 


Thanks,
Andrew Ruch
