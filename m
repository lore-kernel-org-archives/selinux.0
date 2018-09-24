Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8OGFG33030750
 for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2018 12:15:17 -0400
To: Stephen Smalley <sds@tycho.nsa.gov>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Kees Cook <keescook@chromium.org>
Cc: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>,
 LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=
 <mic@digikod.net>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
 <680e6e16-0890-8304-0e8e-6c58966813b5@schaufler-ca.com>
 <CAGXu5j+7FpFDNuOowdHzJ5RXgfETQMv=Fe-EU1gWo+nWK+goZA@mail.gmail.com>
 <39457e79-3816-824b-6b4d-89d21b03f9ce@i-love.sakura.ne.jp>
 <b209d4b8-81a5-30aa-f4d1-9372bbb1b842@schaufler-ca.com>
 <a2858469-cf38-7706-52b5-1d5fd5ed43ad@tycho.nsa.gov>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <2a1ceb8c-0288-47ff-a763-d620e904b5b2@schaufler-ca.com>
Date: Mon, 24 Sep 2018 09:15:06 -0700
MIME-Version: 1.0
In-Reply-To: <a2858469-cf38-7706-52b5-1d5fd5ed43ad@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 00/19] LSM: Module stacking for SARA and
 Landlock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 9/24/2018 8:01 AM, Stephen Smalley wrote:
> On 09/23/2018 01:09 PM, Casey Schaufler wrote:
>> On 9/23/2018 8:59 AM, Tetsuo Handa wrote:
>>> On 2018/09/23 11:43, Kees Cook wrote:
>>>>>> I'm excited about getting this landed!
>>>>> Soon. Real soon. I hope. I would very much like for
>>>>> someone from the SELinux camp to chime in, especially on
>>>>> the selinux_is_enabled() removal.
>>>> Agreed.
>>>>
>>> This patchset from Casey lands before the patchset from Kees, doesn't it?
>>
>> That is up for negotiation. We may end up combining them.
>>
>>> OK, a few comments (if I didn't overlook something).
>>>
>>>    lsm_early_cred()/lsm_early_task() are called from only __init functions.
>>
>> True.
>>
>>>    lsm_cred_alloc()/lsm_file_alloc() are called from only security/security.c .
>>
>> Also true.
>>
>>>    lsm_early_inode() should be avoided because it is not appropriate to
>>>    call panic() when lsm_early_inode() is called after __init phase.
>>
>> You're correct. In fact, lsm_early_inode() isn't needed at all
>> until multiple inode using modules are supported.
>>
>>>    Since all free hooks are called when one of init hooks failed, each
>>>    free hook needs to check whether init hook was called. An example is
>>>    inode_free_security() in security/selinux/hooks.c (but not addressed in
>>>    this patch).
>>
>> I *think* that selinux_inode_free_security() is safe in this
>> case because the blob will be zeroed, hence isec->list will
>> be NULL.
>
> That's not safe - look more closely at what list_empty_careful() tests, and then think about what happens when list_del_init() gets called on that isec->list.  selinux_inode_free_security() presumes that selinux_inode_alloc_security() has been called already.  If you are breaking that assumption, you have to fix it.

Yup. I misread the macro my first time around. Easy fix.

> Is there a reason you can't make inode_alloc_security() return void since you moved the allocation to the framework? 

No reason with any of the existing modules, But I could see someone
doing unnatural things during allocation that might result in a
failure.

> Unfortunate that inode_init_security name is already in use for another purpose since essentially you have reduced these hooks to initialization only.

I considered that but decided that it makes more sense for the module hook names
to match the infrastructure name. Having security_inode_alloc() call
selinux_inode_setup_security() starts to get confusing.
