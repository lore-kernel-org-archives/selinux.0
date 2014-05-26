Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4Q6L54A013608
 for <selinux@tycho.nsa.gov>; Mon, 26 May 2014 02:21:05 -0400
Received: by mail-pa0-f48.google.com with SMTP id rd3so7131683pab.35
 for <selinux@tycho.nsa.gov>; Sun, 25 May 2014 23:21:05 -0700 (PDT)
Received: from [192.168.1.2] ([59.89.21.101])
 by mx.google.com with ESMTPSA id fk4sm53455738pab.23.2014.05.25.23.21.03
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sun, 25 May 2014 23:21:04 -0700 (PDT)
Message-ID: <5382DCB2.3010400@gmail.com>
Date: Mon, 26 May 2014 11:48:26 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: The use of fscontext(iso9660_t)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The obvious point of a type value for a certain FS is to restrict 
programs from doing things which are not allowed on that FS.

iso9660/UDF etc... is a RO FS. So writing on it should not be allowed. 
But I can write to files having this security context.

So what's the utility of, atleast iso9660_t?
