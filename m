To: paul@paul-moore.com
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 eparis@redhat.com, sds@tycho.nsa.gov, casey@schaufler-ca.com,
 jmorris@namei.org
Subject: Re: [PATCH] selinux: fix double free in selinux_parse_opts_str()
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <1490355659-13787-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHC9VhQc-55wALE-Qo=b1sY5Ts=Oo1Ra_xp+Euu_WSnuDowa0A@mail.gmail.com>
In-Reply-To: <CAHC9VhQc-55wALE-Qo=b1sY5Ts=Oo1Ra_xp+Euu_WSnuDowa0A@mail.gmail.com>
Message-Id: <201703251155.FBH12969.LFOFMHSFJQtOOV@I-love.SAKURA.ne.jp>
Date: Sat, 25 Mar 2017 11:55:47 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Paul Moore wrote:
> Hi,
> 
> Thank you very much for this patch, but I think we need to look a bit
> harder at this problem as it appears that many callers assume that
> selinux_parse_opts_str() cleans up after itself.  Looking quickly I
> found what appear to be two problems, there are likely more ...
> 
> * selinux_sb_remount()
> If selinux_parse_opts_str() fails here it doesn't appear we cleanup
> opts properly, although changing the jump target from
> "out_free_secdata" to "out_free_opts" would appear to correct this.
> 
> * btrfs_mount()
> This function calls parse_security_options() which in turn calls
> security_sb_parse_opts_str(), but if parse_security_options() fails in
> this case the security_mnt_opts are not free'd.
> 
> At this point I wonder if the quick fix is to set opts->mnt_opts to
> NULL after kfree()'ing it, or simply drop the kfree() call and call
> security_free_mnt_opts() in the out_err error handling code; the
> latter is a bit more work than needed, but I believe it should be safe
> in all conditions.

I think the latter is better.
We might allow multiple LSM modules to parse mount options in future
(not limited to SELinux + Smack combination, small LSMs might want to
parse mount options). Then, calling a common function for releasing
memory allocated by individual module will become needed.
