Subject: Re: refpolicy compilation issue
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Kirill \"REDbyte\" Novikov" <redbyte.labs@gmail.com>
Cc: SELinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <e768086c0902270753n3f16bbb6la8883bc4f7992073@mail.gmail.com>
References: <e768086c0902270357w2b34b11rebd3e8a98c58877a@mail.gmail.com>
	 <1235744081.26843.17.camel@localhost.localdomain>
	 <e768086c0902270753n3f16bbb6la8883bc4f7992073@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 27 Feb 2009 12:14:53 -0500
Message-Id: <1235754893.26843.26.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-02-27 at 20:53 +0500, Kirill "REDbyte" Novikov wrote:
> Thanks, Stephen, it's much clearer with warnings. As for refpolicy
> version and config - I'm trying to build refpolicy-2.20081210, with
> default build.conf, just: 
> # make conf ; make policy

Hmm..I don't seem able to replicate the error with that configuration.
What versions of flex and bison did you use to build checkpolicy?
What distribution are you using?

> BTW, policy.conf contains lots of garbage. Is it OK?  Here is what's
> around line 7140 of policy.conf

What do you mean by "garbage"?  If you mean the lines beginning with #,
those are comments inserted to help traceback errors to the original
sources from which the policy.conf is generated.

> 
> ##### begin init_sigchld(amavis_t) depth: 2
> #line 11
> 
> #line 11
> 
> #line 11
> 
> #line 11
> 
> #line 11
>                         require {
> #line 11
> 
> #line 11
>                 type init_t;
> #line 11
> 
> #line 11
>                         } # end require
> #line 11
> 
> #line 11
> 
> #line 11
> 
> #line 11
> 
> #line 11
> 
>         allow amavis_t init_t:process sigchld;
> #line 11
> 
> 
> #line 11
> 
> #line 11
> ##### end init_sigchld(amavis_t) depth: 1

Those lines look syntactically correct to me.

Can you provide a full copy of your policy.conf file somewhere (not to
the entire list; just put it up somewhere and post the URL or send it
privately to me)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
