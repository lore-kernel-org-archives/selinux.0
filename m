Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s44FWqRC026331
 for <selinux@tycho.nsa.gov>; Sun, 4 May 2014 11:32:52 -0400
Received: by mail-pa0-f46.google.com with SMTP id kx10so5264721pab.5
 for <selinux@tycho.nsa.gov>; Sun, 04 May 2014 08:32:52 -0700 (PDT)
Received: from [192.168.1.2] ([59.89.22.24])
 by mx.google.com with ESMTPSA id yo9sm47790369pab.16.2014.05.04.08.32.50
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sun, 04 May 2014 08:32:51 -0700 (PDT)
Message-ID: <53665D05.6070403@gmail.com>
Date: Sun, 04 May 2014 21:00:13 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: What's a module exactly?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I'm trying to verify what I think cause I've not read about this yet --

A SELinux 'module' is like a C object file; each module has a purpose of 
defining policies for a certain program.

Each module may be made a separate policy or many modules can be 
integrated into one policy file (like what Fedora has done).
