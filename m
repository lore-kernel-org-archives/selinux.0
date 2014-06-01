Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s51FMGYp019968
 for <selinux@tycho.nsa.gov>; Sun, 1 Jun 2014 11:22:16 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so3389975pbb.11
 for <selinux@tycho.nsa.gov>; Sun, 01 Jun 2014 08:22:17 -0700 (PDT)
Received: from [192.168.1.2] ([117.214.168.104])
 by mx.google.com with ESMTPSA id wi14sm18505529pac.22.2014.06.01.08.22.15
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sun, 01 Jun 2014 08:22:16 -0700 (PDT)
Message-ID: <538B4487.8050807@gmail.com>
Date: Sun, 01 Jun 2014 20:49:35 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: How does matchpathcon/setfiles work?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

As we know, policies don't contain paths. So the working of 
matchpathcon/setfiles must be based on common sense.

It looks like it knows certain special folders and it's appropriate 
security context, for e.g. home folder contents should have files with 
user_home_t and suggests the correct SELinux user for the 
files/directories based on which user's home folder is it.

Other directories/files should have the same security context as the 
parent directory, like with /opt.

Is this correct?
