Date: Mon, 14 Mar 2005 18:10:49 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
   SELinux Mail List <selinux@tycho.nsa.gov>, kaigai@ak.jp.nec.com
Subject: Re: [RFC & PATCH] inherited type definition.
Message-ID: <20050314181049.GF4359@lkcl.net>
References: <42346C17.3090301@kaigai.gr.jp> <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil> <4235C937.3030404@kaigai.gr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4235C937.3030404@kaigai.gr.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Mar 15, 2005 at 02:26:15AM +0900, KaiGai Kohei wrote:
> Hello, Thanks for your comments.
> 
> > 1) Should the child domain inherit all rules that involved the parent
> > domain at all, or only rules where the parent domain was the
> > source/subject in the rule?  It looks like you have chosen the former,
> > but this means that any domain that can act on the parent domain can act
> > in the same manner on the child domain directly; not clear that this is
> > always what you want.
> 
> In my patch, child domain/type inherit all rules including target/object
> and area of ROLE clearly, not only source/subject.
> (Those source/target is also included in TYPE_TRANSITION statements.)
> Any permissions to parent means permissions to child/descendant concurrently.
> 
> 
> > 2) Should the child domain inherit rules between the parent and the
> > child, i.e. should the child be able to do anything to itself that the
> > parent can do to it?  It looks like you are inheriting such rules, but
> > is this always desirable, e.g. the parent may need permissions to set up
> > the child, control it, kill it, etc that the child may not need to
> > itself.
> 
> When parent has permissions to himself, child also has permissions to his
> parent and himself(child). In my patch, to inherit type/domain always expand
> descendant's permissions. I intend to define a child type/domain which has
> tiny larger permission than own parent low cost.
> 
> I think definition of reductive permission child-type/domain is the next
> action assignment. If child does not need a part of the parent's permissions,
> those should be revoked by DENY statement for example.
 
  oh dear.

  reminds me of the "GO FROM" statement.

  ideas:
  
  1) "wrap" bits of a domain policy in some syntax extension with
     oh i dunno a codeword "inheritable".

     inheritable {
     	allow ....
     };

     this idea inspired by the c++ "public/private/protected"
     system although of course it's nowhere near the same: c++
     doesn't have a concept of excluding bits of a class for
     inheritance.

  2) explicitly specify, post-child-domain creation, with DENY
     statements, those bits which should not be inherited.

  3) do nothing: expect developers to refactor.


  3) stephen has already explained that he does not favour
  it because if you're going to bother refactor, you might as
  well do it with existing macro syntax.

  i responded to this by asking what benefits inheritance brings
  that macro refactoring doesn't: if there aren't any, why bother
  with the concept of inheritance at all?

  2) smells of the joke language extensions to BASIC - "GO FROM".
     sorry - but it does :)
     
     give with one hand, then take away with the other _after_
     the fact.  i think this is a bad idea.

  1) is a minimised version of 3) where you wouldn't actually
     modify any names of any _existing_ policy types, just
     place a "wrap" around them to say which bits it's okay
     for child domains to inherit.

 l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
