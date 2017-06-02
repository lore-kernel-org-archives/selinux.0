Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v52EY77B013913
 for <selinux@tycho.nsa.gov>; Fri, 2 Jun 2017 10:34:08 -0400
Received: by mail-lf0-f66.google.com with SMTP id u62so4667710lfg.0
 for <selinux@tycho.nsa.gov>; Fri, 02 Jun 2017 07:33:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTHhiuaL5Lih1ykXX+wib9xyvriMvnoX+tAkpgEOxwCng@mail.gmail.com>
References: <20170421094909.28961-1-fw@strlen.de>
 <20170421094909.28961-3-fw@strlen.de>
 <CAHC9VhTkAp+e2PQV58ARtYk8XZJSadaSZWoQudDX9DfQjnfATQ@mail.gmail.com>
 <CAHC9VhTHhiuaL5Lih1ykXX+wib9xyvriMvnoX+tAkpgEOxwCng@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 2 Jun 2017 10:33:43 -0400
Message-ID: <CAHC9VhTjfe0rzVDe6v_z55xfzgSx1ANGm_me=6usf=BNpMWpyQ@mail.gmail.com>
Subject: Re: [PATCH security-next 2/2] selinux: use pernet operations for hook
 registration
To: Florian Westphal <fw@strlen.de>, selinux@tycho.nsa.gov
Cc: linux-security-module@vger.kernel.org, pablo@netfilter.org,
 Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Apr 26, 2017 at 4:47 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Apr 26, 2017 at 4:46 PM, Paul Moore <paul@paul-moore.com> wrote:
>> On Fri, Apr 21, 2017 at 5:49 AM, Florian Westphal <fw@strlen.de> wrote:
>>> It will allow us to remove the old netfilter hook api in the near future.
>>>
>>> Signed-off-by: Florian Westphal <fw@strlen.de>
>>> ---
>>>  security/selinux/hooks.c | 24 ++++++++++++++++++++----
>>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> Looks fine to me, I'm going to queue this up for after the v4.12 merge window.
>
> ... and I just realized that the SELinux list wasn't CC'd on this
> patch, fixing that now.

Merged, thanks.

-- 
paul moore
www.paul-moore.com
