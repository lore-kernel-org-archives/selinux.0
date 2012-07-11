Message-ID: <4FFDD7C7.4020703@tresys.com>
Date: Wed, 11 Jul 2012 15:45:11 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: <selinux@tycho.nsa.gov>
Subject: Re: seandroid and policy version
References: <4FFCC3C7.8080602@tresys.com> <1342011045.29461.28.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1342011045.29461.28.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2012-07-10 at 20:07 -0400, Joshua Brindle wrote:
>> I was looking at this:
>> <https://android-review.googlesource.com/#/c/36321/4/init/init.c>
>>
>> and remembered that years ago we had a discussion about the .policyver
>> filename syntax. I kind of get it for SELinux machines where there is
>> managed policy and could be multiple policies on the system but since
>> SEAndroid is targeting non-device managed policies, it adds extra code
>> to search for the right extension and you can tell what version the
>> policy is as soon as you open it, why not ditch the suffix?
>
> First, that patch doesn't introduce the use of the version suffix
> (that's in the already merged code); it just preserves it in the new
> logic for reloading policy at runtime.

I know, it just reminded me that I wanted to mention it :)

>
> I'm open to removing the use of the policy version suffix in a follow-on
> patch, although that would need to be coordinated across sepolicy and
> system/core.  But the current code is consistent with existing practice
> in Linux distributions (so follows principle of least surprise) and it

 From what I can tell most people doing anything with SEAndroid have never been 
exposed to SELinux so it probably is surprising to them that the file extension 
would change version to version.

> allows for different versions to be installed simultaneously (thereby
> supporting booting multiple kernels).  Also, we don't have libsepol on

I don't think this will ever be an issue on mobile devices (and I don't think it 
ever was an issue on real machines, more likely that stale policies were being 
enforced if there was some kernel or library change)

> the device so we cannot in fact determine the version when we open it
> there presently.  So I'm not convinced we should remove the suffix.

We don't need libsepol, just read the first few bytes, a la file.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
