Subject: Re: "Policy inclusion" tool ... ?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tom London <selinux@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <4c4ba1530906301153s5b8e4e93q4a1c970e1e96ea61@mail.gmail.com>
References: <4c4ba1530906301153s5b8e4e93q4a1c970e1e96ea61@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 30 Jun 2009 15:37:27 -0400
Message-Id: <1246390647.13464.119.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-06-30 at 11:53 -0700, Tom London wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I quite often am testing the latest Fedora selinux-policy packages
> against Fedora Rawhide.
> 
> When I bump into SELinux policy "slippage" with new packages and
> components, I typically email off the evidence to Dan Walsh, and
> create some local policy "fixes" to patch around the potholes.
> 
> Typically, Dan fixes these pretty quickly.  I am then left with the
> following question: Does the currently installed policy "include" the
> rules added by my local .{te,pp} fixes.
> 
> Of course, I can "semodule -r" the local module and then try to
> recreate the trigger, but this is sometimes not all that easy to do.
> 
> What would be handy would be a tool that would check a .{te,pp} file
> against the currently running  policy, something like "se-is-included
> localfoo.{te,pp}".
> 
> I would think this could be of interest beyond my use case.
> 
> As a quick and dirty hack, I composed the following shell script to
> leverage "sesearch":
> 
> #!/bin/bash
> 
> while read a b c d e
> do
>        if [ "$a" == "allow" ]; then
>                source=$b
>                target=${c%%:*}
>                class=${c##*:}
>                if [ "$target" == "self" ]; then
>                        target=$source
>                fi
>                echo "sesearch --allow -s $source -t $target -c $class"
>                sesearch --allow -s $source -t $target -c $class
>        fi
> done
> 
> Is something like this more generally interesting/useful?  Of course,
> I'm certain there are better ways to implement this (e.g., parse the
> .pp file instead of the .te file, handle more stuff from the modules,
> etc.) but is the use of interest?

Yes, that seems useful.

I wouldn't invest in parsing .pp files at this point, as we anticipate
phasing them out in favor of source modules.

What your script won't presently handle are things like adding a type
attribute to a type in your module and thereby changing the expansion of
an allow rule in another module.  At present, I think the only way to
truly check that the module is completely subsumed by the policy would
be to take the policy before and after module insertion and sediff it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
