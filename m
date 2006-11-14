Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAEKBXWE031537
	for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2006 15:11:33 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAEKAnWe017972
	for <selinux@tycho.nsa.gov>; Tue, 14 Nov 2006 20:10:50 GMT
Message-ID: <455A2304.5090709@redhat.com>
Date: Tue, 14 Nov 2006 15:11:48 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest Diffs
References: <453E2A8C.4070207@redhat.com> <1162328409.31675.131.camel@sgc.columbia.tresys.com>
In-Reply-To: <1162328409.31675.131.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://people.redhat.com/dwalsh/SELinux/policy-20061106.patch.gz

Christopher J. PeBenito wrote:
> On Tue, 2006-10-24 at 11:00 -0400, Daniel J Walsh wrote:
>   
>> flow_in flow_out changes for labeled networking.  Not sure if these are 
>> still needed.
>>     
>
> Dropped this since labeled networking is still up in the air.
>
>   
I need to leave it in since I have already released it and any loadable
modules that have been created require it.

>> Added use_lpd_server boolean to eliminate some not needed permissions 
>> from cups versions of lpr commands.
>>     
>
> I would rather split out the lpr portions out to a lpr module that would
> function like the mta module.  Then the rules that aren't common for lpd
> and cups can go into optionals.
>
>   
Ok, when that I happens I will switch.
>> Added a userdom_executable_file type so that we can change the ability 
>> to execute all commands in MLS, to only be allowed to execute commands 
>> that an admin would legitimately like to execute without transition.
>>     
>
> I don't like the implementation of this; the idea of a user executable
> doesn't make sense to me.  It may be better defining this concept in
> terms of executables an admin wouldn't execute.
>
>   
I am trying to differentiate between executing commands like tools that
run in a domain and outside a domain cvs, rsync, rpm  from always
confined domains.
The requirement for this comes from MLS policy, we want to have a
failure when sysadm tries to run a SELinux utility.

So he executes setsebool he gets a exec failure rather then a partial
success.
> In addition, the corecmd_exec_all_executables() change breaks the
> meaning of the interface.
>
>   
>> Redhat's Fedora Extras apd-get and apt-shell run as rpm.
>>     
>
> Can't add this because it causes conflicting file contexts if the dpkg
> module is included.
>
>   
I think we need a rewrite of the dpkg te file so on redhat platforms
dbkg_t is aliased to rpm_t.
> Dropped mcs_killall(rpm_script_t) and mcs_ptrace_all(rpm_script_t) since
> it does not have the requisite TE permissions.
>
>   
Since these are unconfined domains, they do have the allows.  This
prevents the mcs constraint from firing.
>> IBM requests javaws and bin under /opt/ibm/java2-ppc64-50/jre be labeled 
>> java_exec_t
>>     
>
> Dropped the other change; I'm trying to stay away from broad
> specifications since it makes more problems for sorting.
>
>   
>> mv dosfs_t to nfs_t needs to work.
>>     
>
> You have fs_associate_tmpfs(noxattrfs), which won't do it.  My guess is
> that you want something like fs_associate_noxattr(noxattrfs).
>
>   
Yes, changed in this update.
>> httpd needs to be able to rotatelogs
>>     
>
> The problem with this is that it would allow apache to delete its logs.
> I suggest trying rotatelogs labeled as logrotate_exec_t instead.
>
>   
apache can not delete logs, only httpd_rotatelogs_t can.  We could
combine the domains together but that would give /usr/sbin/rotatelogs
more power, currently it can only touch apache logs.
>> Major changes to crontab_t to transition to user_tmp_t.  Why do we have 
>> a user_crond_t, would just transitioning to user_t make more sense?
>>     
>
> I don't know the original intention, but my guess is to be a subset of
> the user domain.
>
>   
>> Fixed for oddjob_mkhomedir_t
>>     
>
> Why is domain_subj_id_change_exemption(oddjob_t) needed?
>
>   
oddjob runs jobs on behalf of helper apps,  It asks the kernel how to
run them.

If I restart oddjob by hand, it will be running as user_u:system_r:oddjob_t

