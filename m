Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6GHv31d019889
	for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2009 13:57:03 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n6GHvnsR005941
	for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2009 17:57:49 GMT
Date: Thu, 16 Jul 2009 13:57:01 -0400
Subject: Re: Patch to semanage
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C684E22D.A8D06%csellers@tresys.com>
In-Reply-To: <4A564ED7.2020206@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/9/09 4:11 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> Allows semanage to use equivalence.
> 
> Also adds better support for booleans and modules, add support for setting
> dontaudit rules.
> --- nsapolicycoreutils/semanage/semanage    2009-05-18 13:53:14.000000000
> -0400
> +++ policycoreutils-2.0.67/semanage/semanage    2009-07-07 16:47:35.000000000
> -0400
> @@ -44,16 +44,17 @@
>                 text = _("""
>  semanage [ -S store ] -i [ input_file | - ]
>  
> -semanage {boolean|login|user|port|interface|node|fcontext|translation} -{l|D}
> [-n]
> +semanage {module,boolean|login|user|port|interface|node|fcontext|translation}
> -{l|D} [-n]
>  semanage login -{a|d|m} [-sr] login_name | %groupname
>  semanage user -{a|d|m} [-LrRP] selinux_name
>  semanage port -{a|d|m} [-tr] [ -p proto ] port | port_range
>  semanage interface -{a|d|m} [-tr] interface_spec
>  semanage node -{a|d|m} [-tr] [ -p protocol ] [-M netmask] addr
> -semanage fcontext -{a|d|m} [-frst] file_spec
> +semanage fcontext -{a|d|m} [-frst] [-e path ] file_spec
>  semanage translation -{a|d|m} [-T] level
>  semanage boolean -{d|m} [--on|--off|-1|-0] -F boolean | boolean_file
> -semanage permissive -{d|a} type
> +semanage permissive -{a|d} type
> +semanage module -{a|d|} module
>  
So, you're adding module support to semanage, duplicating what semodule
already does? Are you proposing that we deprecate semodule or is there a
reason we need duplicate functionality? Or am I missing something?

>  Primary Options:
>  
> @@ -68,6 +69,7 @@
>      -h, --help       Display this message
>      -n, --noheading  Do not print heading when listing OBJECTS
>          -S, --store      Select and alternate SELinux store to manage
> +        --dontaudit      Turn on or off dontaudit rules
>  
>  Object-specific Options (see above):
>  
> @@ -84,6 +86,7 @@
>          -F, --file       Treat target as an input file for command, change
> multiple settings
>      -p, --proto      Port protocol (tcp or udp) or internet protocol version
> of node (ipv4 or ipv6)
>      -M, --mask       Netmask
> +        -e, --equil      Make target equil to this paths labeling

Did you mean for this to be "equal" instead of "equil?" Perhaps I'm missing
something, but dictionary.com turned up no results for equil. That said, I
like the idea as this seems to be a nice convenience feature.

<snip> 
> @@ -323,6 +342,9 @@
>          
>          if object == "boolean":
>              OBJECT = seobject.booleanRecords(store)
> +
> +        if object == "module":
> +            OBJECT = seobject.moduleRecords(store)
>          
The moduleRecords() method does not seem to exist anywhere that I can find
it. I'm guessing there is a corresponding patch to seobject.py?

>          if object == "translation":
>              OBJECT = seobject.setransRecords()
> @@ -341,6 +363,13 @@
>              OBJECT.deleteall()
>                          return
>              
> +        if dontaudit != "":
> +            if object == "module":
> +                               OBJECT.dontaudit(dontaudit)
> +                        else:
> +                               raise ValueError(_("%s bad option") % o)
> +                        return
> +
>          if len(cmds) != 1:
>                         raise ValueError(_("%s bad option") % o)
>                  
> @@ -362,11 +391,17 @@
>              if object == "interface":
>                  OBJECT.add(target, serange, setype)
>  
> +            if object == "module":
> +                OBJECT.add(target)
> +
>              if object == "node":
>                  OBJECT.add(target, mask, proto, serange, setype)
>  
>              if object == "fcontext":
> -                OBJECT.add(target, setype, ftype, serange, seuser)
> +                                if equil == "":
> +                                       OBJECT.add(target, setype, ftype,
> serange, seuser)
> +                                else:
> +                                       OBJECT.add_equil(target, equil)

The add_equil() method does not seem to exist either. I'm guessing there are
more missing methods as well.

Thanks,
Chad




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
