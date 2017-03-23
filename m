To: dvyukov@google.com, paul@paul-moore.com, sds@tycho.nsa.gov,
 eparis@parisplace.org, james.l.morris@oracle.com, serge@hallyn.com,
 keescook@chromium.org, anton@enomsg.org, ccross@android.com,
 tony.luck@intel.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com
Subject: Re: security: double-free in superblock_doinit
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <CACT4Y+bb83Vku6iTtSp34HzM+hr+ZZD4Pex-N10qehfXXhHQjA@mail.gmail.com>
In-Reply-To: <CACT4Y+bb83Vku6iTtSp34HzM+hr+ZZD4Pex-N10qehfXXhHQjA@mail.gmail.com>
Message-Id: <201703231949.EDJ81789.FHMQOFLFOtVOJS@I-love.SAKURA.ne.jp>
Date: Thu, 23 Mar 2017 19:49:12 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Dmitry Vyukov wrote:
> Hello,
> 
> I've got the following double-free report in superblock_doinit while
> running syzkaller fuzzer.
> Note the preceding injected failure in kmalloc, most likely that the root cause.

Thank you for reporting.

selinux_parse_opts_str() and smack_parse_opts_str() forgot to set
opts->mnt_opts to NULL after kfree() at

if (!opts->mnt_opts_flags) {
	kfree(opts->mnt_opts);
	goto out_err;
}

and caused double free at

if (opts->mnt_opts)
	for (i = 0; i < opts->num_mnt_opts; i++)
		kfree(opts->mnt_opts[i]);

in security_free_mnt_opts().
