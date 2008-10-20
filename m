Message-ID: <48FBD4D4.9070307@redhat.com>
Date: Mon, 20 Oct 2008 10:46:12 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Eric Paris <eparis@parisplace.org>, Daniel Walsh <dwalsh@redhat.com>
Subject: Re: user guide drafts: "Mounting File Systems"
References: <48EF03BA.90901@redhat.com>	 <1223645441.25569.50.camel@moss-spartans.epoch.ncsc.mil>	 <48F69C5D.8050504@redhat.com> <1224166050.9247.48.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1224166050.9247.48.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2008-10-16 at 11:43 +1000, Murray McAllister wrote:
>> Mounting File Systems

>>
>> The following example changes the default context to 
>> system_u:object_r:httpd_sys_content_t:s0:
>>
>> # mount -o defcontext="system_u:object_r:httpd_sys_content_t:s0" 
>> /dev/sda1 /mount/point
> 
> Again, I would tend to use an example that is more realistic, like a
> removable device or NFS filesystem.

defcontext and NFS doesn't work. I've never owned a large removable 
device (I asked around the office and the people here use vfat).

Maybe a blurb (as Eric suggested) is better for this, instead of an example.

Thanks.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
