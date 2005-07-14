Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6EApmgA001918
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2005 06:51:48 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6EAlfkZ021961
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2005 10:47:41 GMT
Message-ID: <42D6430C.1010404@redhat.com>
Date: Thu, 14 Jul 2005 06:48:44 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Junji Kanemaru <linux@linuon.com>
CC: selinux@tycho.nsa.gov
Subject: Re: cvs and mta
References: <42D4D4AC.9010403@linuon.com> <42D4EB9B.2050701@redhat.com> <42D5D42B.9090705@linuon.com>
In-Reply-To: <42D5D42B.9090705@linuon.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Junji Kanemaru wrote:

>Daniel J Walsh wrote:
>  
>
>>Does adding the line
>>
>>typeattribute cvs_t privmail;
>>
>>help?
>>    
>>
>
>It helped. It reduced the "allow" lines about hlaf.
>I still needed have followings:
>
>allow cvs_t bin_t:dir search;
>allow cvs_t bin_t:file { execute execute_no_trans getattr read };
>allow cvs_t bin_t:lnk_file read;
>allow cvs_t default_t:dir search;
>allow cvs_t default_t:lnk_file read;
>allow cvs_t devtty_t:chr_file { read write };
>allow cvs_t etc_runtime_t:file { getattr read };
>allow cvs_t sbin_t:dir search;
>allow cvs_t sbin_t:lnk_file read;
>allow cvs_t shadow_t:file read;
>allow cvs_t shell_exec_t:file { execute execute_no_trans getattr read };
>allow system_mail_t cvs_data_t:file read;
>
>Is there any simple way do above?
>
>Thanks,
>
>-- Junji
>  
>
How about the following?

What is it looking at that is marked default_t? I don't like those rules.

DESC cvs - Concurrent Versions System
#
# Author: Dan Walsh <dwalsh@redhat.com>
#
# Depends: inetd.te

#################################
#
# Rules for the cvs_t domain.
#
# cvs_exec_t is the type of the cvs executable.
#

inetd_child_domain(cvs, tcp)
typeattribute cvs_t privmail;
typeattribute cvs_t auth_chkpwd;

type cvs_data_t, file_type, sysadmfile;
create_dir_file(cvs_t, cvs_data_t)
can_exec(cvs_t, { bin_t sbin_t shell_exec_t })
allow cvs_t etc_runtime_t:file { getattr read };
allow system_mail_t cvs_data_t:file { getattr read };
dontaudit cvs_t devtty_t:chr_file { read write };
allow cvs_t default_t:dir search;
allow cvs_t default_t:lnk_file read;


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