When it asks the kernel what to run jobs on behalf of
system_u:system_r:ricci_t, it
gets back system_u:system_r:ricci_modcluster_t, which causes this access
violation.
>> squid wants to rw_tmpfs for diskd mode.
>>     
>
> I'm wondering if this is tmpfs_t because there is no squid_tmpfs_t+type
> transition, or if it is because the machine is targeted.
>   
Not sure, this was in the old policy as well.  Never used squid.
>   
>> getty needs sys_admin 
>>     
>
> I find this very questionable, and the bug you mentioned doesn't have
> any good information.
>
> Why does sasl need compute_av?
>
>   
I think because it is running through pam and this causes the compute_av
> What program(s) have a dyntrans from unconfined to unconfined_execmem?
>
>   
on ia32el you need to transition 32 bit apps from unconfined_t to
unconfined_execmem_t.


The kernel steps into do this so there is no transition.



============================================================
New changes.

amanda, krb5kdc, postfix_smtp, swat, telnetd, mount - All want to read
netlink_route

Broke allo_mount_anyfiles boolean into allow_mount_anydir and
allow_mount_anydir,  So you can mount at the dir level or a bind_mount

Added boolean to allow daemons to dump core in /.

xen wants to read/write raw disks.  Currenly we are allowing this via a
boolean.  Eventually we want to force users to label devices as
xen_image_t.  Didn't make it in to RHEL5.  :^(

logwatch wants to search sysfs

prelink wants to execute privs on exe's in homedir.

rpm wants to chat with hal

remove big ugly todo at the bottom or rpm.te - They all looked broken.

Broke reserved ports in to hi_reserved_port_t and reserved_port_t, this
gives us better security to allow bindresvport, but protect ports
1-511.  Current implementation was broken, in that callers to
bindresvport were failing on non-defined ports > 512.

Added netsupport, ocsp ports.

New devices
           /dev/hpet
           /dev/kmsg
           /dev/raw1394.* (Bad def)
           /dev/snapshot
           /dev/xvc*

Added aide policy

New apache cache dir
+/var/cache/mod_proxy(/.*)?
gen_context(system_u:object_r:httpd_cache_t,s0)

New rules for apache.

I think crontab policy is good, to go.

cron wants to look at login keys?  Might be a leak?

cupsd changes to allow it to run in MLS.

Fix policy for dbus running in chroot under bind.

Hal has a new directory /var/lib/hal


Lots of changes to kerberos to allow it to work with Public Key
Infrastructure.

Dontaudit mqueue_spool_t:dir - Talked about in other emails.

Oddjob wants to signal itself.

Procmail using nfs or samba shares

swat needs additional privs

snmp wants to look at homedir.  Needs dontaudit

In order to get rhgb and X to work together had to add
+    allow $1 xdm_xserver_t:process siginh;

xdm opens stdout/stderr to an xdmerrors file and then hands that to
subprocesses.  If the
subprocesses don't reopen stderr/stdout and eventually run a confined
domain, the domain will
generate avc messages

Some domains try to lock the wtmp file when they update it.

pam_console reads /var when it is mislabled.  This probably could be
surrounded by a hide_broken_apps boolean

We don't want mkswap running as fsadm_exec_t.  It has SELinux awareness
in it, so this causes problems.

A bunch of textrel_shlib_t changes

libraries.te has a useless hide_broken_symptoms

/var/lib/mutlipath directory needs context

We have had requests to allow /var/log to be mounted on.

Many fixes for clvmd and additional lvm_var_lib_t context

Lots of changes for lvm_t, mainly tested with new management platform
for Red Hat (ricci, and conga)

New locale directory under /usr/share/X11/locale

depmod needs to be able to delete kernel modules.

mdadm can create physical devices.

selinux utilities needs to be able to create default_context files

initscripts running setsebool need to transition.

newrole needs privs to run pam/login stuff.

realplayer context wrong

Additional unconfined_execmem_exec_t context


oddjob wants to chat with unconfined domain.

fixes for gen_require in userdomain interfaces.

secadm needs to read audit.log, and run aide

More xen changes.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
