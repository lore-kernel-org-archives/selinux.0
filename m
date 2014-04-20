Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3KCPosN005599
 for <selinux@tycho.nsa.gov>; Sun, 20 Apr 2014 08:25:50 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so2834641pdi.30
 for <selinux@tycho.nsa.gov>; Sun, 20 Apr 2014 05:25:50 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.83.108])
 by mx.google.com with ESMTPSA id ov4sm66966386pbc.46.2014.04.20.05.25.48
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sun, 20 Apr 2014 05:25:49 -0700 (PDT)
Message-ID: <5353BC31.3070404@gmail.com>
Date: Sun, 20 Apr 2014 17:53:13 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Why is SELINUXTYPE policy specific?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

There are 3 security models in which SELinux can work -- TE, RBAC and MLS.

And there are 6 types of SELinux policies --

targeted, mls, mcs, standard, strict or minimum.

Each security model requires it's own set of policies and the policies 
can be 1 of the 6 types. So can all the 3 security modles and 6 types be 
intermixed? Won't there be conflicts like with MLS and RBAC?
