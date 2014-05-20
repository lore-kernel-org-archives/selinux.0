Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4K53h0l001074
 for <selinux@tycho.nsa.gov>; Tue, 20 May 2014 01:03:43 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so6711621pad.25
 for <selinux@tycho.nsa.gov>; Mon, 19 May 2014 22:03:44 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.88.8])
 by mx.google.com with ESMTPSA id bu1sm743883pbb.54.2014.05.19.22.03.42
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 19 May 2014 22:03:43 -0700 (PDT)
Message-ID: <537AE191.7070403@gmail.com>
Date: Tue, 20 May 2014 10:31:05 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Significance of SELinux user and roles on objects.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I've read that the roles on objects (like files) are in reality of no 
use and are filled up just for the sake of filling. That's why every 
file has role object_r.

Which prompts me a question -- do the user and role of objects (like 
files) have any significance? Or can access be allowed/denied based on 
the object's role and user?
