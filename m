Date: Tue, 22 Mar 2005 00:14:39 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Kaigai Kohei'" <kaigai@ak.jp.nec.com>,
   "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
Subject: Re: [RFC & PATCH] inherited type definition.
Message-ID: <20050322001439.GB8444@lkcl.net>
References: <20050321001725.GE14130@lkcl.net> <200503211339.j2LDdm8R000720@gotham.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200503211339.j2LDdm8R000720@gotham.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 21, 2005 at 08:39:48AM -0500, Karl MacMillan wrote:
> > -----Original Message-----
> > From: Luke Kenneth Casson Leighton [mailto:lkcl@lkcl.net] 
> > Sent: Sunday, March 20, 2005 7:17 PM
> > To: Karl MacMillan
> > Cc: 'Stephen Smalley'; 'Kaigai Kohei'; 'KaiGai Kohei'; 
> > 'SELinux Mail List'; selinux-dev@tresys.com
> > Subject: Re: [RFC & PATCH] inherited type definition.
> > 
> > On Sun, Mar 20, 2005 at 06:20:09PM -0500, Karl MacMillan wrote:
> > 
> > > > On Fri, Mar 18, 2005 at 05:28:57PM -0500, Karl MacMillan wrote:
> > > > > Also, the more I think about it the more convinced I am 
> > that the 
> > > > > show-stopper limitation of the extends syntax is that it
> > > > allows only one subset of access.
> > > > 
> > > >  there is nothing to stop you using an extends inside a macro:
> > > > 
> > > > 	 $1_t EXTENDS $1_ftp_t
> > > > 
> > > >  l.
> > > > 
> > > 
> > > How does this address the problem - only one subset of access from 
> > > $1_ftp_t can be marked with the @ syntax.
> >  
> >  not that my opinion particularly matters or is authoritative 
> >  in any way, but i don't like the @ syntax - so i don't see 
> > it  as a problem, because i would never implement the @ 
> > syntax,  not in a million years.
> > 
> >  the @ syntax goes against the "mandatory" grain in "MAC".
> > 
> >  putting a wrapper (curly braces, brackets syntax, whatever 
> > is  most appropriate) around those sections which _are_ 
> > allowed  to be inherited is more along the MAC conceptual lines.
> > 
> >  you could then potentially have an additional qualifier in 
> > your curly  braces wrapper which specifies _which_ children 
> > may "extend" a class  (remembering also to allow $1s etc to 
> > be substituted into that)
> > 
> >  e.g.
> >  
> >  some_macro (`
> > 	 inheritable($1_ftp_t, parent_class2_t) {
> > 
> > 		allow ....;
> > 
> > 	 }
> > 	 allow ...;
> >  ')
> >  
> > 
> >  then do this:
> > 
> > 	 some_macro(user)
> > 	 user_ftp_t EXTENDS user_t;
> >  
> >  despite there being several things declared by the  
> > some_macro(user), only SOME of those - those that are  
> > EXPLICITLY ALLOWED TO BE INHERITED - permissions are 
> > duplicated  into the child, user_ftp_t.
> >
> 
> First, you missed the switch to the @ being required in order to inherit
> permissions through extends - making that syntax, as far as I can tell, the same
> as what you are suggesting. 

 i understood it to be the other way round - that the @ is required to
 _not_ allow a permission to be inherited through extends.



> Next, my objection is that there is only one subset
> of permissions - there is no way to have user_ftp_t inherit one set of
> permissions from user_t and user_httpd_t inherit another set of permissions from
> user_t. 

 note syntax in example [copied from above]:

> >  some_macro (`
> > 	 inheritable($1_ftp_t, parent_class2_t) {
                     ^^^^^^^^  ^^^^^^^^^^^^^^^
> > 
> > 		allow ....;
> > 
> > 	 }

 so, to link this with your examples above, let's express this in
 "inheritable() { ... }" syntax:

	some_macro (`
		inheritable($1_ftp_t, $1_httpd_t) {
			allow ....;
		}
		inheritable($1_ftp_t) {
			allow ....;
		}
		inheritable($1_httpd_t) {
			allow ....;
		}
		allow ....;
	}

	')

 make sense?

 i believe that this covers the objection that you raise:
 clarification from you that it does, greatly appreciated.

 if you _really_ wanted to use the @ syntax (and @ means
 "inherit is okay" rather than "inherit isn't possible"), how
 about extending the @ syntax to also make it possible to do
 @{$1_ftp_t, $1_httpd_t} similar to above?

 l.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
