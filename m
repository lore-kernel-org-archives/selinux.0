Received: from goalie.tycho.ncsc.mil (goalie.tycho.ncsc.mil [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w944nMfL009614
 for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2018 00:49:22 -0400
To: James Morris <jmorris@namei.org>, Kees Cook <keescook@chromium.org>
Cc: LSM <linux-security-module@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>, LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=
 <mic@digikod.net>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <f24ab6a2-aa1d-1c36-9e51-22c924ad37e5@schaufler-ca.com>
 <CAGXu5jL1Ek85Hky+PZ2pGQF09_cd_odn-LanYU=vVKgw24b8vg@mail.gmail.com>
 <alpine.LRH.2.21.1810040409280.13517@namei.org>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <6243a363-e15a-e3fe-37ce-fb4c0a150873@schaufler-ca.com>
Date: Wed, 3 Oct 2018 21:49:06 -0700
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1810040409280.13517@namei.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 14/19] LSM: Infrastructure management of the
 inode security
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/3/2018 11:13 AM, James Morris wrote:
> On Fri, 21 Sep 2018, Kees Cook wrote:
>
>> On Fri, Sep 21, 2018 at 5:19 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> + * lsm_early_inode - during initialization allocate a composite inode blob
>>> + * @inode: the inode that needs a blob
>>> + *
>>> + * Allocate the inode blob for all the modules if it's not already there
>>> + */
>>> +void lsm_early_inode(struct inode *inode)
>>> +{
>>> +       int rc;
>>> +
>>> +       if (inode == NULL)
>>> +               panic("%s: NULL inode.\n", __func__);
>>> +       if (inode->i_security != NULL)
>>> +               return;
>>> +       rc = lsm_inode_alloc(inode);
>>> +       if (rc)
>>> +               panic("%s: Early inode alloc failed.\n", __func__);
>>> +}
>> I'm still advising against using panic(), but I'll leave it up to James.
>>
> Calling panic() is not appropriate here. Perhaps if it was during 
> boot-time initialization of LSM infrastructure, but not on the fly.

Tetsuo's patch makes this an __init function. It's only for doing
init time stuff like root inode initialization during start-up.
If it fails the caller is going to have to panic. This came straight
out of the SELinux system initialization code. I could go back to
having each LSM do it's own panic, but that seems silly.

>
> Use a WARN_ONCE then propagate the error back and fail the operation.
>
>
