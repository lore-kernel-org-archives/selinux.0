Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q26D7GL4017116
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2012 08:07:16 -0500
Message-ID: <4F560C02.3020805@tresys.com>
Date: Tue, 6 Mar 2012 08:07:14 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: <hanwen@xs4all.nl>
CC: Han-Wen Nienhuys <hanwenn@gmail.com>, <selinux@tycho.nsa.gov>
Subject: Re: Suppressing selinux label getxattrs on FUSE
References: <CAOw_e7YkXECVOO9JnP0FvWYMpdZ2PzPBQwEy3ppCd4GcVnwfEw@mail.gmail.com>
In-Reply-To: <CAOw_e7YkXECVOO9JnP0FvWYMpdZ2PzPBQwEy3ppCd4GcVnwfEw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/06/12 06:51, Han-Wen Nienhuys wrote:
> Hi there,
> 
> What is the best way to stop to SELinux from trying read ACL security
> labels for (FUSE) mounts?
> 
> Background:
> 
> From what I read, Selinux is not really working on FUSE filesystems,
> however, when I run a FUSE filesystem, I see various GETXATTR calls
> passing by asking for

SELinux uses the security.selinux xattr.
 
> security.capability

I'm guessing this is for fs capabilities.

> system.posix_acl_default
> system.posix_acl_access

POSIX ACL.

You'd presumably have to disable these mechanisms to eliminate this access.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
