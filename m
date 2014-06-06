Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s56CbJuI003476
 for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2014 08:37:19 -0400
Received: by mail-pd0-f180.google.com with SMTP id y13so2371495pdi.25
 for <selinux@tycho.nsa.gov>; Fri, 06 Jun 2014 05:37:20 -0700 (PDT)
Received: from [192.168.1.2] ([117.214.173.6])
 by mx.google.com with ESMTPSA id hk5sm35404258pbb.86.2014.06.06.05.37.17
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Fri, 06 Jun 2014 05:37:20 -0700 (PDT)
Message-ID: <5391B555.4080100@gmail.com>
Date: Fri, 06 Jun 2014 18:04:29 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: RBAC along with MLS?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I'm learning SELinux on Fedora, here if you need to use MLS, you need to 
remove TE model cause the MLS is implemented in a completely different 
policy.

Is it possible to create a policy which supports both RABC/TE with MLS?
