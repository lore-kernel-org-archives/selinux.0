Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u07LmNWQ013886
 for <selinux@tycho.nsa.gov>; Thu, 7 Jan 2016 16:48:23 -0500
Received: by mail-ig0-f176.google.com with SMTP id z14so61978831igp.0
 for <selinux@tycho.nsa.gov>; Thu, 07 Jan 2016 13:48:22 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 7 Jan 2016 14:48:21 -0700
Message-ID: <CAPubmWXt3Ds7T5V8rYBZKhLQKLymw7_un+d-eN-0_CwxU3BmMA@mail.gmail.com>
Subject: Diskless system running SELinux
From: Andrew Ruch <adruch2002@gmail.com>
To: SELinux ML <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

I'm researching deploying a diskless system that would use PXEBoot and
NFS for it's storage. I believe this capability has been proven and
have no issues here. The tricky part is this system must also have
Mandatory Access Control. I thought RHEL 7.2 was the answer due to
it's support of labeled NFS. However, Red Hat just told me that having
an SELinux-labeled, remote root partition is unsupported. What wasn't
clear was if the problem was in RHEL or something upstream.

Does the kernel support a labeled, remote root partition? If so, which
distributions support this?


Thanks,
Andrew Ruch
