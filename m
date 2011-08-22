MIME-Version: 1.0
In-Reply-To: <1304436800.1587.20.camel@moss-pluto>
References: <4DC01640.9000206@redhat.com>
	<1304436800.1587.20.camel@moss-pluto>
Date: Mon, 22 Aug 2011 13:26:51 -0400
Message-ID: <CACLa4psD13cYBwzd0qQCa6Dh5JtAe3pdhbCSxROq85uXpyx9zw@mail.gmail.com>
Subject: Re: libselinux mountpoint changing patch.
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
        Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 3, 2011 at 11:33 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2011-05-03 at 10:50 -0400, Daniel J Walsh wrote:

>> NOTE:  We added the check for RO, to allow tools like mock to be able to
>> tell a chroot that SELinux is disabled while enforcing it outside the
>> chroot.
>>
>>
>> # getenforce
>> Enabled
>> # mount -t selinuxfs -o remount,ro selinuxfs /var/chroot/selinux
>
> Just to clarify, the right commands to use are:
> mount --bind /selinux /var/chroot/selinux
> mount -o remount,ro /var/chroot/selinux
>
> Do not use:
> mount -t selinuxfs -o ro selinuxfs /var/chroot/selinux
> as this will in fact change the flags on /selinux as well.  Surprise!
> Result of there only being a single instance (superblock) of selinuxfs,
> although you can have multiple vfsmounts of it.

surprise, this doesn't work either!
# cat mount.F16 | grep selinux
mount --bind /selinux /mnt/F16/sys/fs/selinux/
mount -o remount,ro /mnt/F16/sys/fs/selinux/

# cat /proc/mounts | grep selinux
selinuxfs /selinux selinuxfs ro,relatime 0 0
selinuxfs /mnt/F16/sys/fs/selinux selinuxfs ro,relatime 0 0

crap.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
