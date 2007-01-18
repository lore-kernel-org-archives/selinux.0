Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0IKxYL5019981
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2007 15:59:34 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0IL0Sih029065
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2007 21:00:29 GMT
Message-ID: <45AFDFC2.2080000@mentalrootkit.com>
Date: Thu, 18 Jan 2007 15:59:46 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: New policy patterns and policy generation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was looking into supporting the new policy patterns refpolicy work for 
policy generation. Looking at many of the patterns, they include a 
container type, e.g.,

create_files_pattern(foo_t, var_log_t, foo_log_t)

This is going to be difficult to generate based on audit logs because 
there is no way to correlate the directory access with files. An audit 
log might show the following access denied:

allow foo_t foo_log_t : file create_file_perms;
allow foo_t var_log_t : dir rw_dir_perms;
allow foo_t etc_t : dir rw_dir_perms;

There is no real way to determine which of the directory permissions 
should be paired with the file creation (path is too unreliable to use I 
think).

Not being able to generate these is not a huge deal, but I think that it 
exposes a deeper problem. I suggest that these permissions should remain 
decoupled, as the current patterns imply access that is different from 
what is actually allowed. For example,

create_files_pattern(foo_t, var_log_t, foo_log_t)
create_files_pattern(foo_t, etc_t, foo_etc_t)

This - to me - implies that foo_t can create files of type foo_log_t in 
directories of type var_log_t and files of type foo_etc_t in directories 
of type etc_t. Of course, that is not what is allowed - foo_t can create 
either file type in either directory type.

I think that policy writers - even fairly experienced policy writers - 
are going to be surprised at the "additional" permissions allowed. The 
old permissions, for example

allow foo_t { var_log_t foo_etc_t } : file create_file_perms;
allow foo_t { etc_t var_log_t } : dir rw_dir_perms;

much more correctly convey the access that is granted (at least to me) 
and are easy to generate from audit data.

Comments?

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
