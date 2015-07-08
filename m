Message-ID: <559D63F9.2060109@schaufler-ca.com>
Date: Wed, 08 Jul 2015 10:55:05 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Shuah Khan <shuahkh@osg.samsung.com>, Shuah Khan <shuahkhan@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 4.2-rc1
References: <CA+55aFxmm7THBsCK62esr=JCcHpn6nmReGKqPp0inUrhbkveuA@mail.gmail.com>
 <CAKocOOM0-uce9kUzprCW9M48_G2OTV-eWgPe4euht2qY8FdA3A@mail.gmail.com>
 <559D5874.9040604@schaufler-ca.com> <559D5ED9.4040904@osg.samsung.com>
In-Reply-To: <559D5ED9.4040904@osg.samsung.com>
Content-Type: text/plain; charset=utf-8
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 SELinux <Selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/8/2015 10:33 AM, Shuah Khan wrote:
> On 07/08/2015 11:05 AM, Casey Schaufler wrote:
>> On 7/8/2015 9:32 AM, Shuah Khan wrote:
>>> On Sun, Jul 5, 2015 at 2:22 PM, Linus Torvalds
>>> <torvalds@linux-foundation.org> wrote:
>>>> It's Sunday, two weeks have passed, and the merge window is closed. I
>>>> just pushed out the tag to the git trees, and tar-balls and patches
>>>> should be mirroring out too.
>>>>
>>>> I thought this release would be one of the biggest ones ever, but it
>>>> turns out that it will depend on how you count. Just counting pure
>>>> commits, it is indeed one of the bigger rc1's in recent history, but
>>>> 3.10-rc1 was almost as big, and then the final 3.10 grew from that
>>>> more than most. I doubt we'll match the 3.10 release, since we have
>>>> been getting progressively better at *not* merging tons of stuff after
>>>> -rc1.
>>>>
>>>>
>>> I am seeing the following NULL pointer dereference on my test system:
>> Can I get your config file, please? I am particularly interested
>> in seeing your security settings.
>>
> Please see the attached config file.

SELinux is not configured, AppArmor is. It's possible that
the recent kernfs changes for SELinux affect this case, although
I couldn't say how from what I see.

>
> thanks,
> -- Shuah
>
>
