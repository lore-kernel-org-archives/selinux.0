To: Casey Schaufler <casey@schaufler-ca.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Kees Cook <keescook@chromium.org>
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
 <2a1ceb8c-0288-47ff-a763-d620e904b5b2@schaufler-ca.com>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f0059ebc-3586-dd08-efe5-f9ea69747218@i-love.sakura.ne.jp>
Date: Tue, 25 Sep 2018 02:22:28 +0900
MIME-Version: 1.0
In-Reply-To: <2a1ceb8c-0288-47ff-a763-d620e904b5b2@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 00/19] LSM: Module stacking for SARA and
 Landlock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 2018/09/25 1:15, Casey Schaufler wrote:
>>>>    Since all free hooks are called when one of init hooks failed, each
>>>>    free hook needs to check whether init hook was called. An example is
>>>>    inode_free_security() in security/selinux/hooks.c (but not addressed in
>>>>    this patch).
>>>
>>> I *think* that selinux_inode_free_security() is safe in this
>>> case because the blob will be zeroed, hence isec->list will
>>> be NULL.
>>
>> That's not safe - look more closely at what list_empty_careful() tests, and then think about what happens when list_del_init() gets called on that isec->list.  selinux_inode_free_security() presumes that selinux_inode_alloc_security() has been called already.  If you are breaking that assumption, you have to fix it.
> 
> Yup. I misread the macro my first time around. Easy fix.

Oh, I didn't notice that it is doing !list_empty_careful() than list_empty_careful().
Unsafe indeed. But easy to fix.

> 
>> Is there a reason you can't make inode_alloc_security() return void since you moved the allocation to the framework? 
> 
> No reason with any of the existing modules, But I could see someone
> doing unnatural things during allocation that might result in a
> failure.

Currently upstreamed LSM modules and AKARI would be OK. But I can't guarantee it
for future / not-yet-upstreamed LSM modules.
