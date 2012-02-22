Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1MNMQwG010371
	for <selinux@tycho.nsa.gov>; Wed, 22 Feb 2012 18:22:26 -0500
Received: from [192.168.1.38] (unknown [86.67.70.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTPSA id 8F9C922E25B
	for <selinux@tycho.nsa.gov>; Wed, 22 Feb 2012 18:22:24 -0500 (EST)
Date: Wed, 22 Feb 2012 23:22:20 +0000
From: Martin Orr <martin@martinorr.name>
To: HarryCiao <harrytaurus2002@hotmail.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: role_fix_callback assertion with sysadm in base - base VS
 loadable module
Message-ID: <20120222232219.GA15452@claudius.martinorr.name>
References: <20120209225847.969915sba4w431r4@webmail.tuffmail.net>
 <SNT139-W2532C1EC901A78581F23C6AB600@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <SNT139-W2532C1EC901A78581F23C6AB600@phx.gbl>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry, I failed to make it clear that the requires causing problems are
in optional blocks.

Perhaps might make it clearer if I remove the refpolicy machinery.
Ignore everything below except the attribute_role stuff - the rest is
just needed to get something which compiles.

In each case, the base module optionally requires the role attribute
foo.  This works if the attribute is defined in the base but not
otherwise.  Both examples work if foo is a type instead of an
attribute_role.

  $ cat x.te
class file
sid kernel
class file {
        read
}

optional {
        require {
                attribute_role foo;
        }
}

type kernel_t;
user system_u roles { object_r };
sid kernel system_u:object_r:kernel_t

  $ checkmodule x.te 
checkmodule:  loading policy configuration from x.te
checkmodule: expand.c:700: role_fix_callback: Assertion `new_role != ((void *)0) && new_role->flavor == 1' failed.
Aborted

  $ cat y.te 
class file
sid kernel
class file {
        read
}

attribute_role foo;
optional {
        require {
                attribute_role foo;
        }
}

type kernel_t;
user system_u roles { object_r };
sid kernel system_u:object_r:kernel_t

  $ checkmodule y.te 
checkmodule:  loading policy configuration from y.te
checkmodule:  policy configuration loaded

On Sat, Feb 18, 2012 at 03:02:23PM +0000, HarryCiao wrote:
> 
> So far I am not 100% sure, but I am extra sure that certain cautions
> must be taken when requiring a module to be built into base.pp rather
> than as loadable module. In particular, while building the base module
> the "self_contained_policy" macro is defined, exactly the same as when
> building a monolithic policy image, which will influence if the
> gen_require() macro would be properly expanded to the "require"
> keyword. Below is the definition of the gen_require() macro:
> 
> define(`gen_require',`
>         ifdef(`self_contained_policy',`
>                 ifdef(`__in_optional_policy',`
>                         require {
>                                 $1
>                         } # end require
>                 ')
>         ',`
>                 require {
>                         $1
>                 } # end require
>         ')
> ')
> 
> Where we can clearly see that if the "self_contained_policy" is
> defined,  ONLY WHEN the "__in_optional_policy" is also defined, would
> gen_require() be expaned to the require keyword. BTW,
> "__in_optional_policy" is defined only within an optional_policy()
> block.
> 
> That's why I take it for granted that you would have to include the
> actual definition of a role attribute along with the module that
> requires it into the base module.
> 
> Cheers,
> Harry
> 
> 
> > Date: Thu, 9 Feb 2012 22:58:47 +0000
> > From: martin@martinorr.name
> > To: selinux@tycho.nsa.gov
> > Subject: role_fix_callback assertion with sysadm in base
> > 
> > I tried to build latest git refpolicy (6da98efd) using latest  
> > checkpolicy and libsepol (339f8079) with the attached modules.conf.   
> > In particular this puts sysadm into base.pp, and minimal other things.  
> >   I get the following error.
> > 
> > Compiling refpolicy base module
> > /usr/bin/checkmodule base.conf -o tmp/base.mod
> > /usr/bin/checkmodule:  loading policy configuration from base.conf
> > checkmodule: expand.c:700: role_fix_callback: Assertion `new_role !=  
> > ((void *)0) && new_role->flavor == 1' failed.
> > make: *** [tmp/base.mod] Aborted
> > 
> > -- 
> > Martin Orr
>  		 	   		  

-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
