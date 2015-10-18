Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9I8J4jD028397
 for <selinux@tycho.nsa.gov>; Sun, 18 Oct 2015 04:19:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.jlbond.com (Postfix) with ESMTP id 7303B79BEB
 for <selinux@tycho.nsa.gov>; Sun, 18 Oct 2015 01:19:01 -0700 (PDT)
Received: from mail.jlbond.com ([127.0.0.1])
 by localhost (mail.jlbond.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id KvixHH-vuto9 for <selinux@tycho.nsa.gov>;
 Sun, 18 Oct 2015 01:19:00 -0700 (PDT)
Received: from [192.168.0.111] (firewall.bbky.org [192.168.0.1])
 by mail.jlbond.com (Postfix) with ESMTP id 917DB78D13
 for <selinux@tycho.nsa.gov>; Sun, 18 Oct 2015 01:19:00 -0700 (PDT)
Message-ID: <562355F4.2040303@jlbond.com>
Date: Sun, 18 Oct 2015 01:19:00 -0700
From: Bond Masuda <bond.masuda@jlbond.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: how to troubleshoot SELinux when auditd won't start?
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I'm running into an issue where SELinux is preventing auditd from 
starting. But I can't figure out exactly what SELinux is not happy about 
since without auditd, I can't look for AVC messages. I think SELinux is 
blocking auditd from starting up because auditd starts up once I do 
'setenforce 0'.

Any advice?
Bond
