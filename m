Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3RFeLj5019064
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 11:40:22 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3RFeKEq001234
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 15:40:21 GMT
Message-ID: <46321964.3000302@manicmethod.com>
Date: Fri, 27 Apr 2007 11:40:20 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Next policyrep patches
References: <1177686208.15215.7.camel@localhost.localdomain>
In-Reply-To: <1177686208.15215.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> Here is my plan for the next set of policyrep patches:
>
> 1. Basic policy objects (sepol/policy.h). Basic object system and
> top-level objects for the policy representation.
>
> 2. Policy components (each as a separate patch). For example, type
> declarations (which would include type and typealias) would be a patch
> adding include/sepol/types.h and src/types.c.
>
> For existing components (like booleans), I would like to merge the
> record and component files. So booleans.h and boolean_record.h would be
> merged. Objections?
>
>   
fine with me.
> 3. When all of the components are merged I'll send the parser changes.
> This is the first patch that will cause breakage. Any objection to
> checkmodule being broken for a while?
>   
Its well understood that the branch is going to be broken for a while, 
there is no way around that if we expect to do the development in a 
distributed way.

I'd like the components and tree structure as soon as possible so that 
we can start work on the linker and generator (expander).

This brings up some other questions, there is no such thing as an 
expander anymore, its really a code generator, do we want to change the 
API to reflect that difference or just leave the current 
sepol_expand_module function? I guess the general question is, how 
destructive are we looking to be with the exported API?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
