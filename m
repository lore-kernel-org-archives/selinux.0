Date: Tue, 2 Oct 2018 03:58:52 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Kees Cook <keescook@chromium.org>,
 LSM <linux-security-module@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>, LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 Salvatore Mesoraca <s.mesoraca16@gmail.com>
In-Reply-To: <b209d4b8-81a5-30aa-f4d1-9372bbb1b842@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1810020352030.9994@namei.org>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
 <680e6e16-0890-8304-0e8e-6c58966813b5@schaufler-ca.com>
 <CAGXu5j+7FpFDNuOowdHzJ5RXgfETQMv=Fe-EU1gWo+nWK+goZA@mail.gmail.com>
 <39457e79-3816-824b-6b4d-89d21b03f9ce@i-love.sakura.ne.jp>
 <b209d4b8-81a5-30aa-f4d1-9372bbb1b842@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH v4 00/19] LSM: Module stacking for SARA and
 Landlock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, 23 Sep 2018, Casey Schaufler wrote:

> >   How do you plan to handle LKM-based LSMs?
> 
> My position all along has been that I don't plan to handle LKM
> based LSMs, but that I won't do anything to prevent someone else
> from adding them later. I believe that I've done that. Several
> designs, including a separate list for dynamically loaded modules
> have been proposed. I think some of those would work.

Dynamically loadable LSMs are a bad idea, per several previous 
discussions. As a general design concept, kernel security mechanisms 
should be invoked during boot, so we can reason about the overall state of 
the system at a given point.

In any case, we do not need to take dynamic LSMs into account at this 
stage. We don't build infrastructure for non-existent features.
