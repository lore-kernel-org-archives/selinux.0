Date: Wed, 29 Sep 2004 19:45:41 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: policy patches
Message-ID: <20040929174540.GA4373@rom.cip.ifi.lmu.de>
References: <200409292354.15227.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <200409292354.15227.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Russell Coker <russell@coker.com.au> [2004-09-29 18:49]:
> diff -ru /usr/src/se/policy/domains/program/unused/rpm.te ./domains/program/unused/rpm.te
> --- /usr/src/se/policy/domains/program/unused/rpm.te	2004-09-21 14:39:14.000000000 +1000
> +++ ./domains/program/unused/rpm.te	2004-09-29 01:05:44.000000000 +1000
> @@ -16,9 +16,15 @@
>...
> +ifdef(`unlimitedUsers', `
> +role staff_r types rpm_t;
> +domain_auto_trans(staff_t, rpm_exec_t, rpm_t)
> +')

AFAIK unlimitedUsers was removed recently, so this snippet makes no
sense anymore.

> diff -ru /usr/src/se/policy/file_contexts/program/nagios.fc ./file_contexts/program/nagios.fc
> --- /usr/src/se/policy/file_contexts/program/nagios.fc	2004-06-17 03:38:16.000000000 +1000
> +++ ./file_contexts/program/nagios.fc	2004-09-24 20:44:24.000000000 +1000
> @@ -1,7 +1,10 @@
> -# netsaint - network monitoring server
> -/usr/sbin/netsaint		--	system_u:object_r:nagios_exec_t
> -#/var/run/netsaint(/.*)?		system_u:object_r:nagios_var_run_t
> -/etc/netsaint(/.*)?			system_u:object_r:nagios_etc_t
> +# nagios - network monitoring server
>  /var/log/netsaint(/.*)?			system_u:object_r:nagios_log_t
>  /usr/lib(64)?/netsaint/plugins(/.*)?		system_u:object_r:bin_t
>  /usr/lib(64)?/cgi-bin/netsaint/.+	--	system_u:object_r:nagios_cgi_exec_t
> +# nagios
> +/usr/bin/nagios			--	system_u:object_r:nagios_exec_t
> +/etc/nagios(/.*)?			system_u:object_r:nagios_etc_t
> +/var/log/nagios(/.*)?			system_u:object_r:nagios_log_t
> +/usr/lib(64)?/nagios/plugins(/.*)?	system_u:object_r:bin_t
> +/usr/lib(64)?/nagios/cgi/.+	--	system_u:object_r:nagios_cgi_exec_t

On Debian, it's
/usr/sbin/nagios                --      system_u:object_r:nagios_exec_t
and
/usr/lib/cgi-bin/nagios         --      system_u:object_r:nagios_cgi_exec_t

These should be added also.

Everything else looks fine.

Thomas

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
