Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0EFUfjv021585
 for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2017 10:30:41 -0500
Received: by mail-wm0-f43.google.com with SMTP id c85so102707497wmi.1
 for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2017 07:30:36 -0800 (PST)
MIME-Version: 1.0
From: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Sat, 14 Jan 2017 16:30:35 +0100
Message-ID: <CAPzO=NxmV26JeHEvyz0PTit+cOddw9HqDKtkg-oqVpc-4-cXkw@mail.gmail.com>
Subject: audit.py required for seobject.py?
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all,

In seobject.py, there are a few calls to
