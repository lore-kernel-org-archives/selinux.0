Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s445Q6Qf031219
 for <selinux@tycho.nsa.gov>; Sun, 4 May 2014 01:26:06 -0400
Received: by mail-pd0-f174.google.com with SMTP id w10so5560895pde.5
 for <selinux@tycho.nsa.gov>; Sat, 03 May 2014 22:26:06 -0700 (PDT)
Received: from [192.168.1.2] ([59.89.22.24])
 by mx.google.com with ESMTPSA id f5sm35713165pat.11.2014.05.03.22.26.04
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sat, 03 May 2014 22:26:05 -0700 (PDT)
Message-ID: <5365CECF.5010808@gmail.com>
Date: Sun, 04 May 2014 10:53:27 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: How does policy loading work at bootup?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Does the kernel automatically searches for and reads the policies in 
hard coded locations or does some userspace tool does that at startup 
via init/systemd scripts/units?
