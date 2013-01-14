Message-ID: <50F4098B.2050802@tycho.nsa.gov>
Date: Mon, 14 Jan 2013 08:35:07 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: =?GB2312?B?tq3u2g==?= <dywisdomno1@gmail.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Subject: Re: Security label of file in Yaffs2 on Android
References: <CAPG=pduMTUpeY+Goikvh6nOAtcAvxn4h1Ai36H0ihwqfCHs9Eg@mail.gmail.com> <50F407C7.5020402@tycho.nsa.gov>
In-Reply-To: <50F407C7.5020402@tycho.nsa.gov>
Content-Type: text/plain; charset=GB2312
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/14/2013 08:27 AM, Stephen Smalley wrote:
> On 01/13/2013 11:15 PM, ¶­îÚ wrote:
>> Hello
>> I want to set security label(use xattr security.mylabel) of the file in
>> Yaffs2 on Android.
>> I've been able to use setxattr syscall to set security label, and use
>> getxattr syscall to verify the change right after that.
>> The problem is that the change is gone when i reboot the emulator.I used
>> to try the same process on linux and ext2 filesystem£¬and the change
>> will last like forever.
>>
>> Is is about the emulator? Or it is all about the support level of xattr
>> in Yaffs2£¿
>>
>> Thank you for any help.
> 
> What kernel are you using?  We had to patch the emulator kernel for SE
> Android, back-porting a more recent snapshot of the yaffs2 code that
> provides native support for xattrs and applying a further change to
> ensure that new inodes are assigned a SELinux attribute on creation.
> 
> Also, how are you invoking the emulator?

And which partition are you trying to modify?  /data or /system?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
