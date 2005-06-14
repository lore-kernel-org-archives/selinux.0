Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5ECT6gA014119
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2005 08:29:06 -0400 (EDT)
Received: from sccrmhc14.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5ECKoBf005194
	for <selinux@tycho.nsa.gov>; Tue, 14 Jun 2005 12:20:51 GMT
Message-ID: <42AECB96.9010500@tresys.com>
Date: Tue, 14 Jun 2005 08:20:38 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: selinux <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
Subject: Re: [RFC] Module language syntax
References: <1117217853.9785.22.camel@localhost> <20050527185331.GA1544@lkcl.net> <1117220066.9783.27.camel@localhost> <200506141512.21436.russell@coker.com.au>
In-Reply-To: <200506141512.21436.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Saturday 28 May 2005 04:54, Joshua Brindle <jbrindle@tresys.com> wrote:
>  
>
>>booleans and conditionals are runtime and are not at all affected by the
>>    
>>
>
>So loading a module can define new booleans?
>
>  
>
Yes, just like loading a module can define new types, roles, users, etc. 
load_policy would continue to set the booleans as it does now I'd imagine

>>loadable modules. The optional dependencies added for modules are
>>totally separate from conditionals and are much closer to m4 ifdefs in
>>practice and could hopefully be used to replace many of them.
>>    
>>
>
>The optional parts of modules will still take up disk space. 
>
Yes

> I presume that 
>they will take up RAM as well - the program that loads the policy won't know 
>which modules might be loaded.
>  
>
They will only take up ram during module linking. Optional policy tha 
has been disabled will never make it to the kernel

>Currently the strict policy is 10M in size and growing.  This is a problem 
>that will become worse if we remove ifdefs.
>
>  
>
The disabled optionals will only be present in their modules. The 
advantage here is that the policy should never be 10 meg in kernel 
memory if the user has disabled unneeded policy modules.

>Some ifdefs will need to be changed to optional dependencies for correct 
>functionality, maybe many.  I don't see this as a benefit but rather as an 
>unavoidable problem that is outweighed by the benefits of modules.
>  
>
The benefits are fairly large. Instead of using an ifdef that depends on 
the existance of a filename to determine if a type is available (very 
weak dependancy mechanism) you use an optional that depends on that 
specific type actually being present. This stops policy breakage that 
occurs when you try disabling certain modules that are improperly 
ifdef'd. Further, it allows more freedom in policy development since 
modules (and optional blocks) will now depend on the existance of types, 
roles, etc instead of filenames. For example, if someone wanted to split 
up a policy they'd have to search for everywhere the types in those 
policies are used and rewrap the statements in ifdefs wheras with this 
nothing needs to be done, if the dependancies are met the module and 
optional block will become active.

One of the purposes of loadable policy modules was to fix the dependancy 
problem in policy. Each module has require block(s) that specify all the 
symbols that this particular module will need. The optional blocks are a 
way of specifying policy that should optionally be activated given the 
presense of certain symbols. The language changes we made make them use 
the exact same syntax for each so that, for example, a macro that 
declares it's depenencies will be able to do so whether it's in the 
global scope of a module or inside an optional without needing to know 
the difference.

Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
