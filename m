Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6D7cVFi020464
 for <selinux@tycho.nsa.gov>; Sun, 13 Jul 2014 03:38:31 -0400
Received: by mail-pa0-f44.google.com with SMTP id rd3so3705950pab.17
 for <selinux@tycho.nsa.gov>; Sun, 13 Jul 2014 00:38:33 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.80.210])
 by mx.google.com with ESMTPSA id ce9sm9551034pdb.49.2014.07.13.00.38.31
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sun, 13 Jul 2014 00:38:33 -0700 (PDT)
Message-ID: <53C2376F.7040805@gmail.com>
Date: Sun, 13 Jul 2014 13:08:23 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Where does semanage store changes?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Except when deleting and adding modules (when the main policy binary 
changes; did a checksum to verify that), where are other changes which 
semanage makes (like change boolean values, users, port, interface, 
node) stored?
