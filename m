Subject: Re: [PATCH] independent with attribute declararion oeder for
	attachment
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: "SELinux(NSA)" <SELinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <42AC23B6.8070304@kaigai.gr.jp>
References: <42AC23B6.8070304@kaigai.gr.jp>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 10:07:49 -0400
Message-Id: <1118671669.24565.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-06-12 at 20:59 +0900, KaiGai Kohei wrote:
> When I read the source code of checkpolicy, I noticed an interesting
> functionality is commented out by #if 0 - #endif.
> That is automatically attributes definition on type declaration statements.
> I can look the author intended to try to attach attributes with any types
> before this attributes declared.

That is a legacy of when attributes didn't need to be declared at all.
Originally, attributes were implicitly declared upon first use in a type
declaration.  Later, we introduced and required explicit declaration of
attributes.  The disabled code was an easy way for people to quickly
generate a list of attributes that lacked declarations when converting
their policies.  As everyone has since converted their policies to
explicit declaration of attributes, it is no longer necessary.

> Currently, we must declare an attribute before attachment to any types.
> Thus, almost attributes are declared in attrib.te and attrib.te's merging
> order for policy.conf is earlier than any *.te files.

That was intentional; it ensured that one could easily review all
defined attribute with some inline documentation (comments) in one
location.  Of course, since that time, people have introduced some
attribute definitions in other .te files, although primarily in macros.
And some of the attribute definitions are domain-specific, e.g. the
nscd_*_domain ones.

> Of cause, existing semantics is not changed without an exception.
> When we declare a type with undeclared attributes and thoes attributes
> are not declared untill the last, the attached attributes are ignored.
> There are two reason. (1) It's harmless since any TE statements with
> undeclared attributes are restricted. (2) We should not worry about
> the dependence of type and attribute, so this feature make reduce
> 'ifdef/ifndef' macros.
> Currently, checkpolicy will abort when we declare a type with undeclared
> attribtes. Is this difference so fatal ?

As an example, one could have a typo in an attribute name, which would
no longer be caught by the compiler.  In that case, you wouldn't get the
expected allow rules generated for the type.   You note that this is
"harmless" because it simply means fewer permissions being allowed, but
it could have unexpected results, e.g. lack of proper attributes on a
domain or type could prevent the admin or init from killing a process or
acting on a file (until the policy was fixed, of course).

> The following four patches are sample of the out of order of attribute declaration.
> - apache.te-1.23.17-3.attribute.patch
> - ftpd.te-1.23.17-3.attribute.patch
> - mysqld.te-1.23.17-3.attribute.patch
> - postgresql.te-1.23.17-3.attribute.patch
> 
> BTW, I noticed a problem that any CGI program works in httpd_sys_script_t can not
> connect to PostgreSQL via UNIX domain socket. This patch resolve it.
> Since I think configuration for apache is done in postgresql.te is strange,
> I used postgresql_connectable_a as a interface for PostgreSQL client application.

I think that the reference policy is addressing this kind of issue by
exporting explicit macro interfaces for every case where you need to
export access to a type defined in one module to another module.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
