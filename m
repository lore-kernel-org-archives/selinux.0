Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6E2xOgA000278
	for <selinux@tycho.nsa.gov>; Wed, 13 Jul 2005 22:59:24 -0400 (EDT)
Received: from gw.linuon.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6E2u2vl002572
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2005 02:56:03 GMT
Message-ID: <42D5D42B.9090705@linuon.com>
Date: Thu, 14 Jul 2005 11:55:39 +0900
From: Junji Kanemaru <linux@linuon.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: cvs and mta
References: <42D4D4AC.9010403@linuon.com> <42D4EB9B.2050701@redhat.com>
In-Reply-To: <42D4EB9B.2050701@redhat.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Does adding the line
> 
> typeattribute cvs_t privmail;
> 
> help?

It helped. It reduced the "allow" lines about hlaf.
I still needed have followings:

allow cvs_t bin_t:dir search;
allow cvs_t bin_t:file { execute execute_no_trans getattr read };
allow cvs_t bin_t:lnk_file read;
allow cvs_t default_t:dir search;
allow cvs_t default_t:lnk_file read;
allow cvs_t devtty_t:chr_file { read write };
allow cvs_t etc_runtime_t:file { getattr read };
allow cvs_t sbin_t:dir search;
allow cvs_t sbin_t:lnk_file read;
allow cvs_t shadow_t:file read;
allow cvs_t shell_exec_t:file { execute execute_no_trans getattr read };
allow system_mail_t cvs_data_t:file read;

Is there any simple way do above?

Thanks,

-- Junji

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
