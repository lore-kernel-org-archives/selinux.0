Date: Thu, 24 Mar 2005 22:27:54 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Karl MacMillan <kmacmillan@tresys.com>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Kaigai Kohei'" <kaigai@ak.jp.nec.com>,
   "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
Subject: Re: [RFC & PATCH] inherited type definition.
Message-ID: <20050324222754.GF8553@lkcl.net>
References: <20050322001439.GB8444@lkcl.net> <200503221353.j2MDrT8R010539@gotham.columbia.tresys.com> <20050324110438.GC13372@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050324110438.GC13372@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Mar 24, 2005 at 11:04:38AM +0000, Luke Kenneth Casson Leighton wrote:
> On Tue, Mar 22, 2005 at 08:53:28AM -0500, Karl MacMillan wrote:
> 
> > > -----Original Message-----
> > > From: Luke Kenneth Casson Leighton [mailto:lkcl@lkcl.net] 
> > > Sent: Monday, March 21, 2005 7:15 PM
> > <snip>
> > > > 
> > > > First, you missed the switch to the @ being required in order to 
> > > > inherit permissions through extends - making that syntax, 
> > > as far as I 
> > > > can tell, the same as what you are suggesting.
> > > 
> > >  i understood it to be the other way round - that the @ is 
> > > required to  _not_ allow a permission to be inherited through extends.
> > > 
> > > 
> > 
> > Like I said - it switched part way through the discussion.
>  
>  okay, i must have missed that.
> 
>  ... but, after a couple of days' thought, i don't believe
>  that what i am suggesting is anything anywhere near the @
>  syntax, and it is in fact in response to some comments by
>  stephen [where he mentioned that it would be better to split
>  domains up further using macros than it would be to use
>  this inheritance system with some modifications suggested
>  by me, so off i went to think of some better modifications -
>  clarification below]
> 
> 
> > > > Next, my objection is that there is only one subset of 
> > > permissions - 
> > > > there is no way to have user_ftp_t inherit one set of 
> > > permissions from 
> > > > user_t and user_httpd_t inherit another set of permissions from 
> > > > user_t.
> > > 
> > >  note syntax in example [copied from above]:
> > > 
> > > > >  some_macro (`
> > > > > 	 inheritable($1_ftp_t, parent_class2_t) {
> > >                      ^^^^^^^^  ^^^^^^^^^^^^^^^
> > > > > 
> > > > > 		allow ....;
> > > > > 
> > > > > 	 }
> > > 
> > >  so, to link this with your examples above, let's express this in
> > >  "inheritable() { ... }" syntax:
> > > 
> > > 	some_macro (`
> > > 		inheritable($1_ftp_t, $1_httpd_t) {
> > > 			allow ....;
> > > 		}
> > > 		inheritable($1_ftp_t) {
> > > 			allow ....;
> > > 		}
> > > 		inheritable($1_httpd_t) {
> > > 			allow ....;
> > > 		}
> > > 		allow ....;
> > > 	}
> > > 
> > > 	')
> > > 
> > >  make sense?
> > > 
> > 
> > I guess I don't understand how your proposed syntax works. What does it mean
> > when there are two types?
 
 sorry - i mis-read your question.

 when there are two types, it means: when you use
 some_macro(user) and you then declare type user_httpd_t it
 gets all the stuff where user_httpd_t occurs in _any_ inheritable()
 wrap and when you declare user_ftp_t, likewise.

 		inheritable($1_ftp_t, $1_httpd_t) {
 			allow A;
		}
		inheritable($1_ftp_t) {
			allow B;
		}
		inheritable($1_httpd_t) {
			allow C;
		}
		allow D;

 therefore:

	user_httpd_t comprises allow A and allow C

	user_ftp_t comprises allow A and allow B,

	user_t comprises allow A B C _and_ D.

 because D is not inside an inheritable() wrap, it never gets
 inherited by "extends" syntax.

 hence, this could be viewed as a simplification of having to
 split some_macro into ... mmm... _four (!) separate sub-macros
 one each covering the permissions allow A, allow B, allow C
 and allow D:

	 some_macro ('
	     some_macro_A($1) # representing inheritable A group above
	     some_macro_B($1) # ... etc.
	     some_macro_C($1)
	     some_macro_D($1)
	     ')

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
