Subject: Re: [PATCH] selinux: export validatetrans decisions
To: Andrew Perepechko <anserper@ya.ru>
References: <1445965643-30900-1-git-send-email-anserper@ya.ru>
 <562FBF50.2090700@tycho.nsa.gov> <3826370.MZ6nvm2ybe@panda-pc>
Cc: linux-security-module@vger.kernel.org, andrew.perepechko@seagate.com,
 selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <562FC685.503@tycho.nsa.gov>
Date: Tue, 27 Oct 2015 14:46:29 -0400
MIME-Version: 1.0
In-Reply-To: <3826370.MZ6nvm2ybe@panda-pc>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/27/2015 02:27 PM, Andrew Perepechko wrote:
>>> +	if (rc)
>>> +		goto out;
>>> +
>>> +	rc = -ENOMEM;
>>> +	if (count >= PAGE_SIZE - 1)
>>> +		goto out;
>>
>> Why PAGE_SIZE-1?
>>
>
> This is to avoid allocation of more than a single page.

Yes, but you don't need PAGE_SIZE - 1 for that.  The check can just be 
 >= PAGE_SIZE, as used elsewhere in selinuxfs.c.

> kzalloc(count+1) will guarantee the string is zero-terminated.
>
> The code below can be slightly optimized by modifying the
> copied string in-place, but I tried to follow the style
> used in neighbouring functions.
>
>>
>> #next has security_context_str_to_sid() as a convenient helper for this.
>>
>
> OK.
>
>>
>> Hmm...in what situation don't you want it to reflect the kernel
>> enforcing mode (i.e. when won't you just have your userspace file server
>> end up checking security_getenforce() and ignore the error in that
>> situation)?  Userspace AVC is different since it is caching decisions
>> from the kernel but still ends up honoring the kernel's enforcing status
>> (unless you explicitly set it to use its own private one).
>
> We expected to have an option to be able to enforce the policy even
> if the server itself is running in permissive, but this is not a critical
> requirement, so I'll update this bit.
>
>>
>> Beyond that, the things that you don't want to happen when called from
>> userspace include not unmapping the class value and not printk'ing on an
>> unrecognized class.  See security_transition_sid_user() ->
>> security_compute_sid() for example.
>>
>
> Sorry, you are right, indeed. :( This part somehow did not get in the final
> patch.
>
> I'll update the patch according to your comments.
