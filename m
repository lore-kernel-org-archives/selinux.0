Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l87BXkNo008190
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 07:33:47 -0400
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l87BXj3p005402
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 11:33:46 GMT
In-Reply-To: <1189105767.3664.40.camel@gorn>
References: <50C59BF9-3A4B-4BC2-8F78-F0CFC68592D7@sf-net.com> <3A263A5A-F7A7-4A40-B066-C0A4B56386C8@sf-net.com> <1189105767.3664.40.camel@gorn>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/mixed; boundary=Apple-Mail-2-404181393
Message-Id: <03970691-89EF-41A5-B14C-70CBF0681056@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Re: [refpolicy] dovecot: handling of hard links
Date: Fri, 7 Sep 2007 13:32:58 +0200
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-2-404181393
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On 06.09.2007, at 21:09, Christopher J. PeBenito wrote:

> On Tue, 2007-08-28 at 14:59 +0200, Stefan Schulze Frielinghaus wrote:
>> Oh I forgot the only thing which doesn't really run quit fine is init
>> now:
>>
>> avc:  denied  { unlink } for  pid=1175 comm="rm" name="ssl-
>> parameters.dat" dev=hda7 ino=2129980
>> scontext=system_u:system_r:initrc_t:s0
>> tcontext=system_u:object_r:dovecot_var_lib_t:s0 tclass=file
>>
>> Because formerly it was labeled as dovecot_var_run_t which was of
>> files_pid_file(dovecot_var_run_t)
>
> So this hardlink is recreated every time dovecot is started?  If  
> so, you
> should add in an interface for deleting this file, and then a rule for
> initrc_t.

Yes and No. This file is created by the master process of dovecot and  
after a specific time the file is altered again and again by the  
master process. I would suggest to add a dontaudit rule for initrc_t  
because only dovecot needs real manage perms. The file itself  
contains parameters for Diffie Hellman key exchange so initrc_t  
doesn't need to touch this file. Attached is a patch which solves this.

>
>> On 28.08.2007, at 14:26, Stefan Schulze Frielinghaus wrote:
>>
>>> dovecot uses a hard link:
>>>
>>> /var/lib/dovecot/ssl-parameters.dat
>>> /var/run/dovecot/login/ssl-parameters.dat
>>>
>>> and the policy file looks like that:
>>>
>>> /var/run/dovecot(-login)?(/.*)?	gen_context
>>> (system_u:object_r:dovecot_var_run_t,s0)
>>> /var/lib/dovecot(/.*)?			gen_context
>>> (system_u:object_r:dovecot_var_lib_t,s0)
>>>
>>> While relabel:
>>>
>>> $ fixfiles relabel
>>>
>>> ...
>>> matchpathcon_filespec_add:  conflicting specifications for /var/run/
>>> dovecot/login/ssl-parameters.dat and /var/lib/dovecot/ssl-
>>> parameters.dat, using system_u:object_r:dovecot_var_run_t:s0.
>>> ....
>>>
>>> Since the comment in the policy dovecot.te the file should be
>>> labeled dovecot_var_lib_t but fixfiles relabels it as
>>> dovecot_var_run_t. Attached is a patch which solves this.
>>>
>>> PS: tested on CentOS5
>>>
>>> <dovecot.fc.patch>
>>
> -- 
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>

--Apple-Mail-2-404181393
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=dovecot.if.patch
Content-Disposition: attachment;
	filename=dovecot.if.patch

--- /usr/src/refpolicy-20070629/policy/modules/services/dovecot.if	2006-12-12 21:08:08.000000000 +0100
+++ policy/modules/services/dovecot.if	2007-09-07 13:18:30.000000000 +0200
@@ -18,3 +18,21 @@
 	manage_files_pattern($1,dovecot_spool_t,dovecot_spool_t)
 	manage_lnk_files_pattern($1,dovecot_spool_t,dovecot_spool_t)
 ')
+
+########################################
+### <summary>
+###      Dontaudit attempts to unlink dovecot_var_lib_t files.
+### </summary>
+### <param name="domain">
+###      <summary>
+###      Domain to not audit.
+###      </summary>
+### </param>
+##
+interface(`dovecot_dontaudit_unlink_var_lib_files',`
+	gen_require(`
+		type dovecot_var_lib_t;
+	')
+
+	dontaudit $1 dovecot_var_lib_t:file unlink;
+')

--Apple-Mail-2-404181393
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=init.te.patch
Content-Disposition: attachment;
	filename=init.te.patch

--- /usr/src/refpolicy-20070629/policy/modules/system/init.te	2007-06-29 16:48:13.000000000 +0200
+++ policy/modules/system/init.te	2007-09-07 13:25:37.000000000 +0200
@@ -604,6 +604,14 @@
 ')
 
 optional_policy(`
+	# /var/run/dovecot/login/ssl-parameters.dat is a hard link to
+	# /var/lib/dovecot/ssl-parameters.dat and init tries to clean up
+	# the directory. But we do not want to allow this.
+	# The master process of dovecot will manage this file.
+	dovecot_dontaudit_unlink_var_lib_files(initrc_t)
+')
+
+optional_policy(`
 	ftp_read_config(initrc_t)
 ')
 

--Apple-Mail-2-404181393
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed



--Apple-Mail-2-404181393--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
