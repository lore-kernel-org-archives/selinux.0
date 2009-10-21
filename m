Subject: Re: 'make policy' issues
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Laganowski <eric@laganowski.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4ADF2358.4050606@laganowski.net>
References: <4ADF2358.4050606@laganowski.net>
Content-Type: text/plain
Date: Wed, 21 Oct 2009 11:16:00 -0400
Message-Id: <1256138160.4061.200.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-10-21 at 11:06 -0400, Eric Laganowski wrote:
> Hello,
> 
>  I was trying to build selinux userspace tools on my custom linux build. 
> Everything went fine until I attempted to compile reference policy.
> Could you please help me in understanding what went wrong here.
> 
> refpolicy-2.20090730
> 
> $ make policy
> Compiling refpolicy policy.24
> /usr/bin/checkpolicy policy.conf -o policy.24
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> policy/modules/kernel/corenetwork.te":1715:ERROR 'syntax error' at token ':' on line 9122:
> allow corenet_unconfined_type node_type:node *;
> 
> checkpolicy:  error(s) encountered while parsing configuration
> make: *** [policy.24] Error 1
> 
> 
> Packages:
> 
> checkpolicy-2.0.19
> libselinux-2.0.85
> libsemanage-2.0.33
> libsepol-2.0.37
> policycoreutils-2.0.69
> sepolgen-1.0.17
> 
> $ yacc -V
> yacc - 1.9 20090221
> $ flex -V
> flex 2.5.35

Sounds similar to:
http://marc.info/?l=selinux&m=117076095205821&w=2

which was an upstream flex problem.  However, I also see that you are using yacc rather than bison?
Default for building checkpolicy is bison -y, which could be relevant.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
