Subject: Re: How do you relabel all SELinux file contexts of an offline
 system's file system?
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <55C13DA1.2070601@jlbond.com>
 <20150805065406.GA17019@meriadoc.omgwtfbbq> <55CA9B0E.9050109@jlbond.com>
 <55CABF6D.70408@jlbond.com> <55CB0CD0.4010603@jlbond.com>
 <55CC9A6D.5040005@tycho.nsa.gov>
From: Bond Masuda <bond.masuda@jlbond.com>
Message-ID: <55D26DF5.3010203@jlbond.com>
Date: Mon, 17 Aug 2015 16:27:49 -0700
MIME-Version: 1.0
In-Reply-To: <55CC9A6D.5040005@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 08/13/2015 06:23 AM, Stephen Smalley wrote:
>>
>> Ok, figured this one out mostly, I think. Thanks to manpage
>> setfiles_selinux, I first had to set setfiles_mac_t to permissive with:
>>
>> semanage permissive -a setfiles_mac_t
> That suggests that setfiles_mac_t policy needs to be augmented with
> further allow rules; you can tell which ones based on ausearch -m AVC
> -se setfiles_mac_t
>
Ok. so on Fedora 21, (using
selinux-policy-targeted-3.13.1-105.20.fc21.noarch), it looks like I need
this:

# ausearch -m AVC -se setfiles_mac_t | audit2allow


#============= setfiles_mac_t ==============
allow setfiles_mac_t bin_t:file entrypoint;


>> Then, I ran the setfiles commands under runcon as:
>>
>> runcon -t setfiles_mac_t -- chroot /mnt /sbin/setfiles -v -F -e /proc -e
>> /sys -e /dev -e /selinux
>> /etc/selinux/targeted/contexts/files/file_contexts /
>>
>> This fixes the previous "invalid argument" errors from setfiles.
> I think those errors reflect a bug/gap in setfiles.  Usually setfiles
> validates and canonicalizes the contexts in file_contexts by writing
> them to /sys/fs/selinux/context (a pseudo file) and reading back the
> result.  This will fail if selinuxfs is mounted in your chroot and your
> host policy doesn't define the context.  If selinuxfs is not mounted in
> your chroot, then this will just create a regular file under
> /sys/fs/selinux/context containing the context and read it back again,
> so it will "pass".  I'm guessing that it was failing in enforcing mode
> because it wasn't allowed to create files under /sys/fs/selinux in the
> chroot.  I think we need a change to setfiles (e.g. a new option) to
> fully disable this validation/canonicalization.

That would seem useful in my use-case.
>
>> this process, there are still 2 labels that are wrong:
>>
>> [root@localhost ~]# restorecon -v -n -r /
>> restorecon reset / context system_u:runcon -t setfiles_mac_t -- getfattr -n security.selinux /mnt/rootobject_r:mnt_t:s0->system_u:object_r:root_t:s0
>> restorecon reset /.autofsck context system_u:object_r:mnt_t:s0->system_u:object_r:etc_runtime_t:s0
>>
>> I think the /.autofsck is getting created during boot, and maybe just
>> inheriting from /. So, the question is why is / (root) still labeled as
>> mnt_t instead of root_t ? When the system is still mounted under
>> /mnt/test, /mnt/test (where / of the system is mounted) is correctly
>> labeled as root_t, but this seems to change once unmounted and i boot
>> the offline system?
>>
>> Any insights?
> No, that seems very strange.  How did you check the context of /mnt/root
> before unmounting it?  Try checking it this way:
> runcon -t setfiles_mac_t -- getfattr -n security.selinux /mnt/root
>
> And likewise, once you unmount and reboot the offline system, try it as:
> runcon -t setfiles_mac_t -- getfattr -n security.selinux /
>
This turned out to be an error due to an external process. The labeling
of /mnt/root is in fact correct. We are building a system in /mnt/root,
and when we use the recovery boot option from the install DVD, it
appears to relabel / to mnt_t. We did this in order to setup grub in the
bootsector. We noticed this because when we automated the grub-install
w/o using the recovery DVD, / was labeled correctly as expected.

Thanks for your help!
-Bond
