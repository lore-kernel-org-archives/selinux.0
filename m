Date: Thu, 24 Mar 2005 11:04:38 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Kaigai Kohei'" <kaigai@ak.jp.nec.com>,
   "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
Subject: Re: [RFC & PATCH] inherited type definition.
Message-ID: <20050324110438.GC13372@lkcl.net>
References: <20050322001439.GB8444@lkcl.net> <200503221353.j2MDrT8R010539@gotham.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200503221353.j2MDrT8R010539@gotham.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Mar 22, 2005 at 08:53:28AM -0500, Karl MacMillan wrote:

> > -----Original Message-----
> > From: Luke Kenneth Casson Leighton [mailto:lkcl@lkcl.net] 
> > Sent: Monday, March 21, 2005 7:15 PM
> <snip>
> > > 
> > > First, you missed the switch to the @ being required in order to 
> > > inherit permissions through extends - making that syntax, 
> > as far as I 
> > > can tell, the same as what you are suggesting.
> > 
> >  i understood it to be the other way round - that the @ is 
> > required to  _not_ allow a permission to be inherited through extends.
> > 
> > 
> 
> Like I said - it switched part way through the discussion.
 
 okay, i must have missed that.

 ... but, after a couple of days' thought, i don't believe
 that what i am suggesting is anything anywhere near the @
 syntax, and it is in fact in response to some comments by
 stephen [where he mentioned that it would be better to split
 domains up further using macros than it would be to use
 this inheritance system with some modifications suggested
 by me, so off i went to think of some better modifications -
 clarification below]


> > > Next, my objection is that there is only one subset of 
> > permissions - 
> > > there is no way to have user_ftp_t inherit one set of 
> > permissions from 
> > > user_t and user_httpd_t inherit another set of permissions from 
> > > user_t.
> > 
> >  note syntax in example [copied from above]:
> > 
> > > >  some_macro (`
> > > > 	 inheritable($1_ftp_t, parent_class2_t) {
> >                      ^^^^^^^^  ^^^^^^^^^^^^^^^
> > > > 
> > > > 		allow ....;
> > > > 
> > > > 	 }
> > 
> >  so, to link this with your examples above, let's express this in
> >  "inheritable() { ... }" syntax:
> > 
> > 	some_macro (`
> > 		inheritable($1_ftp_t, $1_httpd_t) {
> > 			allow ....;
> > 		}
> > 		inheritable($1_ftp_t) {
> > 			allow ....;
> > 		}
> > 		inheritable($1_httpd_t) {
> > 			allow ....;
> > 		}
> > 		allow ....;
> > 	}
> > 
> > 	')
> > 
> >  make sense?
> > 
> 
> I guess I don't understand how your proposed syntax works. What does it mean
> when there are two types?

 that one set of permissions is inheritable via "extends"
 and other sets are not.

 the reason why i am suggesting this syntax is because stephen said that
 it would not be okay to split macros down into sub-macro in order to
 inherit/extend "subsets" of a domain.

 e.g. if you do user_ftp_t extends user_t where you have already
 declared some_macro(user) then it ends up inheriting ONLY those
 blocks of permissions containing "user_ftp_t" inside "inheritable { }" 
 braces.


 ... so, after some thought, however, i believe we may be talking
 about two separate issues.

 the "inheritable" syntax i suggest above is a way to inherit SUBSETS of
 a domain, without disrupting the existing policy source too much (which
 i interpreted stephen's comments to mean)

 so, correct me if i am wrong, but the "@" syntax doesn't actually STOP
 something from being "extended", it just means that a different domain
 is inherited, yes?

 and your original question was: when you use A "extends" B and C
 "extends" B, and B contains "@"s, how do you potentially make A 
 ignore the "@" but C _not_ ignore the "@"?

 if that was your original question, then that's easy: you use a syntax
 @(A) or @(A,Z,Y,X)


 I BELIEVE that the "inheritable" syntax above could be added as an
 enhancement to the existing proposed "extends" scheme, WITHOUT
 disrupting or having anything to do with the "@" syntax.

 the only question is: do you _want_ to use "inheritable" instead of
 splitting macros down into sub-macros to achieve the same end-result?

 which is simpler?

 which is easier to understand?
 
 does the "inheritable" syntax cause any potential disruption/confusion
 (beyond what the @ syntax already does if you ask me!!!!)

 l.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
