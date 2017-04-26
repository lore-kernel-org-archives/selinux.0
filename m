Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3QKlWc8024961
 for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2017 16:47:33 -0400
Received: by mail-ua0-f194.google.com with SMTP id x28so1087313uab.3
 for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2017 13:47:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTkAp+e2PQV58ARtYk8XZJSadaSZWoQudDX9DfQjnfATQ@mail.gmail.com>
References: <20170421094909.28961-1-fw@strlen.de>
 <20170421094909.28961-3-fw@strlen.de>
 <CAHC9VhTkAp+e2PQV58ARtYk8XZJSadaSZWoQudDX9DfQjnfATQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Apr 2017 16:47:30 -0400
Message-ID: <CAHC9VhTHhiuaL5Lih1ykXX+wib9xyvriMvnoX+tAkpgEOxwCng@mail.gmail.com>
Subject: Re: [PATCH security-next 2/2] selinux: use pernet operations for hook
 registration
To: Florian Westphal <fw@strlen.de>, selinux@tycho.nsa.gov
Cc: linux-security-module@vger.kernel.org, pablo@netfilter.org,
 Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Apr 26, 2017 at 4:46 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Apr 21, 2017 at 5:49 AM, Florian Westphal <fw@strlen.de> wrote:
>> It will allow us to remove the old netfilter hook api in the near future.
>>
>> Signed-off-by: Florian Westphal <fw@strlen.de>
>> ---
>>  security/selinux/hooks.c | 24 ++++++++++++++++++++----
>>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> Looks fine to me, I'm going to queue this up for after the v4.12 merge window.

... and I just realized that the SELinux list wasn't CC'd on this
patch, fixing that now.

>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index e67a526d1f30..3aa4268525e2 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -6448,6 +6448,23 @@ static struct nf_hook_ops selinux_nf_ops[] = {
>>  #endif /* IPV6 */
>>  };
>>
>> +static int __net_init selinux_nf_register(struct net *net)
>> +{
>> +       return nf_register_net_hooks(net, selinux_nf_ops,
>> +                                    ARRAY_SIZE(selinux_nf_ops));
>> +}
>> +
>> +static void __net_exit selinux_nf_unregister(struct net *net)
>> +{
>> +       nf_unregister_net_hooks(net, selinux_nf_ops,
>> +                               ARRAY_SIZE(selinux_nf_ops));
>> +}
>> +
>> +static struct pernet_operations selinux_net_ops = {
>> +       .init = selinux_nf_register,
>> +       .exit = selinux_nf_unregister,
>> +};
>> +
>>  static int __init selinux_nf_ip_init(void)
>>  {
>>         int err;
>> @@ -6457,13 +6474,12 @@ static int __init selinux_nf_ip_init(void)
>>
>>         printk(KERN_DEBUG "SELinux:  Registering netfilter hooks\n");
>>
>> -       err = nf_register_hooks(selinux_nf_ops, ARRAY_SIZE(selinux_nf_ops));
>> +       err = register_pernet_subsys(&selinux_net_ops);
>>         if (err)
>> -               panic("SELinux: nf_register_hooks: error %d\n", err);
>> +               panic("SELinux: register_pernet_subsys: error %d\n", err);
>>
>>         return 0;
>>  }
>> -
>>  __initcall(selinux_nf_ip_init);
>>
>>  #ifdef CONFIG_SECURITY_SELINUX_DISABLE
>> @@ -6471,7 +6487,7 @@ static void selinux_nf_ip_exit(void)
>>  {
>>         printk(KERN_DEBUG "SELinux:  Unregistering netfilter hooks\n");
>>
>> -       nf_unregister_hooks(selinux_nf_ops, ARRAY_SIZE(selinux_nf_ops));
>> +       unregister_pernet_subsys(&selinux_net_ops);
>>  }
>>  #endif
>>
>> --
>> 2.10.2
>>
>
>
>
> --
> paul moore
> www.paul-moore.com



-- 
paul moore
www.paul-moore.com
