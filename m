Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3QLOZ9b012431
 for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2017 17:24:36 -0400
Received: by mail-vk0-f43.google.com with SMTP id 198so7674401vkk.2
 for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2017 14:24:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201703251155.FBH12969.LFOFMHSFJQtOOV@I-love.SAKURA.ne.jp>
References: <1490355659-13787-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHC9VhQc-55wALE-Qo=b1sY5Ts=Oo1Ra_xp+Euu_WSnuDowa0A@mail.gmail.com>
 <201703251155.FBH12969.LFOFMHSFJQtOOV@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Apr 2017 17:24:33 -0400
Message-ID: <CAHC9VhRrmSbvR=_KUqrvYnMqM+mUYYcu9v6DbeB2dpPdGT7PjA@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix double free in selinux_parse_opts_str()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 casey@schaufler-ca.com, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Mar 24, 2017 at 10:55 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Paul Moore wrote:
>> Hi,
>>
>> Thank you very much for this patch, but I think we need to look a bit
>> harder at this problem as it appears that many callers assume that
>> selinux_parse_opts_str() cleans up after itself.  Looking quickly I
>> found what appear to be two problems, there are likely more ...
>>
>> * selinux_sb_remount()
>> If selinux_parse_opts_str() fails here it doesn't appear we cleanup
>> opts properly, although changing the jump target from
>> "out_free_secdata" to "out_free_opts" would appear to correct this.
>>
>> * btrfs_mount()
>> This function calls parse_security_options() which in turn calls
>> security_sb_parse_opts_str(), but if parse_security_options() fails in
>> this case the security_mnt_opts are not free'd.
>>
>> At this point I wonder if the quick fix is to set opts->mnt_opts to
>> NULL after kfree()'ing it, or simply drop the kfree() call and call
>> security_free_mnt_opts() in the out_err error handling code; the
>> latter is a bit more work than needed, but I believe it should be safe
>> in all conditions.
>
> I think the latter is better.
> We might allow multiple LSM modules to parse mount options in future
> (not limited to SELinux + Smack combination, small LSMs might want to
> parse mount options). Then, calling a common function for releasing
> memory allocated by individual module will become needed.

Hello,

I just wanted to check to see if you were going to do a follow up
patch for this?  If not I'll put something together, but I didn't want
to conflict with anything you were working on.

-- 
paul moore
www.paul-moore.com
