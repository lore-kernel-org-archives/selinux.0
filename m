Subject: Re: How do you relabel all SELinux file contexts of an offline
 system's file system?
To: Bond Masuda <bond.masuda@jlbond.com>, selinux@tycho.nsa.gov
References: <55C13DA1.2070601@jlbond.com>
 <20150805065406.GA17019@meriadoc.omgwtfbbq> <55CA9B0E.9050109@jlbond.com>
 <55CABF6D.70408@jlbond.com> <55CB0CD0.4010603@jlbond.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55CC9A6D.5040005@tycho.nsa.gov>
Date: Thu, 13 Aug 2015 09:23:57 -0400
MIME-Version: 1.0
In-Reply-To: <55CB0CD0.4010603@jlbond.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/12/2015 05:07 AM, Bond Masuda wrote:
> 
> On 08/11/2015 08:37 PM, Bond Masuda wrote:
>> So, further troubleshooting this myself, I found these errors from
>> 'setfiles':
>>
>> /sbin/setfiles reset /usr/sbin/tzdata-update context
>> system_u:object_r:bin_t:s0->system_u:object_r:tzdata_exec_t:s0
>> /sbin/setfiles set context
>> /usr/sbin/tzdata-update->system_u:object_r:tzdata_exec_t:s0
>> failed:'Invalid argument'
>> /sbin/setfiles reset /sbin/pam_timestamp_check context
>> system_u:object_r:pam_timestamp_exec_t:s0->system_u:object_r:pam_exec_t:s0
>> /sbin/setfiles reset /sbin/shutdown context
>> system_u:object_r:bin_t:s0->system_u:object_r:shutdown_exec_t:s0
>> /sbin/setfiles set context
>> /sbin/shutdown->system_u:object_r:shutdown_exec_t:s0 failed:'Invalid
>> argument'
>> /sbin/setfiles reset /sbin/consoletype context
>> system_u:object_r:bin_t:s0->system_u:object_r:consoletype_exec_t:s0
>> /sbin/setfiles set context
>> /sbin/consoletype->system_u:object_r:consoletype_exec_t:s0
>> failed:'Invalid argument'
>>
>> I'm guessing this is because the "host" system doesn't have these types
>> in it's own policy? The "host" is a Fedora 21 system, while the system
>> mounted in /mnt/test is a CentOS6 system.
>>
>> Grepping the "types" above that give "invalid argument" on the host's
>> file_context* files indeed comes up empty.
>>
>> So, I'm guessing this is where I need to use runcon -t setfiles_mac_t to
>> run setfiles so it doesn't require the type to be one that is loaded in
>> the host's SELinux policy?
>>
>> How do I use runcon? I tried:
>>
> 
> Ok, figured this one out mostly, I think. Thanks to manpage
> setfiles_selinux, I first had to set setfiles_mac_t to permissive with:
> 
> semanage permissive -a setfiles_mac_t

That suggests that setfiles_mac_t policy needs to be augmented with
further allow rules; you can tell which ones based on ausearch -m AVC
-se setfiles_mac_t


> Then, I ran the setfiles commands under runcon as:
> 
> runcon -t setfiles_mac_t -- chroot /mnt /sbin/setfiles -v -F -e /proc -e
> /sys -e /dev -e /selinux
> /etc/selinux/targeted/contexts/files/file_contexts /
> 
> This fixes the previous "invalid argument" errors from setfiles.

I think those errors reflect a bug/gap in setfiles.  Usually setfiles
validates and canonicalizes the contexts in file_contexts by writing
them to /sys/fs/selinux/context (a pseudo file) and reading back the
result.  This will fail if selinuxfs is mounted in your chroot and your
host policy doesn't define the context.  If selinuxfs is not mounted in
your chroot, then this will just create a regular file under
/sys/fs/selinux/context containing the context and read it back again,
so it will "pass".  I'm guessing that it was failing in enforcing mode
because it wasn't allowed to create files under /sys/fs/selinux in the
chroot.  I think we need a change to setfiles (e.g. a new option) to
fully disable this validation/canonicalization.

 With
> this process, there are still 2 labels that are wrong:
> 
> [root@localhost ~]# restorecon -v -n -r /
> restorecon reset / context system_u:runcon -t setfiles_mac_t -- getfattr -n security.selinux /mnt/rootobject_r:mnt_t:s0->system_u:object_r:root_t:s0
> restorecon reset /.autofsck context system_u:object_r:mnt_t:s0->system_u:object_r:etc_runtime_t:s0
> 
> I think the /.autofsck is getting created during boot, and maybe just
> inheriting from /. So, the question is why is / (root) still labeled as
> mnt_t instead of root_t ? When the system is still mounted under
> /mnt/test, /mnt/test (where / of the system is mounted) is correctly
> labeled as root_t, but this seems to change once unmounted and i boot
> the offline system?
> 
> Any insights?

No, that seems very strange.  How did you check the context of /mnt/root
before unmounting it?  Try checking it this way:
runcon -t setfiles_mac_t -- getfattr -n security.selinux /mnt/root

And likewise, once you unmount and reboot the offline system, try it as:
runcon -t setfiles_mac_t -- getfattr -n security.selinux /
