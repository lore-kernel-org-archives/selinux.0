Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s388gc4C002921
 for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2014 04:42:39 -0400
Received: by mail-pa0-f44.google.com with SMTP id bj1so726980pad.31
 for <selinux@tycho.nsa.gov>; Tue, 08 Apr 2014 01:42:38 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.82.248])
 by mx.google.com with ESMTPSA id jd5sm3032624pbb.18.2014.04.08.01.42.36
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 08 Apr 2014 01:42:37 -0700 (PDT)
Message-ID: <5343B5EA.3010909@gmail.com>
Date: Tue, 08 Apr 2014 14:10:10 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: The purpose of SID.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

As I read in the SELinux docs, each subject and object is assigned a 
unique SID; when using the selinux libraries, or using the SELinux 
kernel API the programs are expected to request the security server 
decisions for a particular subject and object by passing the subject and 
object's SID to the security server.

Question is -- is SID created when an SELinux enabled kernel boots or 
just when a SELinux enabled program requests an SID for a subject/object 
from the kernel?

Also can I see a process's and file's SID via some program?
