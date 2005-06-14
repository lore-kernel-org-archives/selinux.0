Message-ID: <42AEEBBE.1070904@kaigai.gr.jp>
Date: Tue, 14 Jun 2005 23:37:50 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "SELinux(NSA)" <SELinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@tresys.com>
Subject: Interface between applications. (Re: [PATCH] independent with attribute
 declararion oeder for attachment)
References: <42AC23B6.8070304@kaigai.gr.jp> <1118671669.24565.59.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1118671669.24565.59.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------050807000208040300090506"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050807000208040300090506
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi, Stephen. Thanks for your comments.

I didn't know why did the disabled section exist in checkpolicy.
Excuse me, I have worked on SELinux for only one year and a few monthes.

>>Currently, we must declare an attribute before attachment to any types.
>>Thus, almost attributes are declared in attrib.te and attrib.te's merging
>>order for policy.conf is earlier than any *.te files.
> 
> 
> That was intentional; it ensured that one could easily review all
> defined attribute with some inline documentation (comments) in one
> location.  Of course, since that time, people have introduced some
> attribute definitions in other .te files, although primarily in macros.
> And some of the attribute definitions are domain-specific, e.g. the
> nscd_*_domain ones.

OK. I'll think it as a policy-writing guideline that an attribute must
be declared in application specific macros file when we want to declare
the application specific attribtue.
# Maybe, it should be append to one of FAQs.

> As an example, one could have a typo in an attribute name, which would
> no longer be caught by the compiler.  In that case, you wouldn't get the
> expected allow rules generated for the type.   You note that this is
> "harmless" because it simply means fewer permissions being allowed, but
> it could have unexpected results, e.g. lack of proper attributes on a
> domain or type could prevent the admin or init from killing a process or
> acting on a file (until the policy was fixed, of course).

Indeed, a typo may cause lack of crucial permissions.
I can print a message to avoid it, but checkpolicy can't distinguish
any typoes from intentionally ignored attributes.
So, please leave a prior patch for a while. orz

>>BTW, I noticed a problem that any CGI program works in httpd_sys_script_t can not
>>connect to PostgreSQL via UNIX domain socket. This patch resolve it.
>>Since I think configuration for apache is done in postgresql.te is strange,
>>I used postgresql_connectable_a as a interface for PostgreSQL client application.
> 
> 
> I think that the reference policy is addressing this kind of issue by
> exporting explicit macro interfaces for every case where you need to
> export access to a type defined in one module to another module.

The attached macro is an example of explicit interfaces by macro.
I think deep dependency relationship between two or more applications
are so complication and easy to cause human error.
I think we should disestablish policies described directly between some
applications, and define an interface by macros or attributes on intead.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--------------050807000208040300090506
Content-Type: text/plain;
 name="pgsql-interface.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="pgsql-interface.patch"

