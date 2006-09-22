Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MKUbMQ000827
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 16:30:37 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8MKU63K025008
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 20:30:07 GMT
Message-ID: <451447EA.70905@redhat.com>
Date: Fri, 22 Sep 2006 16:30:34 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs
References: <45116881.3060406@redhat.com> <1158945196.3920.131.camel@sgc.columbia.tresys.com>
In-Reply-To: <1158945196.3920.131.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2006-09-20 at 12:12 -0400, Daniel J Walsh wrote:
>   
>> http://people.redhat.com/dwalsh/SELinux/policy.diff
>>
>> Changed to allow 1024 categories.
>>     
>
> Not adding this yet.  Waiting for concensus on how high we should go.
>
>   
Ok, any way we could make this a constant defined in the Makefile?

TOTAL_CATS=1024, MAX_CAT=c1023

>> I have a request for a boolean to allow all domains to talk to the ttys in targeted policy.  This would allow a domain to 
>> output errors if their is a failure.  Currenly if I screw up my httpd.conf file apache has no easy way of telling me, via 
>> the init script.
>>     
>
> This sounds like it should be for daemons rather than all domains.
>
>   
Changed to use daemon
>> Don't transition on grubby.  Some one needs to write grubby policy, but it should not be the same as bootloader
>>     
>
> Dropping the types for now, until someone writes the policy.
>
>   
Changed spec to be only /sbin/grub, eliminate /sbin/grub-install
>> +	#https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=202410
>> +	allow bootloader_t boot_runtime_t:file { rw_file_perms unlink };
>>     
>
>   
Removed
> This bug information is lacking.  Since it doesn't make sense for grub
> itself to write its own stage files, I did some deeper looking.  My
> guess is that grub-install is being run, and that it is inappropriately
> being labeled as bootloader_exec_t.  I'm not very familiar with grubby,
> but I suspect that grub-install should also be bootloader_helper_t.
>
>   
>> Add a files_manage_non_secure_dirs for autofs
>>     
>
> This seems suspect.
>
>   
Autofs creates a file/directory in every directory it mounts over.
>> nfs now uses rpc_pipefs_t:fifo_file
>>     
>
> Moved this interface up in filesystem.  Moved the call into the rpc
> template.
>   
Good
>   
>> Stop using bluetooth_helper_t
>>     
>
> Why?
>
>   
Two many bugs and it is confining userspace with X-Windows.
>> dhcpd speaks dbus
>>     
>
> Moved this hunk up.
>
>   
>> oddjob policy should be added
>>     
>
> Why are there two modules?  It seems like they should be merged.
>
>   
Ok
>> sendmail should create pid with correct context in targeted policy
>>     
>
> Moved this block up.
>
>
>   
>> xen has a new log directory
>>
>> xen needs ptrace
>>
>> xen needs to read from removable devices
>>     
>
>
> * There is a removal in corenetwork.te.m4 that you reversed.
>
>   
Sorry looks ok now
> * What is the /opt/fortitude stuff in apache?
>
>   
It is a new Red Hat product for government use, I believe. 
> * xserver_create_ice_tmp_sockets() does not have any callers.
>
> * I don't agree with the selinuxutil change to allow strict semanage_t
> to read user files.  This is an insecure source for policy packages.
>   
semanage has to be able to read sysadm_home_t and sysadm_tmp_t for 
strict policy and
for MLS you would need secadm_tmp_t,   The question is where would the 
admin likely put his
loadable policy modules.
> * The unconfined.te change confuses me; unconfined should already have
> these perms.
>
>   
Removed
> * I fixed up a change in amanda.fc, since it had a m4 internal function
> call (index(/.*)), which made the match not what you thought it was.
>
> On a side note, I looked at the bug noted in the fstools change, and the
> user pasted this bit:
>
> *** An error occurred during the file system check.
> *** Dropping you to a shell; the system will reboot
> *** when you leave the shell.
> *** Warning -- SELinux is active
> *** Disabling security enforcement for system recovery.
> *** Run 'setenforce 1' to reenable.
> Give root password for maintenance
> (or type Control-D to continue): 
>
> SELinux being in enforcing shouldn't be a warning, if anything it should
> be a notice.  "Warning" has a negative spin (at least it does to me).
>
>   
The warning is that SELinux is being disabled.  So maybe the warning 
should drop down one line.



Additional Changes in this updated patch

http://people.redhat.com/dwalsh/SELinux/policy.diff

Added staff_u to

readahead needs mls_read_up priv, donaudit looking at nvram

http has a new port 8443 for use with mod_nss

fsdaemon_exec_t needs to run at SystemHigh to be able to look at fixed disks


/dev/rawctl is labeled as a fixed_disk_device_t even though it is a 
chr_file.  Not sure if this is correct.


automount uses rawip_socket  

ndc has to read named_conf_t lnk_file in chroot environment

hal needs to touch unallocated ttys in order to see if anydevice is on 
the serial port, I don't think this is just a targeted policy issue. 

nscd needs to be accessable from sysadm_r.

nscd needs to read etc_runtime_t, for files created in firstboot

These are the same files (Hard Links)
 /usr/lib/postfix/smtp  --      
gen_context(system_u:object_r:postfix_smtp_exec_t,s0)
+/usr/lib/postfix/lmtp  --      
gen_context(system_u:object_r:postfix_smtp_exec_t,s0)

make smartmon work on mls machines

sshd needs to deal with kernel keyring

udev generates avc when it pidof all processes

need a userdom_use_unpriv_users_ttys so sysadm_t can write to all users 
terminals when system is going down.

auditadm and secadm need to be able to messages to syslog

secadm terminals are not admin_terminals.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
