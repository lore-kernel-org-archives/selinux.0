Message-Id: <200503221353.j2MDrT8R010539@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>,
   "'Kaigai Kohei'" <kaigai@ak.jp.nec.com>,
   "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, <selinux-dev@tresys.com>
Subject: RE: [RFC & PATCH] inherited type definition.
Date: Tue, 22 Mar 2005 08:53:28 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050322001439.GB8444@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Luke Kenneth Casson Leighton [mailto:lkcl@lkcl.net] 
> Sent: Monday, March 21, 2005 7:15 PM
<snip>
> > 
> > First, you missed the switch to the @ being required in order to 
> > inherit permissions through extends - making that syntax, 
> as far as I 
> > can tell, the same as what you are suggesting.
> 
>  i understood it to be the other way round - that the @ is 
> required to  _not_ allow a permission to be inherited through extends.
> 
> 

Like I said - it switched part way through the discussion.

> 
> > Next, my objection is that there is only one subset of 
> permissions - 
> > there is no way to have user_ftp_t inherit one set of 
> permissions from 
> > user_t and user_httpd_t inherit another set of permissions from 
> > user_t.
> 
>  note syntax in example [copied from above]:
> 
> > >  some_macro (`
> > > 	 inheritable($1_ftp_t, parent_class2_t) {
>                      ^^^^^^^^  ^^^^^^^^^^^^^^^
> > > 
> > > 		allow ....;
> > > 
> > > 	 }
> 
>  so, to link this with your examples above, let's express this in
>  "inheritable() { ... }" syntax:
> 
> 	some_macro (`
> 		inheritable($1_ftp_t, $1_httpd_t) {
> 			allow ....;
> 		}
> 		inheritable($1_ftp_t) {
> 			allow ....;
> 		}
> 		inheritable($1_httpd_t) {
> 			allow ....;
> 		}
> 		allow ....;
> 	}
> 
> 	')
> 
>  make sense?
> 

I guess I don't understand how your proposed syntax works. What does it mean
when there are two types?

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134 

>  i believe that this covers the objection that you raise:
>  clarification from you that it does, greatly appreciated.
> 
>  if you _really_ wanted to use the @ syntax (and @ means  
> "inherit is okay" rather than "inherit isn't possible"), how  
> about extending the @ syntax to also make it possible to do  
> @{$1_ftp_t, $1_httpd_t} similar to above?
> 
>  l.
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
