Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0DM5APn019699
 for <selinux@tycho.nsa.gov>; Mon, 13 Jan 2014 17:05:11 -0500
To: mszeredi@suse.cz, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH 00/11] cross rename v3
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <1389219015-10980-1-git-send-email-miklos@szeredi.hu>
 <201401132146.BAF65659.QJSOFVOtFHMOFL@I-love.SAKURA.ne.jp>
 <1389632933.16290.15.camel@tucsk.piliscsaba.szeredi.hu>
In-Reply-To: <1389632933.16290.15.camel@tucsk.piliscsaba.szeredi.hu>
Message-Id: <201401140703.ICH21836.HMJStQVFOFOLOF@I-love.SAKURA.ne.jp>
Date: Tue, 14 Jan 2014 07:03:55 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dhowells@redhat.com, jack@suse.cz, zab@redhat.com, miklos@szeredi.hu,
 linux-kernel@vger.kernel.org, luto@amacapital.net, hch@infradead.org,
 viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
 akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Miklos Szeredi wrote:
> Cross rename (A, B) is equivalent to plain rename(A, B) + plain rename
> (B, A) done as a single atomic operation.  If security module allows
> both then cross rename is allowed.  If at least one is denied then the
> cross rename is denied.

Yes, the functionality itself is fine. The problem is how LSM users check
their permissions for the functionality.

> 
> This is prepared for in "[PATCH 06/11] security: add flags to rename
> hooks" and actually done in "[PATCH 07/11] vfs: add cross-rename".
> 
> Security people are free to implement a explicit security check for
> cross rename, but I don't think that is in the scope of this patchset.
> 
I don't know how their permissions are checked, but I think that
swapping /A/B and /C/D should check not only

  Remove a name from directory A
  Add a name to directory C

but also

  Add a name to directory A
  Remove a name from directory C

using their security labels.

Without making changes to security/*/ directory, SELinux/SMACK/TOMOYO/AppArmor
might fail to check the latter permissions. Please get confirmation from LSM
people before you merge this change to linux-next tree.
