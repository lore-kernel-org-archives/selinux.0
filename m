Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6SGZfxe002758
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2008 12:35:41 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6SGZePO001278
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2008 16:35:41 GMT
Message-ID: <488DF550.9030903@redhat.com>
Date: Mon, 28 Jul 2008 12:35:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
CC: david@hardeman.nu, selinux@tycho.nsa.gov
Subject: Re: [refpolicy-patch 06/23] logrotate policy update
References: <20080719205002.462190042@hardeman.nu>	 <20080719210252.074422602@hardeman.nu> <1217258335.4959.13.camel@defiant.pebenito.net>
In-Reply-To: <1217258335.4959.13.camel@defiant.pebenito.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chris PeBenito wrote:
> On Sat, 2008-07-19 at 22:50 +0200, david@hardeman.nu wrote:
>> plain text document attachment (policy_modules_admin_logrotate.patch)
>> No controversial changes
> 
> I merged the uncontroversial changes.  The second one, however, is
> controversial in my opinion.
> 
>> diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/logrotate.te serefpolicy-3.5.0/policy/modules/admin/logrotate.te
>> --- nsaserefpolicy/policy/modules/admin/logrotate.te	2008-07-10 11:38:46.000000000 -0400
>> +++ serefpolicy-3.5.0/policy/modules/admin/logrotate.te	2008-07-15 14:05:12.000000000 -0400
>> @@ -71,6 +71,7 @@
>>  
>>  fs_search_auto_mountpoints(logrotate_t)
>>  fs_getattr_xattr_fs(logrotate_t)
>> +fs_list_inotifyfs(logrotate_t)
>>  
>>  mls_file_read_all_levels(logrotate_t)
>>  mls_file_write_all_levels(logrotate_t)
>> @@ -96,9 +97,11 @@
>>  files_read_etc_files(logrotate_t)
>>  files_read_etc_runtime_files(logrotate_t)
>>  files_read_all_pids(logrotate_t)
>> +files_search_all(logrotate_t)
Log rotate rotates files in arbitrary directories.  So the ability to
search all directories is required in order to not break on several
installations.
>>  # Write to /var/spool/slrnpull - should be moved into its own type.
>>  files_manage_generic_spool(logrotate_t)
>>  files_manage_generic_spool_dirs(logrotate_t)
>> +files_getattr_generic_locks(logrotate_t)
logrotate rotates log files and then signals random domains that it has
changed the log files.  Usually doing a service DOMAIN reload or service
DOMAIN restart.  This is what is probably causing the avc.
>>  
>>  # cjp: why is this needed?
>>  init_domtrans_script(logrotate_t)
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
