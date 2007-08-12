Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7CGsBTt013664
	for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2007 12:54:11 -0400
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7CGsA2u001846
	for <selinux@tycho.nsa.gov>; Sun, 12 Aug 2007 16:54:10 GMT
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588EDE93E@exchange.columbia.tresys.com>
References: <BA7830DA-8473-4AE5-B2CF-50DC614E5932@sf-net.com> <6FE441CD9F0C0C479F2D88F959B01588EDE93E@exchange.columbia.tresys.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/mixed; boundary=Apple-Mail-3-324530896
Message-Id: <F3FB9554-D056-4BF8-8E0D-0797DABD3E5A@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Re: [refpolicy] awstats
Date: Sun, 12 Aug 2007 18:54:04 +0200
To: "Brian M. Williams" <bwilliams@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-3-324530896
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Thanks for the advice. Attached is a new/corrected policy.


--Apple-Mail-3-324530896
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

--Apple-Mail-3-324530896
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=awstats.te
Content-Disposition: attachment;
	filename=awstats.te


policy_module(awstats,1.0.0)

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

kernel_dontaudit_read_system_state(awstats_t)

apache_content_template(awstats)

domtrans_pattern(awstats_t, httpd_awstats_script_exec_t, httpd_awstats_script_t)

allow awstats_t self:fifo_file { getattr ioctl read };

dontaudit awstats_t proc_t:file { getattr read };
allow awstats_t httpd_awstats_content_t:dir search;
allow awstats_t httpd_awstats_script_exec_t:dir search;

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
	cron_use_fds(httpd_awstats_script_t)
	cron_read_pipes(httpd_awstats_script_t)
')


--Apple-Mail-3-324530896
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed



On 12.08.2007, at 18:22, Brian M. Williams wrote:

> A few notes:
>
> gen_require(`
> 	type proc_t;
> ')
> dontaudit awstats_t proc_t:file { getattr read };
>
> can be done with:
> kernel_dontaudit_read_system_state(awstats_t)
>
>
> allow httpd_awstats_script_t crond_t:fd use;
> allow httpd_awstats_script_t crond_t:fifo_file { ioctl read };
>
> can be done with:
> cron_use_fds(httpd_awstats_script_t)
> cron_read_pipes(httpd_awstats_script_t)
>
> Also the dontaudit search of sbin can be removed as bin and sbin  
> are now
> the same thing type wise.  If you want this for backwards  
> compatability
> use the corecmd_dontaudit_search_sbin() interface.
>
>
>> -----Original Message-----
>> From: owner-selinux@tycho.nsa.gov [mailto:owner- 
>> selinux@tycho.nsa.gov]
> On Behalf Of Stefan Schulze
>> Frielinghaus
>> Sent: Sunday, August 12, 2007 5:34 AM
>> To: Christopher J. PeBenito
>> Cc: SELinux List
>> Subject: [refpolicy] awstats
>>
>> Attached is a new policy for awstats
>


--Apple-Mail-3-324530896--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
