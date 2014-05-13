Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4D9oibq031976
 for <selinux@tycho.nsa.gov>; Tue, 13 May 2014 05:50:44 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so85032pab.38
 for <selinux@tycho.nsa.gov>; Tue, 13 May 2014 02:50:44 -0700 (PDT)
Received: from [192.168.1.2] ([117.214.171.24])
 by mx.google.com with ESMTPSA id gg3sm27311009pbc.34.2014.05.13.02.50.42
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 13 May 2014 02:50:43 -0700 (PDT)
Message-ID: <5371EA55.703@gmail.com>
Date: Tue, 13 May 2014 15:18:05 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Presidency of user/role/type permissions.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

For a process's security context (user, role, type), there maybe a 
conflict in the policy. for e.g. for user user_u, access to the kernel's 
ring buffer may not be allowed, but for role role_r, it may be allowed. 
The same process will have user_u and role_r.

So in case of conflicting permissions between user, role and type who's 
permission will the security server respect -- user's, role's or type's?
