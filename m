Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v47JgxVi031451
 for <selinux@tycho.nsa.gov>; Sun, 7 May 2017 15:43:03 -0400
Received: by mail-qk0-f174.google.com with SMTP id k74so38036870qke.1
 for <selinux@tycho.nsa.gov>; Sun, 07 May 2017 12:42:54 -0700 (PDT)
Received: from strange.local (50-253-7-1-static.hfc.comcastbusiness.net.
 [50.253.7.1])
 by smtp.googlemail.com with ESMTPSA id p20sm3592837qtf.31.2017.05.07.12.42.51
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 May 2017 12:42:52 -0700 (PDT)
Message-ID: <590F78BA.5040800@quarksecurity.com>
Date: Sun, 07 May 2017 15:42:50 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Announcing SPAN: SELinux Policy Analysis Notebook
References: <EDB27428-18DD-4A40-9A1E-AE2DC9390F99@gmail.com>
 <20170506140358.GA21008@julius> <20170506161956.GA20145@julius>
 <20170506171920.GB20145@julius> <590F3B98.406@quarksecurity.com>
 <20170507154759.GA31890@julius>
In-Reply-To: <20170507154759.GA31890@julius>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Dominick Grift wrote:
> On Sun, May 07, 2017 at 11:22:00AM -0400, Joshua Brindle wrote:the
>> Dominick Grift wrote:
>> <snip>
>>
>>> The idea is nice, unfortunately its inflexible and it has hard-references to reference policy all-over. It has potential but it is still rough.
>>>
>> Of course, it is an analysis of a refpolicy-based policy. If you want to
>> analyze a different policy (e.g., Android or home-rolled) you will have to
>> change out all of the type sets, etc.
>>
>> You can't make a magic generic analysis script without knowing how key parts
>> of the system work and what types are associated with those components.
>
> What do you mean? that for example that hard-coded array of "trusted" types. Is that not just redundant.
>

you mean the example trusted types? I'm not sure I understand your concern.

> Can't i just create that array myself and use it to exlude rules with types in that array? That was one does not have to hard-code it.
>

It is python, you can do anything you want. The example notebook is a 
starting point, anyone doing an analysis would probably make major 
changes for their analysis, which is the point. You modify the notebook 
to build a usable analysis between the starting policy and the policy 
you are analyzing.

I've thought about trying this on an Android policy but haven't made it 
a priority.

> Also with regard to hardcoding the refpolicy file system (ps.load_policy_source). I mean if youre just going to `grep -r` then why do we have to assume anything there and hard code file suffixed, directory structures etc etc?
