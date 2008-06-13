Subject: Re: checkpolicy misrepresents the line an error is on
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, method@manicmethod.com
In-Reply-To: <1213381484.3029.43.camel@localhost.localdomain>
References: <1213381484.3029.43.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 13 Jun 2008 14:27:53 -0400
Message-Id: <1213381673.17842.366.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-06-13 at 14:24 -0400, Eric Paris wrote:
> Here's a neat new issue, (that's i'm not totally sure is an issue) I'll
> get to looking at it myself eventually (yes sds, I do realize this is
> open source :-P), so don't waste much time on it.
> 
> In the base policy below notice I've got user1_u allowed for role1_r but
> NOT for role2_r.  I then have a genfscon statement which uses
> user1_u:role2_r (illegal)  It bombs, but tells me the wrong line!
> 
> [paris@localhost dismod-test]$ checkmodule -M -o base.mod base.conf
> checkmodule:  loading policy configuration from base.conf
> base.conf:50:ERROR 'invalid security context' at token 'genfscon' on line 50:
> genfscon proc /2	user1_u:role1_r:type1_t:s0
> genfscon proc /1	user1_u:role2_r:type1_t:s0
> checkmodule:  error(s) encountered while parsing configuration
> 
> It lays the blame on line 50 which actually has a valid context.
> 
> anyway, feel free to tell me the compiler doesn't know its broken until
> the first token on the next line and I should just deal with it, but I
> know I'd get mad looking at line50 trying to figure out what was wrong
> with that valid context when the busted one was on line 49.

If only I had ended all statements with semicolons in the language...

> 
> ---
> 
> class class1
> 
> sid sid1
> 
> class class1
> {
> 	perm1
> 	perm2
> }
> 
> sensitivity s0;
> 
> dominance { s0 }
> 
> category c0; category c1; category c2; category c3;
> category c4; category c5; category c6; category c7;
> category c8; category c9; category c10; category c11;
> category c12; category c13; category c14; category c15;
> category c16; category c17; category c18; category c19;
> category c20; category c21; category c22; category c23;
> 
> level s0:c0.c23;
> 
> mlsconstrain class1 { perm1 perm2 }
> 	( h1 dom h2 );
> 
> attribute attr1;
> 
> type type1_t;
> type type2_t;
> role role1_r types { type1_t type2_t };
> role role2_r types { type1_t type2_t };
> 
> allow type1_t type2_t: class1 { perm1 };
> 
> allow role1_r role2_r;
> 
> bool bool1 true;
> 
> #gen_user(user1_u,, role1_r, s0, s0 - s0:c0.c23)
> user user1_u roles { role1_r } level s0 range s0 - s0:c0.c23;
> 
> sid sid1	user1_u:role1_r:type1_t:s0
> 
> 
> fs_use_xattr ext2 user1_u:role1_r:type1_t:s0;
> 
> genfscon proc /		user1_u:role1_r:type1_t:s0
> genfscon proc /1	user1_u:role2_r:type1_t:s0
> genfscon proc /2	user1_u:role1_r:type1_t:s0
> 
> nodecon ::1 FFFF:FFFF:FFFF:FFFF:: user1_u:role1_r:type1_t:s0
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
