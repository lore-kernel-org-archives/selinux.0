Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2HJMeDo017426
	for <selinux@tycho.nsa.gov>; Thu, 17 Mar 2005 14:22:40 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2HJGMte023602
	for <selinux@tycho.nsa.gov>; Thu, 17 Mar 2005 19:16:26 GMT
Message-Id: <200503171915.j2HJFn8R000646@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Kaigai Kohei'" <kaigai@ak.jp.nec.com>
Cc: "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, <selinux-dev@tresys.com>
Subject: RE: [RFC & PATCH] inherited type definition.
Date: Thu, 17 Mar 2005 14:15:42 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <423980AC.60409@ak.jp.nec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Kaigai Kohei [mailto:kaigai@ak.jp.nec.com] 
> Sent: Thursday, March 17, 2005 8:06 AM
> To: Karl MacMillan
> Cc: 'KaiGai Kohei'; 'SELinux Mail List'; selinux-dev@tresys.com
> Subject: Re: [RFC & PATCH] inherited type definition.
> 
> Hello,
> 
>  > I'm not certain that you understand my objection. I'm not 
> suggesting that your  > patch conflicts with this idea, I 
> think that we should not make this type of  > language change 
> unless it address a broad set of issues, which to me includes 
>  > this group of types usage scenario. The EXTENDS syntax 
> seems, to me, to have a  > fairly narrow usage similar to 
> clone rules. The clone rules were ultimately  > dropped so I 
> don't think that we should go down that path again without 
> major  > additional advantages. In other words, I saying that 
> I think handling the group  > of types usage scenario is a 
> requirement to this type of language extension.
> 
> There are some difference between the EXTENDS syntax and CLONE.
> First, CLONE can't emulate multiple-parents inheritance. This 
> is useful and interresting character. Second, CLONE doesn't 
> have a selective permission grant syntax. I'm willing to 
> implement selective permission grant syntax such as '@' prefix.
> What CLONE was dropped is not appropriate for the reason of 
> this issue.
> 
> I feel this discussion fall into "discussion for discussion", 
> so it's not productive. You should make your target image 
> clear, and express your modeling.
> I can't compare practical functionality with vague images.
> 

This is a valid criticism - I don't have a concrete suggestion for my
requirements and I'll stop pushing it until I or someone else comes up with a
solution. I do, however, have a concrete alternative to this patch. After
thinking about this for a while, I think that the best alternative to this patch
right now is macros and simple copying of policy.

One of the stated uses for this patch is to allow naïve users to create a policy
based on an existing correct policy. Leaving aside whether it is a good idea for
naïve users to write straight SELinux policy, the problem with the extends
syntax is that it only allows for the creation of a superset of one or more
existing types (I guess that it can also create a copy, but then there would be
no reason for a new type). I assert that in most cases the creation of a new
policy that is similar to an existing policy will not result in this clean
superset. It is much easier to simply copy the existing .te file, run search and
replace to change the type names, and tweak as necessary.

The other uses for this syntax that I have seen suggested is to ease the
creation of two or more types that have a similar base set of permissions. I
think that macros address this use case well now and could be improved in the
future. The base_passwd_domain macro provides an example of how this is done. I
think that this is more understandable and easier to analyze than the extends
syntax, especially because the extends semantic is subtle (it has resulted in
considerable debate and it is still not clear exactly what is allowed and what
is not). With the extends syntax the entire policy must be examined to
understand what a type declaration actually allows if it includes an extend
statement. Macros are not perfect, but there is some hope that a single macro
(or a handful if it chains) is all that will have to be examined to have a
reasonable understanding of the allowed access resulting from a macro call.
Discipline in macro writing can make this situation even better.

I think that it is better to only add policy syntax when it solves a problem
that cannot be currently solved.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134  

>  > As I stated above, my example requires the attributes to 
> be applied to  > user/staff_ssh_t. This to me does not seem 
> to be a major drawback - in fact it  > gives more control to 
> the policy author.
> 
> Needless to say, the EXTENDS syntax does not prevent to apply 
> any attributes.
> In addition, your approach may be harmless, but opportunity 
> benefit as union-filetype will be lost if EXTENDS syntax is denied.
> 
> BTW, If we can control the access permission between 'group 
> of type' and union-filetype, it may be so flexible.
> i.e. "Right man in the right place"
> 
> Thanks,
> --
> DO NOTHING IS THE WORST POLICY.
> KaiGai Kohei <kaigai@kaigai.gr.jp>
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
