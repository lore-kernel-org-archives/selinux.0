MIME-Version: 1.0
In-Reply-To: <1246390647.13464.119.camel@moss-pluto.epoch.ncsc.mil>
References: <4c4ba1530906301153s5b8e4e93q4a1c970e1e96ea61@mail.gmail.com>
	 <1246390647.13464.119.camel@moss-pluto.epoch.ncsc.mil>
Date: Tue, 30 Jun 2009 14:44:36 -0700
Message-ID: <4c4ba1530906301444w2b6842f8vbc07c6827bd14c4b@mail.gmail.com>
Subject: Re: "Policy inclusion" tool ... ?
From: Tom London <selinux@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 30, 2009 at 12:37 PM, Stephen Smalley<sds@tycho.nsa.gov> wrote:
> On Tue, 2009-06-30 at 11:53 -0700, Tom London wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> I quite often am testing the latest Fedora selinux-policy packages
>> against Fedora Rawhide.
>>
>> When I bump into SELinux policy "slippage" with new packages and
>> components, I typically email off the evidence to Dan Walsh, and
>> create some local policy "fixes" to patch around the potholes.
>>
>> Typically, Dan fixes these pretty quickly.  I am then left with the
>> following question: Does the currently installed policy "include" the
>> rules added by my local .{te,pp} fixes.
>>
>> Of course, I can "semodule -r" the local module and then try to
>> recreate the trigger, but this is sometimes not all that easy to do.
>>
>> What would be handy would be a tool that would check a .{te,pp} file
>> against the currently running  policy, something like "se-is-included
>> localfoo.{te,pp}".
>>
>> I would think this could be of interest beyond my use case.
>>
>> As a quick and dirty hack, I composed the following shell script to
>> leverage "sesearch":
>>
>> #!/bin/bash
>>
>> while read a b c d e
>> do
>>        if [ "$a" == "allow" ]; then
>>                source=$b
>>                target=${c%%:*}
>>                class=${c##*:}
>>                if [ "$target" == "self" ]; then
>>                        target=$source
>>                fi
>>                echo "sesearch --allow -s $source -t $target -c $class"
>>                sesearch --allow -s $source -t $target -c $class
>>        fi
>> done
>>
>> Is something like this more generally interesting/useful?  Of course,
>> I'm certain there are better ways to implement this (e.g., parse the
>> .pp file instead of the .te file, handle more stuff from the modules,
>> etc.) but is the use of interest?
>
> Yes, that seems useful.
>
> I wouldn't invest in parsing .pp files at this point, as we anticipate
> phasing them out in favor of source modules.
>
> What your script won't presently handle are things like adding a type
> attribute to a type in your module and thereby changing the expansion of
> an allow rule in another module.  At present, I think the only way to
> truly check that the module is completely subsumed by the policy would
> be to take the policy before and after module insertion and sediff it.
>
> --
> Stephen Smalley
> National Security Agency
>
>
Sounds reasonable.

So a "policy inclusion tool" could look something like:

1. remove "local.pp" if it in the current policy
2. capture policy, say in "current.policy"
3. "semodule -i local.pp"
4. capture policy, say in "newer.policy"
5. "sediff current.policy \; newer.policy"
6. recover to current.policy, if appropriate

Do I understand your suggestion?

I notice reference to "stores" in some of the se-tools.  Are they useful here?

tom
-- 
Tom London


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
