Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3HG03QU018274
 for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2014 12:00:03 -0400
Received: by mail-ee0-f43.google.com with SMTP id e53so833064eek.2
 for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2014 09:00:01 -0700 (PDT)
Received: from [192.168.0.129] (d205.fem.tu-ilmenau.de. [141.24.49.205])
 by mx.google.com with ESMTPSA id t50sm68496004eev.28.2014.04.17.09.00.00
 for <selinux@tycho.nsa.gov>
 (version=SSLv3 cipher=RC4-SHA bits=128/128);
 Thu, 17 Apr 2014 09:00:00 -0700 (PDT)
Message-ID: <1397793520.8610.3.camel@akshay-desktop>
Subject: Regarding call security_compute_av()
From: Kernel Geek <kernelfreak@gmail.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Fri, 18 Apr 2014 05:58:40 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


Hello friends,
             I just had a few questions about the above mentioned call
which is located in selinux/ss/services.c. Questions as follows :

1) As the calls documentation reads, it is responsible for computing
access decisions for source and target security contexts. Does that
means if the call is always returns 0 then access would be permitted? Is
that a valid logic? I believe value of rc says if access is allowed or not?

2) I noticed it calls context_struct_compute_av() which initializes AVC
defaults, does preliminary checks and returns value of rc. Is my reasoning 
correct?

3) Who calls security_compute_av() ? 

Some of my questions may sound rhetorical, but I am just getting my thought
process straight. Thank you very much guys. Cheers. :-)
