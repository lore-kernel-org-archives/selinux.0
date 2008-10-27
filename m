Message-ID: <49052E33.9080106@redhat.com>
Date: Mon, 27 Oct 2008 12:57:55 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>
Subject: Re: user guide drafts: "Mounting File Systems"
References: <48EF03BA.90901@redhat.com>	 <1223645441.25569.50.camel@moss-spartans.epoch.ncsc.mil>	 <48F69C5D.8050504@redhat.com>	 <1224166050.9247.48.camel@moss-spartans.epoch.ncsc.mil>	 <48FBCBC3.2070507@redhat.com>	 <1224509852.7428.43.camel@moss-spartans.epoch.ncsc.mil>	 <48FEB8D4.8040401@redhat.com> <1224688024.29917.42.camel@moss-spartans.epoch.ncsc.mil> <48FF7E28.5030406@redhat.com>
In-Reply-To: <48FF7E28.5030406@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> Stephen Smalley wrote:
>> On Wed, 2008-10-22 at 15:23 +1000, Murray McAllister wrote:

>>>  Depending on policy configuration, services, such as Apache HTTP 
>>> Server and MySQL, may not be able to read files labeled with the nfs_t 
>>> type. This prevents an NFS file system being mounted and then read or 
>>> exported by another service.
>> Might be booleans that control this area as well; I don't know offhand.
>>
> /usr/sbin/getsebool -a shows the following booleans available to use
> nfs,   "use_nfs_home_dirs"  allows all domains that need access to
> homedirs, access to nfs_t.
Do other Booleans have to be turned on? I do not understand the output 
of sesearch -C, for example:

DT allow httpd_t nfs_t : file { ioctl read getattr lock } ; [ 
httpd_enable_homedirs use_nfs_home_dirs && ]

I guess this means both Booleans have to be turned on for the allow rule 
to work?

Stupid question: what do "DT" and "ET" stand for?

Thanks.
   (cifs_t samba filesystems) have similar
> booleans.
> allow_ftpd_use_nfs --> off
> httpd_use_nfs --> off
> qemu_use_nfs --> on
> samba_share_nfs --> off
> use_nfs_home_dirs --> on
> virt_use_nfs --> off
> xen_use_nfs --> off

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
