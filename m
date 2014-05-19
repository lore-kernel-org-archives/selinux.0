Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4J5Ff8K012302
 for <selinux@tycho.nsa.gov>; Mon, 19 May 2014 01:15:41 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so5304336pbc.16
 for <selinux@tycho.nsa.gov>; Sun, 18 May 2014 22:15:42 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.89.151])
 by mx.google.com with ESMTPSA id fe2sm7127198pbc.68.2014.05.18.22.15.40
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sun, 18 May 2014 22:15:41 -0700 (PDT)
Message-ID: <537992DF.9050806@gmail.com>
Date: Mon, 19 May 2014 10:43:03 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: How does SELinux work without roles?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

RBAC is completely optional in SELinux; however there appears to be no 
way to specify the allowed types for a particular user without 
specifying roles.

Without this, there'll be no enforcement.
