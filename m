Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KFvsA0030901
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 10:57:54 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KFx8ox008577
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 15:59:09 GMT
Message-ID: <45DB1A99.3070104@redhat.com>
Date: Tue, 20 Feb 2007 10:58:17 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs - Resent with additional changes.
References: <45B8ACBF.8090201@redhat.com> <1171663101.20576.147.camel@sgc.columbia.tresys.com>
In-Reply-To: <1171663101.20576.147.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> (Karl, see the 3rd part: userdom_executable_file)
>
> On Thu, 2007-01-25 at 08:12 -0500, Daniel J Walsh wrote: 
>   
>> allow_unconfined_execmem_dyntrans is only used on ia64 platforms to run
>> 32 bit applications.  kernel does some funny stuff and rexecs
>> unconfined_t programs but needs execmem and execstack.  Otherwise ia64
>> has to run all apps with execmem execstack.
>>     
>
> Almost makes me want to make an arch_ia64 tunable.  Aside from the usual
> non-tranquil processes arguments, I'm not sure if this has to be
> tunable, since its just going from unconfined to unconfined_execmem,
> which are pretty much the same domain.
>
>   
>> The MLS constraints are really screwed up.  Need to come to some kind of
>> agreement between you, klaus and tcs.
>>     
>
> I'm not familiar with the LSPP requirements, so its mainly up to Klaus
> and the TCS guys to iron out what makes sense.
>
>   
>> userdom_executable_file is still in there.  I believe we need to separate
>> out the executables that are expected to be run by a user and those
>> expected to be run by the system.  This helps prevent accidently running
>> of applications under sysadm_t.
>>     
>
> I have seen where you were going with this, but I think the ssh agent
> unix socket and xserver's xsession-errors.log inheritance (i.e. leak fd
> by design) are more evidence that the answer is a little more
> comprehensive, like an application domain interface, so we can collect
> up the domain and the entry point into attributes.  I don't think this
> should go into userdomain since it doesn't have to do with the
> definition of user roles.  I also don't think it belongs in the domain
> module, since thats a more primitive concept, it should be in a system
> layer module (just like init's init_daemon_domain()), so this probably
> should get its own system layer module.  The domain_interactive_fd()
> stuff should probably be included in this too.  Karl, do you have any
> thoughts on this?
>   
This sounds good to me, but we need to specify these some how, 
especially if we start adding additional User Domains.
>   
>> mkinitrd should not be confined and should not be labeled
>> bootloader_exec_t.  This just causes too many problems and little
>> benifit.
>>     
>
> We'll also have to start analyzing the policy to see what can be removed
> because of this.  I suspect that most of the distro_* and optionals can
> be removed.
>
>   
>> I do not want consoletype and hostname transitioning to their domains
>> unless they need the privs,  Having them transition from an init script
>> is broken, because you end up with tons of denials when applications
>> redirect stdin/stdout
>>     
>
> Not transitioning consoletype might work, assuming use in init scripts
> don't need the privs, and then sys_admin would probably need to be
> dontaudited in initrc_t.  However, I can't see how hostname not
> transitioning from initrc can work, since setting the hostname certainly
> requires sys_admin, and we don't want to give sys_admin to initrc_t.  I
> also noticed that initrc_t has sys_admin for distro_redhat because of
> kmodule.  I don't know if thats still needed, but you won't see if stuff
> breaks if consoletype and hostname don't transition because of this.
>
>   
Ok I will remove this from Rawhide and see what breaks. 
>> Certain tools have rpm libraries built into them and these end up
>> calling the transition rules and getting denials.  I want to allow
>> unconfined_t to transition to rpm_script_t
>>     
>
>   
Multiple people are putting out apps like pup, up2date and other daemons 
that basically use the rpm database.  We need to keep labeling these 
rpm_exec_t to get them to work, or just allow the unconfined domain to 
transition to rpm_script_t to make rpm_exec work correctly.
> This sounds weird to me, what would be an example of a tool that has
> this problem?  Also if these are redhat tools then this should be in a
> distro_redhat.
>
>   
>> rpm execs prelink and chats with hal, also needs to kill processes
>> running at different sensitivity levels
>>     
>
> a rebasing problem, its there already.
>
>   
ok
>> Added a tzdata domain to allow proper context of /etc/localtime
>>     
>
> moved to admin layer
>
>   
ok
>> usermanage was changed to allow useradd to automatically label the
>> homedirs correctly.  useradd now has a -s qualifier that allows it to
>> select the selinux user.  It also then labels the directory correctly.
>> Critical for MLS and Strict policy to work.
>>     
>
>   
useradd, usermod now have semanage capability built into them,  So when 
I add a user I can specify a default SELinux user

useradd -Z staff_u dwalsh

This causes semanage to be executed to add the mapping.  It then calls 
genhomedircon and relabels the homedir correctly.

The problem is the useradd owns the terminal file descriptor which 
generates avc messages.
We really would want them to dontaudit the fd, so I guess an interface 
to useradd to ignore its fds would be better.
> I don't understand this part of the change:
>
> +# Required because semanage execs these and hands them useradd_t:fd
> +seutil_domtrans_setfiles(useradd_t)
> +seutil_domtrans_loadpolicy(useradd_t)
>
> also, why was apache_manage_all_content(useradd_t) added?
>
>   
useradd will create ~/public_html and any contents in it from the skel,  
It needs to be able to create and label these files.  As we expand 
userroles, we might need the capabilitity to identify contents in a home 
directory by attribute and allow useradd and friends to create/relabel them.
>> evolution still needs work.  (I mainly use thunderbird...)
>>     
>
> I'm merging these, but I think in the long run all the domains in
> evolution probably need to be merged; there really isn't anything gained
> by having all the separate domains.
>
> There was also a weird ifdef soffice at the bottom of thunderbird.if.
>
>   
Yes I will remove that.  I agree, thunderbird should be consolodated.  
As we move to userroles, I think we will need to reexamine all of these 
GUI/Application interfaces.
>> Not sure why you want if targeted_policy in loadkeys_run?
>>     
>
> Well if we want it to act the same in strict and targeted, the ifdefs
> need to be removed in both files, but that wasn't happening.
>
>   
Yes I will be sending up the next patch with lots of ifdef strict_policy 
removed.  Since we want to start introducing some confined user types to 
targeted policy.
>> Still want break out of hi_reserved_port_t from reserved_port_t.
>>     
>
> I don't have a problem with breaking them up, but the current
> implementation needs some work.  The current interfaces that give access
> to reserved_port_t shouldn't also give access to hi_reserved_port_t.
>
>   
Ok I think we should change
corenet_udp_bind_reserved_port and
corenet_tcp_bind_reserved_port to use hi_reserved_port_t

>> Several domains want to run telinit.  Added init_exec.
>>     
>
> Probably should use init_telinit() and add exec for init_exec_t to the
> interface.
>
>   
Ok I will change in next update.
>> Remove anacron_exec_t.   Just run in crond_t.
>>     
>
> What is the motivation for this?  Looks like there are other changes in
> here that are MLS-only; should be in an ifdef enable_mls.
>
>   
I am removing this change.  The end goal should be to make anacron 
selinux aware to work like cron.
>> cups changes to run in MLS
>>     
>
> moved the first change down.  the second change is already in, at the
> top of the file.
>   
Ok
mls_trusted_object(cupsd_var_run_t) is also in there twice.


>   
>> fixes to allow inetd to run on mls
>>     
>
> rearranged this, so be careful when you update
>
>   
>> sendmail wants to read clamav_libs
>>     
>
> Weird.  moved up.
>
>   
I think we might want to somehow add an attibute to file types that 
sendmail can read. 

sendmail < /var/run/log  commands are probably causing this type of access.
>> fixes for authlogin handling of keyrings and mls, as well as pcscd
>>     
>
> Can you elaborate some more on what you're trying to do with the keyring
> parts.
>   
I am just flailing around with this stuff,  I guess I am trying to 
identify domains that will own keyrings.  And then pass around open 
descriptors to them.   I really do not understand how this stuff is 
supposed to work.
>   
>> mkswap should not run as fsadm.  Should be labeled sbin_t.
>>     
>
> Without it being fsadm_t, you can't run it on disk partitions.
>
>   
mkswap has smarts built into it to label file swap_file_t at least at 
Red Hat.  Right now we only execute this from a unconfined domain, so 
this is not a problem.
>> fixes for iptbales to use nscd
>>     
>
> moved this block down
>
>   
>> local_login needs additional privs
>>     
>
> Can you elaborate on these; they all seem odd.
>
>   
I am not sure why they are generated,  I would guess this is generated 
by some pam module that requires appletalk communications.
>> lvm needs privs for multipath
>>     
>
> Can you elaborate as to why multipath (dm/lvm) needs net_admin?  A
> cursory look through the docs doesn't mention the network at all.
>
>   
Perhaps raid/iscsi?  Just guessing.  Don't have access to the Bugzilla 
that reported it.
>> initrc replace localization files using cp -A to preserve context.  This
>> causes many avc messages.
>>     
>
> Moved this to distro_redhat.
>
>   
ok
>> modutils fixes for strict policy
>>     
>
> Why would depmod delete kernel modules?  Seems more like a mislabeled file.
>
>   
Perhaps creating a tmp file in that directory?
>> Need correct labels for genhomedircon and system-config-selinux to
>> create context correctly.
>>     
>
> Why would genhomedircon be ran directly instead of semodule or semanage?
>
>   
It is a binary on disk that can be run, and people do.  You could add 
new users via NIS/LDAP others and then want to fix the labeling on the 
homedirs.
>> Lots of fixes for polyinstatiation on MLS
>>     
>
> Why is corecmd_exec_bin() needed?
>
>   
/etc/security/namespace.init
> ----
>
> What is /dev/twe[^/]* and why is it labeled as a fixed disk (esp. since
> its a character node)?
>
>   
Using google I found some references.  This might shed some light.
http://sourceforge.net/project/shownotes.php?release_id=267829&group_id=64297
> The term_unconfined() seems superfluous.
>
>   
Certain privs are not available for terminals, from unconfined domain.  
> This seems excessive:
>
> +# allow setkey to read a config files in any directory.
> +userdom_read_sysadm_home_content_files(setkey_t)
> +userdom_read_all_users_home_content_files(setkey_t)
>
>   
I guess we could label it differently, but this is a case similar to 
semodule where a user might create a file that they need to process with 
a confined domain. The problem is the confined domain is not allowed to 
read it and this confuses the user. 
> There is an addition which allows ricci_moservice_t to create an init
> script, and it can already transition to initrc_t with init scripts
> entrypoints.  Does it really need this?
>
>   
ricci_modservice executes chkconfig under the covers and starts and 
stops services.  So this is kind of what it is designed to do.  
Basically you use the tool to turn on service scripts at different 
runlevels and then start them.
> Why?
> +allow nmbd_t samba_log_t:file unlink;
>
>   
I am not sure.  Lots of bugzillas in FC6.
> I noticed several ptrace additions.  Is there something new that is
> causing these domains to trace themselves?
>
>   
killall and pidof now request ptrace when they run.  So any confined 
domain that execs these ends up requesting ptrace.  I think we can 
dontaudit them.  I believe Steve Smalley is looking into how we can 
remove this priv being required from just looking at the process table.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
