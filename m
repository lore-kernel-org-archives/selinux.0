Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA14524
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 08:19:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA13452
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 12:17:34 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA13448 for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 12:17:34 GMT
Date: Fri, 26 Jul 2002 08:18:29 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Brian May <bam@snoopy.apana.org.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Attributes vs Macro
In-Reply-To: <20020726034514.GE27354@snoopy.apana.org.au>
Message-ID: <Pine.GSO.4.33.0207260808300.13369-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 26 Jul 2002, Brian May wrote:

> Out of these, why would you choose one over the other?
>
> 1. macro
>
> type mydomain1_t domain;

As a minor note, this should be 'type mydomain1_t, domain;'.

> define(`xyz_domain',`
> allow $1_t ...
> ...
> ')
>
> xyz_domain(mydomain1_t)
> xyz_domain(mydomain2_t)

As a minor note, either you want the macro to say "allow $1 ..." or you
want to omit the _t from the parameter, e.g. "xyz_domain(mydomain1)".

> 2. attribute
>
> type mydomain1_t domain, xyz;
> type mydomain2_t domain, xyz;
> allow xyz ...
>
> Are there any perfomance considerations when
> choosing one other the other?

These two forms are equivalent, and should compile to the same binary
policy, modulo ordering within the hash chains.  However, notice that
macros often perform more complex substitution, e.g. defining or referring
to domains and types with a shared prefix, like using $1_exec_t to refer
to the executable type for the domain or defining a $1_tmp_t for temporary
files created by the domain.  You can't achieve that via type attributes.
On the other side, you can use a type attribute anywhere that a type is
legal, so you can use them in constraints.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
