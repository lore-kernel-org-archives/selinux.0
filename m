Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8H11l1M013705
 for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2015 21:01:47 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andy Lutomirski <luto@amacapital.net>
Cc: Seth Forshee <seth.forshee@canonical.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Jeff Layton <jlayton@poochiereds.net>,
 "J. Bruce Fields" <bfields@fieldses.org>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 SELinux-NSA <selinux@tycho.nsa.gov>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-mtd@lists.infradead.org
References: <1442433764-80826-1-git-send-email-seth.forshee@canonical.com>
 <1442433764-80826-3-git-send-email-seth.forshee@canonical.com>
 <CALCETrXoAi91JN4VLD2ybPgkD_J26=2_N-fyCCjOPL5Swo7kGA@mail.gmail.com>
Date: Wed, 16 Sep 2015 19:54:26 -0500
In-Reply-To: <CALCETrXoAi91JN4VLD2ybPgkD_J26=2_N-fyCCjOPL5Swo7kGA@mail.gmail.com>
 (Andy Lutomirski's message of "Wed, 16 Sep 2015 17:24:47 -0700")
Message-ID: <87r3lxyif1.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v3 2/7] userns: Simpilify MNT_NODEV handling.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Andy Lutomirski <luto@amacapital.net> writes:

> On Wed, Sep 16, 2015 at 1:02 PM, Seth Forshee
> <seth.forshee@canonical.com> wrote:
>> From: "Eric W. Biederman" <ebiederm@xmission.com>
>>
>> - Consolidate the testing if a device node may be opened in a new
>>   function may_open_dev.
>>
>> - Move the check for allowing access to device nodes on filesystems
>>   not mounted in the initial user namespace from mount time to open
>>   time and include it in may_open_dev.
>>
>> This set of changes removes the implicit adding of MNT_NODEV which
>> simplifies the logic in fs/namespace.c and removes a potentially
>> problematic user visible difference in how normal and unprivileged
>> mount namespaces work.
>>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
>> -               /* Only in special cases allow devices from mounts
>> -                * created outside the initial user namespace.
>> -                */
>> -               if (!(type->fs_flags & FS_USERNS_DEV_MOUNT)) {
>> -                       flags |= MS_NODEV;
>> -                       mnt_flags |= MNT_NODEV | MNT_LOCK_NODEV;
>> -               }
>
> This is an ABI change.  It's probably okay, but I think the commit
> message should make it clear what's happening.

You mean it should include in big flashing neon letters
            ***REGRESSION FIX***
?

It is longer in coming than I had hoped.  But that is part of the reason
I did not fix the security hole this way.  Getting the s_user_ns stuff
just so has been non-trivial.

I do agree that because this is a user visible change we do need to keep
our eyes peeled for pieces of userspace software that may depend on the
exact details of the current behavior.

Eric
