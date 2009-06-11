Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5BFAee0015883
	for <selinux@tycho.nsa.gov>; Thu, 11 Jun 2009 11:10:40 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n5BFB3hm006979
	for <selinux@tycho.nsa.gov>; Thu, 11 Jun 2009 15:11:03 GMT
Subject: Re: [refpolicy] problem when compiling svn policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Justin Mattock <justinmattock@gmail.com>
Cc: tresys <refpolicy@oss1.tresys.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <dd18b0c30906101326l7f017005p7b581c74da4e83a3@mail.gmail.com>
References: <dd18b0c30906101326l7f017005p7b581c74da4e83a3@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 11 Jun 2009 11:09:59 -0400
Message-Id: <1244732999.21565.750.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-06-10 at 20:26 +0000, Justin Mattock wrote:
> I seem to be running into an issue while compiling
> the latest svn(just pulled, Ill test it out for you guys)
> I see this:

Can you provide more detail as to the build.conf settings?  I am not
able to reproduce this.

> make: *** No rule to make target
> `/etc/selinux/refpolicy/contexts/users/appconfig-standard', needed by
> `install'.  Stop.
> 
> if I copy config/appconfig-standard to /etc/selinux/refpolicy/*
> then the policy will compile all together.
> should I just  wait and pull the policy  later?
> 
> Also when doing make relabel I see this:
> 
> Relabeling filesystem types: ext2 ext3 xfs jfs
> /sbin/setfiles /etc/selinux/refpolicy/contexts/files/file_contexts /
> filespec_add:  conflicting specifications for
> /usr/lib/glibc/getconf/XBS5_ILP32_OFFBIG and /usr/bin/getconf, using
> system_u:object_r:bin_t.
> filespec_add:  conflicting specifications for
> /usr/lib/glibc/getconf/POSIX_V7_ILP32_OFF32 and
> /usr/lib/glibc/getconf/XBS5_ILP32_OFFBIG, using
> system_u:object_r:bin_t.
> filespec_add:  conflicting specifications for
> /usr/lib/glibc/getconf/POSIX_V6_ILP32_OFFBIG and
> /usr/lib/glibc/getconf/POSIX_V7_ILP32_OFF32, using
> system_u:object_r:bin_t.
> filespec_add:  conflicting specifications for
> /usr/lib/glibc/getconf/XBS5_ILP32_OFF32 and
> /usr/lib/glibc/getconf/POSIX_V6_ILP32_OFFBIG, using
> system_u:object_r:bin_t.
> filespec_add:  conflicting specifications for
> /usr/lib/glibc/getconf/POSIX_V7_ILP32_OFFBIG and
> /usr/lib/glibc/getconf/XBS5_ILP32_OFF32, using
> system_u:object_r:bin_t.
> filespec_add:  conflicting specifications for
> /usr/lib/glibc/getconf/POSIX_V6_ILP32_OFF32 and
> /usr/lib/glibc/getconf/POSIX_V7_ILP32_OFFBIG, using
> system_u:object_r:bin_t.
> filespec_eval:  hash table stats: 163158 elements, 29863/65536 buckets
> used, longest chain length 11
> 
> should I bee concerned, or is this something still being worked out?

It would seem that /usr/lib/glibc/getconf/XBS5_ILP32_OFFBIG
and /usr/bin/getconf are hardlinked, which is why there is a conflict
since they are lib_t and bin_t, respectively.  Which distribution?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
