Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s618oSl8011557
 for <selinux@tycho.nsa.gov>; Tue, 1 Jul 2014 04:50:28 -0400
Received: by mail-pd0-f171.google.com with SMTP id fp1so9769914pdb.30
 for <selinux@tycho.nsa.gov>; Tue, 01 Jul 2014 01:50:30 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.86.48])
 by mx.google.com with ESMTPSA id tr2sm113085033pab.26.2014.07.01.01.50.27
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 01 Jul 2014 01:50:29 -0700 (PDT)
Message-ID: <53B2759A.2030209@gmail.com>
Date: Tue, 01 Jul 2014 14:17:22 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Where's the class defined in file_contexts*
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The default security context of a object also depends on it's class.

I was looking at 
etc/selinux/<SELINUXTYPE>/contexts/files/file_contexts*, but I couldn't 
see any definition of a class.

Also semanage fcontext doesn't have an option define a class. Entries 
are based only on files and directories.

If you get red text in this email please notify.
