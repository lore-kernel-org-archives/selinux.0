MIME-Version: 1.0
In-Reply-To: <CAGXu5jJ6Ngv8A=3TV5z5+x5kCkkXwjYtDfSQjUQgscP4hv_xYg@mail.gmail.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
 <CAMp4zn94SzqK_Q=de2E+Fpv5yeAhYv62XW-KU3=ghRma9d7Jvw@mail.gmail.com>
 <a287800e-bd4d-2b99-8c4c-bd61ba87fab1@schaufler-ca.com>
 <kubjHWMWfFDu8Rk19x79iMDKVbewTUMWwSjOA7vFGIbYsWYcGb50jb-Z-PSXxmcby3ZFMZWi0HCeuFgo3F8BRskxo_JUdSHFhdIsIlBxHyQ=@protonmail.ch>
 <8e2bdc10-3142-9e8d-ff05-70fa4d862dd5@schaufler-ca.com>
 <CAGXu5jJ6Ngv8A=3TV5z5+x5kCkkXwjYtDfSQjUQgscP4hv_xYg@mail.gmail.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Thu, 16 Aug 2018 18:05:46 +0200
Message-ID: <CAJHCu1+Je_eTdvmobUU3ZqeeWDqH5v8gGUTqEF0XWVP4TyxbFg@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
 Jordan Glover <Golden_Miller83@protonmail.ch>,
 Sargun Dhillon <sargun@sargun.me>,
 LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>,
 "Schaufler, Casey" <casey.schaufler@intel.com>,
 =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v1 00/22] LSM: Full security module stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2018-08-15 7:19 GMT+02:00 Kees Cook <keescook@chromium.org>:
> On Tue, Aug 14, 2018 at 4:50 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 8/14/2018 4:22 PM, Jordan Glover wrote:
>>> On August 14, 2018 8:28 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>
>>>>
>>>>>> The blob management part (through "LSM: Sharing of security blobs")
>>>>>> is ready for prime-time. These changes move the management of
>>>>>> security blobs out of the security modules and into the security
>>>>>> module infrastructure. With this change the proposed S.A.R.A,
>>>>>> LandLock and PTAGS security modules could co-exist with any of
>>>>>> the existing "major" security modules. The changes reduce some
>>>>>> code duplication.
>>>>>> Beyond the blob management there's a bit of clean-up.
>>>>>> Mounting filesystems had to be changed so that options
>>>>>> a security module doesn't recognize won't be considered
>>>>>> a fatal error. The mount infrastructure is somewhat
>>>>>> more complex than one might assume.
>>>>> Casey,
>>>>> Do you think you can break out 1 into its own patch? It seems like
>>>>> that'd be valuable to everyone.
>>>> Yes, I think that is a good idea. Landlock, S.A.R.A. and a couple
>>>> other security modules could be added upstream if this part of the
>>>> work was available. It would not provide everything needed to stack
>>>> all the existing modules. I believe there is concern that if this
>>>> much went upstream the work on finishing what's required to make
>>>> everything work might be abandoned.
>>>>
>>> On the other hand there is concern that those security modules might
>>> be abandoned if they have to wait until everything is finished :)
>>
>> There is some truth to that. If we can get commitment from the developers
>> of those security module to push for getting upstream, a statement of
>> intent to support additional modules (e.g. Landlock, S.A.R.A.) from a

I'm the developer of S.A.R.A. I'm working on it in my free time, that
is not so much,
but I can confirm that my goal is to get it upstream as soon as possible.
Not that I want to rush anyone.

>> significant distribution (e.g. Fedora, Ubuntu, SuSE) and ACKs from the
>> maintainers of the existing modules we should be able to breeze right in.
>>
>> Yeah, I think that's about all it would take.
>
> I would strongly recommend Landlock and SARA for every distro. They're
> opt-in, and provide much-needed missing userspace defenses (and attack
> surface reduction).

Thank you very much for your support!

Salvatore
