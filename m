Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9OJPlG0023478
 for <selinux@tycho.nsa.gov>; Mon, 24 Oct 2016 15:25:47 -0400
Received: by mail-qt0-f197.google.com with SMTP id g49so191807668qtc.7
 for <selinux@tycho.nsa.gov>; Mon, 24 Oct 2016 12:25:45 -0700 (PDT)
MIME-Version: 1.0
From: David Graziano <david.graziano@rockwellcollins.com>
Date: Mon, 24 Oct 2016 14:25:24 -0500
Message-ID: <CA+RmS-_=5kQza1VcwXoqwF40nvXBv6t2z4=rESj494=nDJ7RnQ@mail.gmail.com>
Subject: POSIX mqueues
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I am attempting to write policy for a set of applications which use
POSIX mqueues using named type_transistion rules to uniquely label the
mqueue files in the /dev/mqueue directory then controlling access
based on the types. Standard type transition rules seem to work but I
cannot seem to get the named type transitions to apply the proper
label. Are named type transitions not supported by the mqueue file
system? I’m on a 3.14 series kernel with policy version 28 if that
helps. I’d like to avoid needing to do a restorecon after a new queue
is created. Named type transistions seem to work on other file systems
like tmp and jffs2.

Thanks in advance,
David Graziano
