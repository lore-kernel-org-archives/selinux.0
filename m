Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s9AN5XdE012837
 for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2014 19:05:33 -0400
Received: by mail-qc0-f180.google.com with SMTP id x3so2698006qcv.39
 for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2014 16:05:31 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 10 Oct 2014 16:05:31 -0700
Message-ID: <CAFftDdrTMJrq5P=+vkJeQ612Ndr5G-_qc5Ve10k1F2KJfQpZGA@mail.gmail.com>
Subject: fs_use_trans
From: William Roberts <bill.c.roberts@gmail.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The docs for fs_use_trans state:

The fs_use_trans statement is used to allocate a security context to
pseudo filesystems such as pseudo terminals and temporary objects. The
assigned context is derived from the creating process and that of the
filesystem type based on transition rules.


Can someone give me an example? For instance if I had:

fs_use_trans devpts u:object_r:devpts:s0;

and a daemon running with context:
u:r:init:s0

and it creates something on the devpts, what is the resulting context
of the object?

Thanks,
Bill
