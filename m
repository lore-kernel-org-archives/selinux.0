Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0EFX6nH022392
 for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2017 10:33:07 -0500
Received: by mail-wm0-f44.google.com with SMTP id c85so102757605wmi.1
 for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2017 07:33:02 -0800 (PST)
MIME-Version: 1.0
From: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Sat, 14 Jan 2017 16:33:00 +0100
Message-ID: <CAPzO=NwAzL1_XDVC3zeR_CH-4khEJs3NnhBYSN1xewMB1DOwOg@mail.gmail.com>
Subject: audit.py required for seobject.py
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all,

In seobject.py, there are a few calls to
audit.audit_encode_nv_string() which seem to make the use of audit.py
as offered by the Linux audit daemon's python support mandatory. In
the past, the use of this audit module was not mandatory (cfr also
seobject.py's wrapped usage of audit in the beginning).

Should we still focus on supporting semanage on systems without Linux
audit? If so, do we need to wrap these calls?

Wkr,
  Sven Vermeulen

PS Sorry for the first incomplete mail submission...
