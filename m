To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 Joe Perches <joe@perches.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@tycho.nsa.gov
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
 <fcac609a-08a8-b3ab-a69e-2e65e2ad63e9@schaufler-ca.com>
 <alpine.LRH.2.21.1806130631400.13763@namei.org>
 <CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
From: John Johansen <john.johansen@canonical.com>
Message-ID: <9ae2397b-ad11-d437-d0f4-4e4f0dff4ce9@canonical.com>
Date: Tue, 12 Jun 2018 14:29:31 -0700
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTpsYDT5+CjdtiBmLMDEKV9fmGv+DyXVtUuja9d4i2ecg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [-next PATCH] security: use octal not symbolic
 permissions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/12/2018 02:12 PM, Paul Moore wrote:
> On Tue, Jun 12, 2018 at 4:32 PM, James Morris <jmorris@namei.org> wrote:
>> On Mon, 11 Jun 2018, Casey Schaufler wrote:
>>
>>> If you want to break this up by security module I would take
>>> the Smack part as soon as James does the tree update. If James
>>> wants to take the whole thing at once you can add my:
>>>
>>> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
>>>
>>> for the Smack changes.
>>
>> It's probably simplest for me to take them as one patch.
> 
> I would prefer if the SELinux changes were split into a separate
> patch.  I'm guessing John would probably want the same for the
> AppArmor patches, but take his work for it, not mine.

yes that would be preferred

> 
> Joe, in general I really appreciate the fixes you send, but these
> patches that cross a lot of subsystem boundaries (this isn't the first
> one that does this) causes unnecessary conflicts in -next and during
> the merge window.  Could you split your patches up from now on please?
> 

yeah splitting patches at subsystem boundaries is highly recommended.
