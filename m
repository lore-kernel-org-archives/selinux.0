Message-Id: <200503182228.j2IMSv8R009703@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'Kaigai Kohei'" <kaigai@ak.jp.nec.com>,
   "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, <selinux-dev@tresys.com>
Subject: RE: [RFC & PATCH] inherited type definition.
Date: Fri, 18 Mar 2005 17:28:57 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1111151632.17131.36.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> Sent: Friday, March 18, 2005 8:14 AM
> To: Karl MacMillan
> Cc: 'Kaigai Kohei'; 'KaiGai Kohei'; 'SELinux Mail List'; 
> selinux-dev@tresys.com
> Subject: RE: [RFC & PATCH] inherited type definition.
> 
> On Thu, 2005-03-17 at 16:41 -0500, Karl MacMillan wrote:
> > Yes - and I have already complained about those in another 
> email. I'll 
> > be happy to send a patch disallowing complement in allow 
> rules if you 
> > would accept it :)
> 
> I'd be willing to consider it; I'm not sure it is being used 
> in any allow rules presently, just in assertions, and the 
> type set exclusion
> (-) notation seems better suited for allow rules.
> 

Ok - I'll send you a patch.

> > I disagree - macros allow this. Also, what we want, I 
> think, is not a 
> > union of types but an abstract notion of access. Your 
> earlier example 
> > of samba_http_content_t is better expressed through:
> > 
> > allow_samba_read(foo_t)
> > allow_httpd_read(foo_t)
> > 
> > This is a direct statement of what we intend - allowing 
> both samba and 
> > httpd to read files of type foo_t.
> 
> Not exactly.  What we want is a type that is accessible to 
> httpd in the same ways as httpd_content_t and that is 
> accessible to samba in the same ways as samba_share_t.  
> Whether or not that means read-only, read-write, or whatever 
> depends on the allow rules, tunables, booleans, etc for httpd 
> and samba.

I am saying, that if almost all access - including, for example, the access
between httpd and httpd_content_t - is expressed as a set of well-defined
macros, then this becomes easy. That means that a policy author can look at the
macros defining access between httpd and httpd_content_t and samba and
samba_share_t and then reuse those to create samba_httpd_content_t.

Also, the more I think about it the more convinced I am that the show-stopper
limitation of the extends syntax is that it allows only one subset of access.
The discussion so far has exposed that we don't usually want to grant all of the
access to httpd_content_t and samba_share_t to samba_httpd_content_t, but the @
syntax allows us to form only one subset. What if we want to create
ftp_httpd_content_t that has a different subset of the access to httpd_content_t
than is useful for samba_httpd_content_t? What if we want to give httpd the kind
of read access it has to httpd_content_t to foo_t and the kind of write access
it has to httpd_content_t to bar_t? With the extends syntax we are limited to
just one subset. The macros allow us to form arbitrary subsets of the access and
it apply to other types at will.

>  So you would actually have to define macros 
> expressing the desired relationship between httpd and 
> httpd_content_t and between samba and samba_share_t, and use 
> those macros for expressing those relationships as well as 
> for expressing the permissions for the new type in order to 
> ensure consistency.

Yes - exactly. I think that this has far-reaching benefits beyond this one use
case as well, including readability and documentation.

>  Further, this wouldn't necessarily cover 
> any other references to these types elsewhere, direct or indirect.
> 

I think that this is a benefit - it makes the granting of access intentional and
explicit.

> > I would like to see how some real world problems would be 
> solved with 
> > the extends syntax. I feel confident that every example could be 
> > expressed more clearly through a set of well-thought out macros.
> 
> This is a good test for the extends syntax; does it help 
> solve real problems any better than the use of macros.  A 
> discussion on that issue would be useful.
> 

I agree, but I want to make certain that it is clear that I am not suggesting
that the current use of macros is an appropriate alternative. Also, we have
started a worked example of the macro abstraction that I am suggesting.
Unfortunately, it is a time-consuming task, but we have committed significant
resources to this as part of a larger effort to create a new security first
policy. As soon as possible, I'll start posting examples of how this is
progressing. My intuition says that this is the solution to a wide range of
policy writing difficulties and I am eager to have it tested and vetted.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134 

> --
> Stephen Smalley <sds@tycho.nsa.gov>
> National Security Agency
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
