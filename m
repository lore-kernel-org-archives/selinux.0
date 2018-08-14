Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7ENoO2Q011189
 for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2018 19:50:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC03.oob.disa.mil (Postfix) with SMTP id 41qq8s2L2zzJmsQ
 for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2018 23:50:21 +0000 (UTC)
Received: from UPDC3CPA08_EEMSG_MP24.eemsg.mil (unknown [192.168.18.19])
 by UPDCF3IC03.oob.disa.mil (Postfix) with ESMTP id 41qq8r5dDmzJms8
 for <selinux@tycho.nsa.gov>; Tue, 14 Aug 2018 23:50:20 +0000 (UTC)
To: Jordan Glover <Golden_Miller83@protonmail.ch>
Cc: Sargun Dhillon <sargun@sargun.me>,
 LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>,
 "Schaufler, Casey" <casey.schaufler@intel.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
 <CAMp4zn94SzqK_Q=de2E+Fpv5yeAhYv62XW-KU3=ghRma9d7Jvw@mail.gmail.com>
 <a287800e-bd4d-2b99-8c4c-bd61ba87fab1@schaufler-ca.com>
 <kubjHWMWfFDu8Rk19x79iMDKVbewTUMWwSjOA7vFGIbYsWYcGb50jb-Z-PSXxmcby3ZFMZWi0HCeuFgo3F8BRskxo_JUdSHFhdIsIlBxHyQ=@protonmail.ch>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8e2bdc10-3142-9e8d-ff05-70fa4d862dd5@schaufler-ca.com>
Date: Tue, 14 Aug 2018 16:50:11 -0700
MIME-Version: 1.0
In-Reply-To: <kubjHWMWfFDu8Rk19x79iMDKVbewTUMWwSjOA7vFGIbYsWYcGb50jb-Z-PSXxmcby3ZFMZWi0HCeuFgo3F8BRskxo_JUdSHFhdIsIlBxHyQ=@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v1 00/22] LSM: Full security module stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 8/14/2018 4:22 PM, Jordan Glover wrote:
> On August 14, 2018 8:28 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>>
>>>> The blob management part (through "LSM: Sharing of security blobs")
>>>> is ready for prime-time. These changes move the management of
>>>> security blobs out of the security modules and into the security
>>>> module infrastructure. With this change the proposed S.A.R.A,
>>>> LandLock and PTAGS security modules could co-exist with any of
>>>> the existing "major" security modules. The changes reduce some
>>>> code duplication.
>>>> Beyond the blob management there's a bit of clean-up.
>>>> Mounting filesystems had to be changed so that options
>>>> a security module doesn't recognize won't be considered
>>>> a fatal error. The mount infrastructure is somewhat
>>>> more complex than one might assume.
>>> Casey,
>>> Do you think you can break out 1 into its own patch? It seems like
>>> that'd be valuable to everyone.
>> Yes, I think that is a good idea. Landlock, S.A.R.A. and a couple
>> other security modules could be added upstream if this part of the
>> work was available. It would not provide everything needed to stack
>> all the existing modules. I believe there is concern that if this
>> much went upstream the work on finishing what's required to make
>> everything work might be abandoned.
>>
> On the other hand there is concern that those security modules might
> be abandoned if they have to wait until everything is finished :)

There is some truth to that. If we can get commitment from the developers
of those security module to push for getting upstream, a statement of
intent to support additional modules (e.g. Landlock, S.A.R.A.) from a
significant distribution (e.g. Fedora, Ubuntu, SuSE) and ACKs from the
maintainers of the existing modules we should be able to breeze right in.

Yeah, I think that's about all it would take.
