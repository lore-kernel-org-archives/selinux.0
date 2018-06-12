Date: Wed, 13 Jun 2018 06:32:34 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: Joe Perches <joe@perches.com>, John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1806130631400.13763@namei.org>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
 <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [-next PATCH] security: use octal not symbolic
 permissions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 11 Jun 2018, Casey Schaufler wrote:

> If you want to break this up by security module I would take
> the Smack part as soon as James does the tree update. If James
> wants to take the whole thing at once you can add my:
> 
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> 
> for the Smack changes.

It's probably simplest for me to take them as one patch.

-- 
James Morris
<jmorris@namei.org>
