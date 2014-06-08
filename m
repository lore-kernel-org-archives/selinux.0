Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s58Ep3id018264
 for <selinux@tycho.nsa.gov>; Sun, 8 Jun 2014 10:51:03 -0400
Received: by mail-ie0-f172.google.com with SMTP id lx4so1448048iec.17
 for <selinux@tycho.nsa.gov>; Sun, 08 Jun 2014 07:51:05 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.81.13])
 by mx.google.com with ESMTPSA id l5sm65736175igr.15.2014.06.08.07.51.02
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sun, 08 Jun 2014 07:51:04 -0700 (PDT)
Message-ID: <539477AF.20408@gmail.com>
Date: Sun, 08 Jun 2014 20:18:15 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Default context with context mount option.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When a new file is created on a FS which supports security namespace but 
the FS is mounted using context= option, then what will be the context 
of the newly created file on the FS?

I did exactly this, and next, umount and then mount the FS readonly to 
get the getfattr dump to realize the security namespace is not empty 
(this came as a surprise).

So, can someone explain what exactly happens in this case?

Thanks.
