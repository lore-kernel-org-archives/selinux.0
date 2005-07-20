Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6KE91gA016221
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 10:09:03 -0400 (EDT)
Received: from gw.linuon.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6KE3g9b006692
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 14:03:49 GMT
Message-ID: <42DE59C8.20208@linuon.com>
Date: Wed, 20 Jul 2005 23:03:52 +0900
From: Junji Kanemaru <linux@linuon.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: cvs and mta
References: <42D4D4AC.9010403@linuon.com> <42D4EB9B.2050701@redhat.com> <42D5D42B.9090705@linuon.com> <42D6456F.6040001@redhat.com>
In-Reply-To: <42D6456F.6040001@redhat.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Following worked. I still need cvs_t to have access to bin:dir
bin:lnk_file and sbin:lnk_file though.

#DESC cvs - Concurrent Versions System
#
# Author:  Dan Walsh <dwalsh@redhat.com>
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
allow cvs_t bin_t:dir search;
allow cvs_t bin_t:lnk_file read;
allow cvs_t sbin_t:lnk_file read;

Thank you for your help.

-- Junji

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
