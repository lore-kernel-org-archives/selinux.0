Subject: RE: [RFC & PATCH] inherited type definition.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Kaigai Kohei'" <kaigai@ak.jp.nec.com>,
   "'KaiGai Kohei'" <kaigai@kaigai.gr.jp>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>, selinux-dev@tresys.com
In-Reply-To: <200503172142.j2HLfm8R001729@gotham.columbia.tresys.com>
References: <200503172142.j2HLfm8R001729@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 18 Mar 2005 08:13:52 -0500
Message-Id: <1111151632.17131.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-03-17 at 16:41 -0500, Karl MacMillan wrote:
> Yes - and I have already complained about those in another email. I'll be happy
> to send a patch disallowing complement in allow rules if you would accept it :)

I'd be willing to consider it; I'm not sure it is being used in any
allow rules presently, just in assertions, and the type set exclusion
(-) notation seems better suited for allow rules.

> I disagree - macros allow this. Also, what we want, I think, is not a union of
> types but an abstract notion of access. Your earlier example of
> samba_http_content_t is better expressed through:
> 
> allow_samba_read(foo_t)
> allow_httpd_read(foo_t)
> 
> This is a direct statement of what we intend - allowing both samba and httpd to
> read files of type foo_t.

Not exactly.  What we want is a type that is accessible to httpd in the
same ways as httpd_content_t and that is accessible to samba in the same
ways as samba_share_t.  Whether or not that means read-only, read-write,
or whatever depends on the allow rules, tunables, booleans, etc for
httpd and samba.  So you would actually have to define macros expressing
the desired relationship between httpd and httpd_content_t and between
samba and samba_share_t, and use those macros for expressing those
relationships as well as for expressing the permissions for the new type
in order to ensure consistency.  Further, this wouldn't necessarily
cover any other references to these types elsewhere, direct or indirect.

> I would like to see how some real world problems would be solved with the
> extends syntax. I feel confident that every example could be expressed more
> clearly through a set of well-thought out macros.

This is a good test for the extends syntax; does it help solve real
problems any better than the use of macros.  A discussion on that issue
would be useful.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
