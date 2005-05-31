Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4V2hCgA029075
	for <selinux@tycho.nsa.gov>; Mon, 30 May 2005 22:43:12 -0400 (EDT)
Received: from rwcrmhc11.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4V2bMNW027296
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 02:37:23 GMT
Message-ID: <429BCDDD.8080106@gentoo.org>
Date: Mon, 30 May 2005 22:37:17 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: SE-Linux <selinux@tycho.nsa.gov>, selinuxdev <selinux-dev@tresys.com>
Subject: Re: smaller memory footprint for 'strict' policy - helping gentoo
 as well
References: <20050531012824.GI28006@lkcl.net>
In-Reply-To: <20050531012824.GI28006@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luke Kenneth Casson Leighton wrote:

>following on from me blithering on about gentoo, and tying
>in valdis' questions about smaller "strict" memory footprints
>[gods, i had no idea: i was going to recommend a strict selinux
>policy for 128mb machines let alone 256!], what is the way forward?
>
>valdis raised the question: does the new binary module system minimise
>the amount of memory used?
>  
>
yes and no. The loadable (we changed the name since binary == 
proprietary to many Linux users) module system by itself will not change 
anything kernel-side. That is, if you used the module compiler and built 
the current policy you would (should anyway ;P ) get an identical kernel 
policy. However, the module system does allow Red Hat and others that 
don't want to distribute policy source the ability to add and remove 
parts of the policy in production. This translates to less kernel policy 
and thus less memory usage if used appropriately.

>does that _actually_ help out wrt complexity of the selinux policy
>_source_ (probably not).
>
>  
>
no but the reference policies from Tresys will :)

>hm, to avoid confusion - the requirements:
>
>* to minimise memory usage at runtime
>
>  
>
>* to keep the number of source code files and size of source code
>  files to _absolute_ minimum (if done properly should cover 1st
>  requirement as well).
>
>  
>
Not sure why this is a requirement other than clarity, which small size 
does not necessarilly give you. The goal is a smaller kernel policy, all 
the stuff before that is development.

>* to still make it possible to have redhat-loved run-time "modules"
>  including having their associated runtime booleans.
>
>  
>
None of the policy features have changed, Red Hat will choose which 
options to continue as runtime booleans and which (if any) to move to 
the new link time optionals.

>* to still understand what's going on :)
>
>  
>
reference policies should make what is actually happening in policy 
*much* more clear 

>... would the concept of a macros/unused directory help out, here?
>along with a list of the macros you removed (and the files
>they're in), valdis - and why.  and chris, also?
>
>  
>
>... surely... there's some analysis done by the m4 macro
>compiler that automatically removes "unwanted" / "unused"
>macros?
>
>could that be done as a separate pre-pass / analysis step,
>making it unnecessary to consider a macros/unused directory?
>
>  
>
Why? if the macro is unused it never makes it past the policy.conf which 
you shouldn't be reading directly anyway, aside from debugging.

>any further thoughts, anyone?
>
>  
>
The main reason for the gigantic policy that nearly everyone loads is 
lack of policy management infrastructure which we are trying to address 
now. The modules are the first step toward this, more work later on will 
make the policy management far more robust.

Even before the module work you could always grab the sf.net cvs policy 
and disable all the modules you didn't want. It was possible to create a 
very small (= 20k rules) _usable_ policy from that, if you didn't need 
all the extra application policies.

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
