Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j36FXODo018740
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 11:33:24 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j36FV0kY011558
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2005 15:31:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: [RFC & PATCH] inherited type definition.
Date: Thu, 7 Apr 2005 01:30:44 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>, kaigai@ak.jp.nec.com
References: <42346C17.3090301@kaigai.gr.jp> <200504062249.14886.russell@coker.com.au> <4253F745.9070609@kaigai.gr.jp>
In-Reply-To: <4253F745.9070609@kaigai.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Message-Id: <200504070130.46902.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 07 April 2005 00:50, KaiGai Kohei <kaigai@kaigai.gr.jp> wrote:
> > I don't like that idea.  Tracking when the '@' symbol should be used will
> > be beyond the skill of most people who write policy.  Then there is the
> > issue of someone writing a domain with the idea that it will never be
> > used for inheritance but then having it used for inheritance later.  If
> > the inherited domain has it's policy in the public repository then things
> > can get fixed, but if someone inherits a domain for their own private use
> > then they could get surprised by a policy update that grants some access
> > they didn't expect because the upstream policy developers didn't plan for
> > inheritance and didn't use the '@' symbol.
>
> I think that the required skill for tracking the security policy with
> inherited type is same as one for the security policy writen with
> attributes.

When inspecting policy to determine it's operation you can see a list of 
attributes on a type declaration and know that each applies to the type.

With inheritance as you describe you have exclusion rules such that you don't 
necessarily know that domain user_foo_t can access bar_t just because user_t 
can access bar_t and user_foo_t inherits.

If we want to make a change to the inheritance it doesn't change the access 
granted to just one domain or type but instead it operates on an unknown 
number of domains/types.

> > About a year ago I was involved in some discussions about these issues,
> > and one of the major factors was how to deal with
> > user_t/user_r/user_ssh_t and other_t/other_r/other_ssh_t type
> > inheritance.  One of the NSA guys asked me to write up a proposal for how
> > to do this.  After thinking about it for a year I haven't devised a good
> > answer.  If your work can result in a solution to this problem then I'm
> > sure that everyone will be willing to accept some trade-offs.  But
> > currently I am not convinced that the benefits outweigh the costs of
> > this.
>
> Does the example of user_t/user_r/user_ssh_t mean 'inherited domain'?
> It has not been a significant issue yet, I think.
> I think it's enough benefit to create a new type which can be accessed from
> multi domains. (e.g Apache & FTPd shared directory)

It does mean inherited domain.

I want to write policy such that someone can load a binary policy module for a 
new user role professor_r which then automatically creates the domain 
professor_foo_t because the base policy has appropriate statements that are 
equivalent in functionality to the macros we currently use in macros/programs 
for such things.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
