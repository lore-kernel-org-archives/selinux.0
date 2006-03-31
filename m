From: Christopher Ashworth <cashworth@tresys.com>
To: Joshua Brindle <jbrindle@tresys.com>
Subject: Re: The sort algorithm is broken by the second rule,  We need a way to pin these rules to the top.
Date: Fri, 31 Mar 2006 11:01:43 -0500
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>
References: <442D41CA.8070702@redhat.com> <442D4448.2090700@redhat.com> <442D47ED.6040007@tresys.com>
In-Reply-To: <442D47ED.6040007@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603311101.44534.cashworth@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 31 March 2006 10:17 am, Joshua Brindle wrote:
> Please note that the sorting algorithm is very much heuristic and not
> perfect. In the discussions we've had around here about this we
> determined that the correct solution is to make the regexes more
> specific where possible.

Indeed.  Strictly speaking, to properly order based on specificity we need to 
be able to solve the decision problem of whether one regular expression is a 
subset of another.  As such, until we have an implementation based on this 
method file contexts must be written with the limitations of our heuristics 
in mind.

In the following example:

> Running fc_sort from refpolicy on the following input:
> /usr(/.*)?/lib(64)?(/.*)?        gen_context(system_u:object_r:lib_t,s0)
> /usr(/.*)?/lib(64)?/.*\.so(\[^/]*)*    --  gen_context(system_u:object_r:shlib_t,s0)
> /usr(/.*)?/nvidia/.*\.so(\..*)?        --  gen_context(system_u:object_r:textrel_shlib_t,s0)
> /usr/lib(64)?/libglide3\.so.*      --    gen_context(system_u:object_r:textrel_shlib_t,s0)
> 
> yields the following output:
> /usr(/.*)?/lib(64)?(/.*)?       gen_context(system_u:object_r:lib_t,s0)
> /usr(/.*)?/nvidia/.*\.so(\..*)?        --      gen_context(system_u:object_r:textrel_shlib_t,s0)
> /usr(/.*)?/lib(64)?/.*\.so(\[^/]*)*   --    gen_context(system_u:object_r:shlib_t,s0)
> /usr/lib(64)?/libglide3\.so.*    --    gen_context(system_u:object_r:textrel_shlib_t,s0)

the nvidia entry "loses" because the stem matches the stem of the following 
line, and the overall length of the nvidia line is shorter.  With a 
subset-based approach we would be able to recognize that neither is a subset 
of the other, and so the original order could be preserved.  (The 
implementation of the sort is stable, but that doesn't really help us much 
seeing as our comparison operator is based on heuristics, so the definition 
of "stability" has become only as good as our heuristics.)

Christopher


Reference:  

http://www.cs.may.ie/~jpower/Courses/parsing/node14.html

-- 
Christopher Ashworth
Tresys Technology, LLC


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
