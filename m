Message-ID: <4900138D.1010305@redhat.com>
Date: Thu, 23 Oct 2008 16:02:53 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>
Subject: Re: user guide drafts: "Mounting File Systems"
References: <48EF03BA.90901@redhat.com>	 <1223645441.25569.50.camel@moss-spartans.epoch.ncsc.mil>	 <48F69C5D.8050504@redhat.com>	 <1224166050.9247.48.camel@moss-spartans.epoch.ncsc.mil>	 <48FBCBC3.2070507@redhat.com>	 <1224509852.7428.43.camel@moss-spartans.epoch.ncsc.mil>	 <48FEB8D4.8040401@redhat.com> <1224688024.29917.42.camel@moss-spartans.epoch.ncsc.mil> <490006C4.9030006@redhat.com>
In-Reply-To: <490006C4.9030006@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Murray McAllister wrote:
> Stephen Smalley wrote:
>> On Wed, 2008-10-22 at 15:23 +1000, Murray McAllister wrote:

>>>
>>> mount localhost:/export /local/mount/point -o\
>>> context="system_u:object_r:httpd_sys_content_t:s0"
>>
>> The options really ought to go into their fstab or automounter maps so
>> that they are preserved on each mount.
> I've added text similar to the following for each section:
> 
> To make the [context] option persistent across mounts, add an entry for 
> the file system in /etc/fstab or an automounter map, and use the desired 
> context as a mount option.
> 
> I did not include examples since there are too many other options, 
> particularly for automounting NFS.
I'll include an fstab example to make it clear not to use "-o" in fstab.

Thanks for the feedback!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
