Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7C9Ygmr026111
	for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2007 05:34:42 -0400
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7C9Ye28011686
	for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2007 09:34:41 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
To: "Christopher PeBenito J." <cpebenito@tresys.com>
Message-Id: <BA7830DA-8473-4AE5-B2CF-50DC614E5932@sf-net.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-2-298135624
Cc: SELinux List <selinux@tycho.nsa.gov>
Subject: [refpolicy] awstats
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Date: Sun, 12 Aug 2007 11:34:09 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-2-298135624
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Attached is a new policy for awstats


--Apple-Mail-2-298135624
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=awstats.fc
Content-Disposition: attachment;
	filename=awstats.fc

/usr/share/awstats/tools/.+\.pl			gen_context(system_u:object_r:awstats_exec_t,s0)
/usr/share/awstats/wwwroot(/.*)?		gen_context(system_u:object_r:httpd_awstats_content_t,s0)
/usr/share/awstats/wwwroot/cgi-bin(/.*)?	gen_context(system_u:object_r:httpd_awstats_script_exec_t,s0)

/etc/awstats(/.*)?				gen_context(system_u:object_r:awstats_conf_t,s0)

/var/lib/awstats(/.*)?				gen_context(system_u:object_r:awstats_var_lib_t,s0)

--Apple-Mail-2-298135624
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=awstats.te
Content-Disposition: attachment;
	filename=awstats.te


policy_module(awstats,1.0.0)

gen_require(`
	type proc_t;
')

type awstats_t;
type awstats_exec_t;
domain_type(awstats_t)
init_daemon_domain(awstats_t,awstats_exec_t)
role system_r types awstats_t;

type awstats_conf_t;
files_config_file(awstats_conf_t)

type awstats_var_lib_t;
files_type(awstats_var_lib_t)
manage_files_pattern(awstats_t, awstats_var_lib_t, awstats_var_lib_t)
manage_files_pattern(httpd_awstats_script_t, awstats_var_lib_t, awstats_var_lib_t)

files_var_lib_filetrans(awstats_t,awstats_var_lib_t,file)

files_search_var_lib(httpd_awstats_script_t)

read_files_pattern(awstats_t, awstats_conf_t, awstats_conf_t)
read_files_pattern(httpd_awstats_script_t, awstats_conf_t, awstats_conf_t)

files_search_etc(awstats_t)

read_files_pattern(httpd_t, httpd_awstats_content_t, httpd_awstats_content_t)

apache_content_template(awstats)

domtrans_pattern(awstats_t, httpd_awstats_script_exec_t, httpd_awstats_script_t)

allow awstats_t self:fifo_file { getattr ioctl read };

dontaudit awstats_t proc_t:file { getattr read };
allow awstats_t httpd_awstats_content_t:dir search;
allow awstats_t httpd_awstats_script_exec_t:dir search;
dontaudit awstats_t sbin_t:dir search;

apache_read_log(httpd_awstats_script_t)

libs_use_ld_so(awstats_t)
libs_use_shared_libs(awstats_t)

dev_read_urand(awstats_t)

corecmd_exec_bin(awstats_t)
corecmd_exec_shell(awstats_t)

# /etc/resolv.conf
sysnet_read_config(httpd_awstats_script_t)

optional_policy(`
	cron_system_entry(awstats_t, awstats_exec_t)
	allow httpd_awstats_script_t crond_t:fd use;
	allow httpd_awstats_script_t crond_t:fifo_file { ioctl read };
')


--Apple-Mail-2-298135624--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
