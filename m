Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q26Bpn7b012634
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2012 06:51:49 -0500
Received: by iaoo28 with SMTP id o28so7558065iao.12
        for <selinux@tycho.nsa.gov>; Tue, 06 Mar 2012 03:51:47 -0800 (PST)
MIME-Version: 1.0
Reply-To: hanwen@xs4all.nl
Date: Tue, 6 Mar 2012 08:51:47 -0300
Message-ID: <CAOw_e7YkXECVOO9JnP0FvWYMpdZ2PzPBQwEy3ppCd4GcVnwfEw@mail.gmail.com>
Subject: Suppressing selinux label getxattrs on FUSE
From: Han-Wen Nienhuys <hanwenn@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi there,

What is the best way to stop to SELinux from trying read ACL security
labels for (FUSE) mounts?

Background:

>From what I read, Selinux is not really working on FUSE filesystems,
however, when I run a FUSE filesystem, I see various GETXATTR calls
passing by asking for

security.capability
system.posix_acl_default
system.posix_acl_access

In the most common use case, it is the user that runs the FUSE daemon,
and the mount is only visible to him.  In this case, inspection of
security/access labels haves no sense at all. Since the calls have
overhead (each one requires a context switch, costing about 10us), I
would like to suppress them.

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
