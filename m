Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i95DEjrT025758
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 09:14:45 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i95DDbPe017138
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 13:13:38 GMT
Message-ID: <41629E45.8050107@gentoo.org>
Date: Tue, 05 Oct 2004 09:14:45 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: petre rodan <kaiowas@gentoo.org>
CC: selinux@tycho.nsa.gov
Subject: Re: gentoo diff for ntpd
References: <41625A62.7080609@gentoo.org>
In-Reply-To: <41625A62.7080609@gentoo.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Since peter forgot to introduce himself :) he just started with gentoo 
to give us some badly needed policy help which will hopefully allow us 
to start sending more policy upstream. Thanks peter

Also, this diff is to make openntpd work with the current ntp policy, so 
  a tunable other than distro_gentoo might be appropriate, or none at all.

Joshua Brindle


petre rodan wrote:

> Hi!
> 
> This is a very small diff that would make the gentoo community happy :)
> 
> reference:
> http://bugs.gentoo.org/show_bug.cgi?id=59633
> 
> many thanks,
> peter
> 
> 
> ------------------------------------------------------------------------
> 
> --- /root/public_html/policy/nsa/file_contexts/program/ntpd.fc	2004-06-25 23:02:43.000000000 +0300
> +++ /etc/security/selinux/src/policy/file_contexts/program/ntpd.fc	2004-10-05 10:20:01.034334096 +0300
> @@ -10,3 +10,11 @@
>  /var/run/ntpd.pid		--	system_u:object_r:ntpd_var_run_t
>  /etc/cron\.(daily|weekly)/ntp-simple -- system_u:object_r:ntpd_exec_t
>  /etc/cron\.(daily|weekly)/ntp-server -- system_u:object_r:ntpd_exec_t
> +
> +ifdef(`distro_gentoo', `
> +/usr/bin/ntpd			--	system_u:object_r:ntpd_exec_t
> +/usr/bin/ntpdate		--	system_u:object_r:ntpd_exec_t
> +
> +# for net-misc/openntpd
> +/etc/ntpd\.conf			--	system_u:object_r:net_conf_t
> +')
> --- /root/public_html/policy/nsa/domains/program/unused/ntpd.te	2004-10-02 01:38:20.000000000 +0300
> +++ /etc/security/selinux/src/policy/domains/program/ntpd.te	2004-10-05 04:23:53.935260872 +0300
> @@ -69,3 +69,8 @@
>  ifdef(`firstboot.te', `
>  dontaudit ntpd_t firstboot_t:fd { use };
>  ')
> +
> +ifdef(`distro_gentoo', `
> +allow ntpd_t self:capability { sys_chroot kill };
> +')
> +


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
