Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5AKQRLT030364
	for <selinux@tycho.nsa.gov>; Wed, 10 Jun 2009 16:26:27 -0400
Received: from mail-yx0-f197.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5AKQHwm001543
	for <selinux@tycho.nsa.gov>; Wed, 10 Jun 2009 20:26:17 GMT
Received: by yxe35 with SMTP id 35so204557yxe.32
        for <selinux@tycho.nsa.gov>; Wed, 10 Jun 2009 13:26:26 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 10 Jun 2009 20:26:26 +0000
Message-ID: <dd18b0c30906101326l7f017005p7b581c74da4e83a3@mail.gmail.com>
Subject: problem when compiling svn policy
From: Justin Mattock <justinmattock@gmail.com>
To: tresys <refpolicy@oss1.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I seem to be running into an issue while compiling
the latest svn(just pulled, Ill test it out for you guys)
I see this:

make: *** No rule to make target
`/etc/selinux/refpolicy/contexts/users/appconfig-standard', needed by
`install'.  Stop.

if I copy config/appconfig-standard to /etc/selinux/refpolicy/*
then the policy will compile all together.
should I just  wait and pull the policy  later?

Also when doing make relabel I see this:

Relabeling filesystem types: ext2 ext3 xfs jfs
/sbin/setfiles /etc/selinux/refpolicy/contexts/files/file_contexts /
filespec_add:  conflicting specifications for
/usr/lib/glibc/getconf/XBS5_ILP32_OFFBIG and /usr/bin/getconf, using
system_u:object_r:bin_t.
filespec_add:  conflicting specifications for
/usr/lib/glibc/getconf/POSIX_V7_ILP32_OFF32 and
/usr/lib/glibc/getconf/XBS5_ILP32_OFFBIG, using
system_u:object_r:bin_t.
filespec_add:  conflicting specifications for
/usr/lib/glibc/getconf/POSIX_V6_ILP32_OFFBIG and
/usr/lib/glibc/getconf/POSIX_V7_ILP32_OFF32, using
system_u:object_r:bin_t.
filespec_add:  conflicting specifications for
/usr/lib/glibc/getconf/XBS5_ILP32_OFF32 and
/usr/lib/glibc/getconf/POSIX_V6_ILP32_OFFBIG, using
system_u:object_r:bin_t.
filespec_add:  conflicting specifications for
/usr/lib/glibc/getconf/POSIX_V7_ILP32_OFFBIG and
/usr/lib/glibc/getconf/XBS5_ILP32_OFF32, using
system_u:object_r:bin_t.
filespec_add:  conflicting specifications for
/usr/lib/glibc/getconf/POSIX_V6_ILP32_OFF32 and
/usr/lib/glibc/getconf/POSIX_V7_ILP32_OFFBIG, using
system_u:object_r:bin_t.
filespec_eval:  hash table stats: 163158 elements, 29863/65536 buckets
used, longest chain length 11

should I bee concerned, or is this something still being worked out?

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