ZGlmZiAtck5VMyBwb2xpY3ktMS4yMy4xNy9kb21haW5zL3Byb2dyYW0vdW51c2VkL2FwYWNo
ZS50ZSBwb2xpY3ktMS4yMy4xNy5rZy9kb21haW5zL3Byb2dyYW0vdW51c2VkL2FwYWNoZS50
ZQotLS0gcG9saWN5LTEuMjMuMTcvZG9tYWlucy9wcm9ncmFtL3VudXNlZC9hcGFjaGUudGUJ
MjAwNS0wNS0yNSAxMToyODoyOC4wMDAwMDAwMDAgLTA0MDAKKysrIHBvbGljeS0xLjIzLjE3
LmtnL2RvbWFpbnMvcHJvZ3JhbS91bnVzZWQvYXBhY2hlLnRlCTIwMDUtMDYtMTQgMDk6NDE6
NDkuMDAwMDAwMDAwIC0wNDAwCkBAIC0yMTksNiArMjE5LDExIEBACiAjIENyZWF0aW9uIG9m
IGxvY2sgZmlsZXMgZm9yIGFwYWNoZTIKIGxvY2tfZG9tYWluKGh0dHBkKQogCisjIGNvbm5l
Y3QgdG8gUG9zdGdyZVNRTAorcG9zdGdyZXNxbF9jb25uZWN0YWJsZV9kb21haW4oaHR0cGRf
dCkKK3Bvc3RncmVzcWxfY29ubmVjdGFibGVfZG9tYWluKGh0dHBkX3BocF90KQorcG9zdGdy
ZXNxbF9jb25uZWN0YWJsZV9kb21haW4oaHR0cGRfc3lzX3NjcmlwdF90KQorCiAjIGNvbm5l
Y3QgdG8gbXlzcWwKIGlmZGVmKGBteXNxbGQudGUnLCBgCiBjYW5fdW5peF9jb25uZWN0KGh0
dHBkX3BocF90LCBteXNxbGRfdCkKZGlmZiAtck5VMyBwb2xpY3ktMS4yMy4xNy9kb21haW5z
L3Byb2dyYW0vdW51c2VkL3Bvc3RncmVzcWwudGUgcG9saWN5LTEuMjMuMTcua2cvZG9tYWlu
cy9wcm9ncmFtL3VudXNlZC9wb3N0Z3Jlc3FsLnRlCi0tLSBwb2xpY3ktMS4yMy4xNy9kb21h
aW5zL3Byb2dyYW0vdW51c2VkL3Bvc3RncmVzcWwudGUJMjAwNS0wNS0yNSAxMToyODoyOC4w
MDAwMDAwMDAgLTA0MDAKKysrIHBvbGljeS0xLjIzLjE3LmtnL2RvbWFpbnMvcHJvZ3JhbS91
bnVzZWQvcG9zdGdyZXNxbC50ZQkyMDA1LTA2LTE0IDA5OjQxOjM2LjAwMDAwMDAwMCAtMDQw
MApAQCAtMTEzLDEzICsxMTMsNiBAQAogYWxsb3cgcG9zdGdyZXNxbF90IG1haWxfc3Bvb2xf
dDpkaXIgeyBzZWFyY2ggfTsKIGxvY2tfZG9tYWluKHBvc3RncmVzcWwpCiBjYW5fZXhlYyhw
b3N0Z3Jlc3FsX3QsIHsgc2hlbGxfZXhlY190IGJpbl90IHBvc3RncmVzcWxfZXhlY190IGxz
X2V4ZWNfdCB9ICkKLWlmZGVmKGBhcGFjaGUudGUnLCBgCi0jIAotIyBBbGxvdyBodHRwZCB0
byB3b3JrIHdpdGggcG9zdGdyZXNxbAotIwotYWxsb3cgaHR0cGRfdCBwb3N0Z3Jlc3FsX3Rt
cF90OnNvY2tfZmlsZSByd19maWxlX3Blcm1zOwotY2FuX3VuaXhfY29ubmVjdChodHRwZF90
LCBwb3N0Z3Jlc3FsX3QpCi0nKQogCiBpZmRlZihgZGlzdHJvX2dlbnRvbycsIGAKICMgInN1
IC0gcG9zdGdyZXMgLi4uIiBpcyBjYWxsZWQgZnJvbSBpbml0cmNfdApkaWZmIC1yTlUzIHBv
bGljeS0xLjIzLjE3L21hY3Jvcy9wcm9ncmFtL3Bvc3RncmVzcWxfbWFjcm9zLnRlIHBvbGlj
eS0xLjIzLjE3LmtnL21hY3Jvcy9wcm9ncmFtL3Bvc3RncmVzcWxfbWFjcm9zLnRlCi0tLSBw
b2xpY3ktMS4yMy4xNy9tYWNyb3MvcHJvZ3JhbS9wb3N0Z3Jlc3FsX21hY3Jvcy50ZQkxOTY5
LTEyLTMxIDE5OjAwOjAwLjAwMDAwMDAwMCAtMDUwMAorKysgcG9saWN5LTEuMjMuMTcua2cv
bWFjcm9zL3Byb2dyYW0vcG9zdGdyZXNxbF9tYWNyb3MudGUJMjAwNS0wNi0xNCAwOTo0MTow
OC4wMDAwMDAwMDAgLTA0MDAKQEAgLTAsMCArMSwxNiBAQAorIyBNYWNyb3MgZm9yIFBvc3Rn
cmVTUUwKKworIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCisjIEFuIEludGVyZmFjZSBmb3IgYSBkb21haW4gY2FuIGNvbm5lY3QgdG8g
UG9zdGdyZVNRTAorIyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHZpYSBVTklYIGRv
bWFpbiBzb2NrZXQpCisjIHVzYWdlOiBwb3N0Z3Jlc3FsX2Nvbm5lY3RhYmxlX2RvbWFpbihE
T01BSU4pCisKK2RlZmluZShgcG9zdGdyZXNxbF9jb25uZWN0YWJsZV9kb21haW4nLGAKK2lm
ZGVmKGBwb3N0Z3Jlc3FsLnRlJyxgCithbGxvdyAkMSB0bXBfdDpkaXIge3NlYXJjaCBnZXRh
dHRyfTsKK2FsbG93ICQxIHBvc3RncmVzcWxfdG1wX3Q6c29ja19maWxlIHJ3X2ZpbGVfcGVy
bXM7CitjYW5fdW5peF9jb25uZWN0KCQxLCBwb3N0Z3Jlc3FsX3QpCisKKycsYCcpIGRubCBU
aGUgRW5kIE9mIHBvc3RncmVzcWwudGUKKycpIGRubCBUaGUgRW5kIE9mIHBvc3RncmVzcWxf
Y29ubmVjdGFibGVfZG9tYWluCisK
--------------050807000208040300090506--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
