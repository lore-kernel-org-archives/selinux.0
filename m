Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t68HljIu031231
 for <selinux@tycho.nsa.gov>; Wed, 8 Jul 2015 13:47:45 -0400
Message-ID: <559D623D.405@schaufler-ca.com>
Date: Wed, 08 Jul 2015 10:47:41 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Shuah Khan <shuahkhan@gmail.com>, Ming Lei <ming.lei@canonical.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 SE Linux <selinux@tycho.nsa.gov>, william.c.roberts@intel.com
Subject: Re: Linux 4.2-rc1
References: <CA+55aFxmm7THBsCK62esr=JCcHpn6nmReGKqPp0inUrhbkveuA@mail.gmail.com>	<CAKocOOM0-uce9kUzprCW9M48_G2OTV-eWgPe4euht2qY8FdA3A@mail.gmail.com>	<CA+55aFy-iZ2g8xKZW---LgUHaVMbqLZ_oadw=Vbg0g78dfH9PA@mail.gmail.com>
 <CA+55aFyYFhkupwb0tVLCDWQs9H1DX0kXZZkCwax_xUOUMfDgxA@mail.gmail.com>
In-Reply-To: <CA+55aFyYFhkupwb0tVLCDWQs9H1DX0kXZZkCwax_xUOUMfDgxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Shuah Khan <shuahkh@osg.samsung.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/8/2015 10:29 AM, Linus Torvalds wrote:
> On Wed, Jul 8, 2015 at 10:17 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> Decoding the "Code:" line shows that this is the "->fw_id" dereference in
>>
>>         if (add_uevent_var(env, "FIRMWARE=%s", fw_priv->buf->fw_id))
>>                 return -ENOMEM;
>>
>> and that "fw_priv->buf" pointer is NULL.
>>
>> However, I don't see anything that looks like it should have changed
>> any of this since 4.1.
> Looking at the otehr uses of "fw_priv->buf", they all check that
> pointer for NULL. I see code like
>
>         fw_buf = fw_priv->buf;
>         if (!fw_buf)
>                 goto out;
>
> etc.
>
> Also, it looks like you need to hold the "fw_lock" to even look at
> that pointer, since the buffer can get reallocated etc.
>
> So that uevent code really looks buggy. It just doesn't look like a
> *new* bug to me. That code looks old, going back to 2012 and commit
> 1244691c73b2.

There have been SELinux changes to kernfs for 4.2. William,
you might want to have a look here.

>
> Ming Lei?
>
>                  Linus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
