Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB4KwogJ004818
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 15:58:50 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB4Kv45U017389
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 20:57:05 GMT
Message-ID: <45748C21.1060201@redhat.com>
Date: Mon, 04 Dec 2006 15:59:13 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest Diffs 11/29
References: <456E0470.3010500@redhat.com> <1165264006.4220.57.camel@sgc>
In-Reply-To: <1165264006.4220.57.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2006-11-29 at 17:06 -0500, Daniel J Walsh wrote:
>   
>> Why does loadkeys built this way.  Trying this interface blew up in 
>> targeted policy.
>>     
>
> I cannot reproduce this.
>
>   
The interface blew up when trying to be used in a modular policy.  
Basically I was experimenting with
getting unconfined_t to transition to user_mozilla_t
>> I think the hi_reserved_port_t change is good.
>>     
>
> Its close, I think we need to think about changing the "rpc ports"
> concept, since it doesn't seem limited to just rpc.
>
>   
>> Fixes for polyinstatiated needs rmdir
>>     
>
> Need more explanation for login programs adding and removing user home
> directories for polyinstantiation.
>
>   
>> Cups changes for MLS
>>     
>
> I don't agree with the cupsd file change, the binary itself isn't
> sensitive.  Reordered other changes.
>
>   
>> ypxfr has moved and needs policy fixes
>>     
>
> Kept the bin search perms for compat.
>
>   
>> Dont want to dontaudit searches of var_yp_t so setroubleshoot will work 
>> correctly.
>>     
>
>   
>> nmbd_t needs to be able to unlink log files
>>     
>
> Why?  This would be a bad thing, IMO.
>
>   
Agreed, but we break samba functionality.  Maybe a boolean?
>> Fixes for swat
>>     
>
> Changing the log access to write?  Also seems like a bad thing, though
> not quite as bad since its an admin tool.
>
>   
>> tftpd uses ypbind
>>     
>
> made this optional
>
>   
>> mkswap should not be fsadm_exec_t, it is SELinux aware.
>>     
>
> Why is mkswap aware?  Why would it not be fsadm_exec_t, it will still
> have to write to the fixed disk device.
>
>   
Needs a new policy if you want.  mkswap now labels file swapfile_t.  Not 
elegant but it works. 
>> I have removed some hide_broken_symptoms thinking they are all fixed, 
>> but do you  want these around for RHEL4?
>>     
>
> Yes.
>
>   
>> depmod deletes kernel modules
>>     
>
> Why?
>
>   
>> Added policy for system-config-selinux, basically a superset of 
>> semanage_t, currently unconfined, but need transition rules to maintain 
>> context in /etc/selinux/TYPE directories.
>>     
>
> Need explanation for changes to manage_default_contexts and
> manage_selinux_config.
>
> Why are init scripts running setsebool?
>
>   
ypbind start/stop turns on the boolean.  Probably ok for targeted not 
for other platforms.
> Dropping semanage_gui_t, as its not upstream.  Selinuxutil should only
> be checkpolicy and policycoreutils programs.
>
> I don't think newrole should use the login program interface.
>
> Why do you have setfiles exec'ing init scripts?
>
>   
>> Additional rules for to get load_policy to work with MLS
>>     
>
> Need more clarification on this one.
>
>   

>> Fix RealPlayer file specification, additional unconfined_execmem_exec_t 
>> domains.
>>     
>
> Just like with mplayer, we want vmware executables labeled in the vmware
> module.
>
>   
>> xen fixes, new images directory
>>     
>
> Why is this needed:
> +	allow $1 xdm_xserver_t:process siginh;
>
>   
Needed to get transition for rhgb to xserver to work.
> Can you elaborate as to why multipath (dm/lvm) needs net_admin?  A
> cursory look through the docs doesn't mention the network at all.
>
> Changed printk_device_t to kmsg_device_t.
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
