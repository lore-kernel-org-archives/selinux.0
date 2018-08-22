Date: Wed, 22 Aug 2018 19:59:19 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: Jordan Glover <Golden_Miller83@protonmail.ch>,
 Sargun Dhillon <sargun@sargun.me>,
 LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 "Schaufler, Casey" <casey.schaufler@intel.com>
In-Reply-To: <8e2bdc10-3142-9e8d-ff05-70fa4d862dd5@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1808221958170.29682@namei.org>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
 <CAMp4zn94SzqK_Q=de2E+Fpv5yeAhYv62XW-KU3=ghRma9d7Jvw@mail.gmail.com>
 <a287800e-bd4d-2b99-8c4c-bd61ba87fab1@schaufler-ca.com>
 <kubjHWMWfFDu8Rk19x79iMDKVbewTUMWwSjOA7vFGIbYsWYcGb50jb-Z-PSXxmcby3ZFMZWi0HCeuFgo3F8BRskxo_JUdSHFhdIsIlBxHyQ=@protonmail.ch>
 <8e2bdc10-3142-9e8d-ff05-70fa4d862dd5@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH v1 00/22] LSM: Full security module stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 14 Aug 2018, Casey Schaufler wrote:

> On 8/14/2018 4:22 PM, Jordan Glover wrote:
> > On August 14, 2018 8:28 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On the other hand there is concern that those security modules might
> > be abandoned if they have to wait until everything is finished :)
> 
> There is some truth to that. If we can get commitment from the developers
> of those security module to push for getting upstream, a statement of
> intent to support additional modules (e.g. Landlock, S.A.R.A.) from a
> significant distribution (e.g. Fedora, Ubuntu, SuSE) and ACKs from the
> maintainers of the existing modules we should be able to breeze right in.
> 

Sounds reasonable. Please focus on what's needed for Landlock and SARA.


-- 
James Morris
<jmorris@namei.org>
