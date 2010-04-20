Message-ID: <4BCDCF98.9080608@redhat.com>
Date: Tue, 20 Apr 2010 12:00:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@parisplace.org>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Setting labels on a disabled SELinux box.
References: <4BCDB877.10908@redhat.com>	 <1271774732.30027.73.camel@moss-pluto.epoch.ncsc.mil>	 <4BCDC17B.3090104@redhat.com>	 <s2k7e0fb38c1004200805y61bd1fbcr23a8ff03b76257e@mail.gmail.com> <1271776363.30027.112.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1271776363.30027.112.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/20/2010 11:12 AM, Stephen Smalley wrote:
> On Tue, 2010-04-20 at 11:05 -0400, Eric Paris wrote:
>> It does look like you are right, we  might never hit the
>> cap_inode_setsecurity, but I'm trying to run down exactly how this is
>> happening....
>>
>> -Eric
>>
>> On Tue, Apr 20, 2010 at 11:00 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> On 04/20/2010 10:45 AM, Stephen Smalley wrote:
>>>> On Tue, 2010-04-20 at 10:21 -0400, Daniel J Walsh wrote:
>>>>> Currently the kernel is blocking the setting of labels on a disabled
>>>>> SELinux box.
>>>>>
>>>>> We have made changes to livecd to be able to build a livecd image on a
>>>>> disabled SELinux box, but the kernel is preventing the placing of labels.
>>>>>
>>>>> We want this functionality so that Fedora Build machines can be allowed
>>>>> to create different kinds of images and do not want to require all
>>>>> machines to enable SELinux.
>>>>>
>>>>> Currently these images are being built with SELinux disabled because of
>>>>> this.
>>>>>
>>>>> strace shows
>>>>>
>>>>> lsetxattr("/root/whatever/", "security.selinux",
>>>>> "system_u:object_r:root_t:s0", 28, 0) = -1 EOPNOTSUPP (Operation not
>>>>> supported)
>>>>>
>>>>>
>>>>> eparis says this code is causing the problem.
>>>>>
>>>>>  static int cap_inode_setsecurity(struct inode *inode, const char *name,
>>>>>                                   const void *value, size_t size, int flags)
>>>>>  {
>>>>>          return -EOPNOTSUPP;
>>>>>  }
>>>>>
>>>>> I think we should allow this if you have a capability like sys_admin or
>>>>> dac_override.
>>>>
>>>> Perhaps I don't understand, but inode_setsecurity() is only called if
>>>> the filesystem does not support xattrs; otherwise it gets handled via
>>>> the filesytem's ->setxattr handler, and that should work regardless of
>>>> SELinux-disabled (and always has in the past).
>>>>
>>>> I think we need more details, like kernel version, filesystem type, etc.
>>>>
>>>
>>> 2.6.32.11-99.fc12.x86_64; ext4
> 
> Oh, this is the dracut bug that isn't really disabling SELinux (just
> leaving it permissive with no policy loaded).  Ala FC2 days.  Didn't
> that get fixed?
> 
> grep selinuxfs /proc/filesystems
> 
I believe it is fixed in F13.  Not in F12.

Looks like Harald is just about to push F13 dracut into F12.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvNz5gACgkQrlYvE4MpobOosgCcCFUmcMJzNGs7zDlvmmytLf6b
5o0AoOEGAxjtVb/9AVJ5AAlxFcpxaZNF
=uFWS
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
