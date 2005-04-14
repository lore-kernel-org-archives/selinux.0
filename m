Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3EKHf7C020936
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 16:17:41 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3EKDuJd013328
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2005 20:13:56 GMT
Subject: Question: ROLE_file_type vs customizable
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
Content-Type: text/plain
Date: Thu, 14 Apr 2005 16:20:06 -0400
Message-Id: <1113510007.14090.5.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What is the purpose of "$1_file_type". How does that differ from
"customizable", besides embedding the user in the type? Should
customizable be $1_customizable instead, and then there can be a
centralized rule that allows ROLE_t relabelto/relabelfrom and other
privileges to ROLE_customizable ?

Here are all the allow rules associated with $1_file_type.
Why is gpg able to write to every file type marked with this attribute?

allow sysadm_gpg_t sysadm_file_type:dir { read getattr lock search ioctl
add_name remove_name write };
allow sysadm_gpg_t sysadm_file_type:file { create ioctl read getattr
lock write setattr append link unlink rename };
allow sysadm_gpg_t sysadm_file_type:lnk_file { create read getattr
setattr link unlink rename };
allow user_gpg_t user_file_type:dir { read getattr lock search ioctl
add_name remove_name write };
allow user_gpg_t user_file_type:file { create ioctl read getattr lock
write setattr append link unlink rename };
allow user_gpg_t user_file_type:lnk_file { create read getattr setattr
link unlink rename };
allow user_locate_t { home_root_t user_home_dir_t user_file_type }:dir
{ getattr search };
allow user_locate_t user_file_type:{ file lnk_file } { getattr read };
allow user_file_type user_home_t:filesystem associate;
allow staff_gpg_t staff_file_type:dir { read getattr lock search ioctl
add_name remove_name write };
allow staff_gpg_t staff_file_type:file { create ioctl read getattr lock
write setattr append link unlink rename };
allow staff_gpg_t staff_file_type:lnk_file { create read getattr setattr
link unlink rename };
allow staff_locate_t { home_root_t staff_home_dir_t
staff_file_type }:dir { getattr search };
allow staff_locate_t staff_file_type:{ file lnk_file } { getattr read };
allow staff_file_type staff_home_t:filesystem associate;

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
