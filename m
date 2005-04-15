Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3FF1c7C027081
	for <selinux@tycho.nsa.gov>; Fri, 15 Apr 2005 11:01:38 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3FEsvFR001311
	for <selinux@tycho.nsa.gov>; Fri, 15 Apr 2005 14:54:57 GMT
Message-ID: <425FD50A.4090102@redhat.com>
Date: Fri, 15 Apr 2005 10:51:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: selinux@tycho.nsa.gov
Subject: Re: Question: ROLE_file_type vs customizable
References: <1113510007.14090.5.camel@cobra.ivg2.net>
In-Reply-To: <1113510007.14090.5.camel@cobra.ivg2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>What is the purpose of "$1_file_type". How does that differ from
>"customizable", besides embedding the user in the type? Should
>customizable be $1_customizable instead, and then there can be a
>centralized rule that allows ROLE_t relabelto/relabelfrom and other
>privileges to ROLE_customizable ?
>  
>
Customizable is just a flag to tell restorecon/setfiles/fixfiles not to 
mess with this file_context.
So no their should only be one type.  $1_file_type is a type the a user 
can manipulate specific
to the user.

>Here are all the allow rules associated with $1_file_type.
>Why is gpg able to write to every file type marked with this attribute?
>
>allow sysadm_gpg_t sysadm_file_type:dir { read getattr lock search ioctl
>add_name remove_name write };
>allow sysadm_gpg_t sysadm_file_type:file { create ioctl read getattr
>lock write setattr append link unlink rename };
>allow sysadm_gpg_t sysadm_file_type:lnk_file { create read getattr
>setattr link unlink rename };
>allow user_gpg_t user_file_type:dir { read getattr lock search ioctl
>add_name remove_name write };
>allow user_gpg_t user_file_type:file { create ioctl read getattr lock
>write setattr append link unlink rename };
>allow user_gpg_t user_file_type:lnk_file { create read getattr setattr
>link unlink rename };
>allow user_locate_t { home_root_t user_home_dir_t user_file_type }:dir
>{ getattr search };
>allow user_locate_t user_file_type:{ file lnk_file } { getattr read };
>allow user_file_type user_home_t:filesystem associate;
>allow staff_gpg_t staff_file_type:dir { read getattr lock search ioctl
>add_name remove_name write };
>allow staff_gpg_t staff_file_type:file { create ioctl read getattr lock
>write setattr append link unlink rename };
>allow staff_gpg_t staff_file_type:lnk_file { create read getattr setattr
>link unlink rename };
>allow staff_locate_t { home_root_t staff_home_dir_t
>staff_file_type }:dir { getattr search };
>allow staff_locate_t staff_file_type:{ file lnk_file } { getattr read };
>allow staff_file_type staff_home_t:filesystem associate;
>
>  
>


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
