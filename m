Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uABIBfb4001465
 for <selinux@tycho.nsa.gov>; Fri, 11 Nov 2016 13:11:41 -0500
Received: by mail-wm0-f41.google.com with SMTP id t79so105742757wmt.0
 for <selinux@tycho.nsa.gov>; Fri, 11 Nov 2016 10:11:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <021477d4-6816-1915-e84a-f038b30dbbd1@gmail.com>
References: <CAFJ0LnGZ-f1UUK+yJevWKu=En5CK3s8ywaef_jju4ZFuU+LonA@mail.gmail.com>
 <021477d4-6816-1915-e84a-f038b30dbbd1@gmail.com>
From: Nick Kralevich <nnk@google.com>
Date: Fri, 11 Nov 2016 10:11:05 -0800
Message-ID: <CAFJ0LnFesuFFSi5C2MHs7qHgPvo3WjSuQ5RFXUixSEVENmzwrg@mail.gmail.com>
Subject: Re: checkpolicy dontaudit compiler bug?
To: Dominick Grift <dac.override@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Nov 11, 2016 at 9:59 AM, Dominick Grift <dac.override@gmail.com> wrote:
>> Specifically, the following dontaudit rule is in that file:
>>
>>   dontaudit su self:capability_class_set *;
>>
>> which expands out to:
>>
>>   dontaudit su self:{ capability capability2 } *;
>>
>
> That should not work. AFAIK you cannot use the "*" with two different
> classes
>
> you would need to
>
> dontaudit su self:capability *;
> dontaudit su self:capability2 *;
>
> Maybe the other policy "bullhead" does not have the invalid
> dontaudit su self:capability_class_set *; rule

They both have the same "dontaudit su self:capability_class_set *"
statements, yet one compiles differently than the other.

nnk@nick:~$ wget -q http://kralevich.com/bullhead.policy.conf
nnk@nick:~$ wget -q http://kralevich.com/marlin.policy.conf
nnk@nick:~$ grep "dontaudit su" bullhead.policy.conf
marlin.policy.conf | grep capability
bullhead.policy.conf:  dontaudit su self:{ capability capability2 } *;
marlin.policy.conf:  dontaudit su self:{ capability capability2 } *;

And changing from

  dontaudit su self:{ capability capability2 } *;

to

  dontaudit su self:capability *;
  dontaudit su self:capability2 *;

has no effect and the policy continues to not pick up the neverallow rules.

-- Nick
