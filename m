Date: Fri, 28 Sep 2018 08:13:32 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: LSM <linux-security-module@vger.kernel.org>,
 SE Linux <selinux@tycho.nsa.gov>, LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
 Salvatore Mesoraca <s.mesoraca16@gmail.com>
In-Reply-To: <5360cd42-5827-58af-515c-6e1ded1d9154@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1809280813270.8410@namei.org>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <5360cd42-5827-58af-515c-6e1ded1d9154@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH v4 04/19] SELinux: Remove cred security blob
 poisoning
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 21 Sep 2018, Casey Schaufler wrote:

> The SELinux specific credential poisioning only makes sense
> if SELinux is managing the credentials. As the intent of this
> patch set is to move the blob management out of the modules
> and into the infrastructure, the SELinux specific code has
> to go. The poisioning could be introduced into the infrastructure
> at some later date.

If it's useful, it should be incorporated into core LSM, otherwise that's 
a regression for SELinux.


-- 
James Morris
<jmorris@namei.org>
