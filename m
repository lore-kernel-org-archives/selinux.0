Message-ID: <42394ECA.7010204@ak.jp.nec.com>
Date: Thu, 17 Mar 2005 18:32:58 +0900
From: Kaigai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC & PATCH] inherited type definition.
References: <42346C17.3090301@kaigai.gr.jp>	 <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>	 <4235C937.3030404@kaigai.gr.jp>	 <1110824712.21378.196.camel@moss-spartans.epoch.ncsc.mil>	 <4236CC03.5010104@kaigai.gr.jp>	 <1110897751.25947.52.camel@moss-spartans.epoch.ncsc.mil>	 <4237B950.2090604@ak.jp.nec.com> <1110981928.4802.81.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1110981928.4802.81.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

>>I have an idea that ALLOW statement is added an new option
>>For example:
>>  ALLOW @user_t @user_t:process {ptrace};
>>  ALLOW user_t @user_t:process {transition};
>>
>>When '@' is added in front of the type name, this means source/target
>>type is only user_t, not including user_ext_t and descendant.
>>Above example is rolled out as follows:
>>  ALLOW user_t user_t:process {ptrace};
>>  ALLOW {user_t user_ext_t}:process {transition};
>>
>>It restrains unlimited inheritance of permissions to child type/domain.
>>Can this approach solve such a concern ?
>
>
> Note that at least in this case, even the ability to transition prevents
> any real separation between user_t and user_ext_t, because user_t and
> user_ext_t can be entered by a shell, so with transition permission,
> user_t can then run a shell in user_ext_t and perform arbitrary actions
> with those permissions.

I agree, two-way transition permissions make the separation between each domains
meaningless. The '@' should be append in front of typenames as a general rule,
when we will attach ptrace, transition and dyntransition permissions.

I think can_ptrace() and domain_trans() macros should be modify to avoid
such a vague border of domain. Other grants of such permissions are similar.


> One obvious question is how @<attributename> would be interpreted;
> offhand, I would expect it to prevent expansion of the descendants of
> the individual types that have the attribute.

I intend that '@'<type/attribute name> is interpreted as if those
type/attribute is interpreted on current version checkpolicy(1.22).
In other word, '@'<typename> is merely recognized as <typename>,
any descendants are not included. '@'<attribute> is rolled out
some child types attached this attribute directly, not include
any indirect descendants.

e.g.
attribute attr;
type X;
type Y extends attr;
type Z extends Y;

"allow @attr foo:XXX XXX;" means "allow Y foo:XXX XXX;", Z is not included.
"allow @X foo:XXX XXX;" means "X foo:XXX XXX;", Y and Z is not included.

If you remove '@' from above statements, this action is same as current checkpolicy works.


> One concern with this
> approach is that you have to explicitly mark types in order to prevent
> expansion rather than having to explicitly mark types that you want to
> expand, which seems prone to accidental expansion.

To decide which is it preferable is a difficult issue.
My preference is that explicitly mark types means deny of expand, and
any permissions without above 3-operations should be expandable in default.

Effective use of existing software assets is reason.
For example, samba_httpd_content_t is a type extends samba_share_t
and httpd_sys_content_t.  When we try to use the union filetype
"samba_httpd_content_t", we must fix the allow statements of "samba_share_t"
and "httpd_sys_content_t" if an allow statement without '@' means
no-expandable permission grant.


> Note that we have to
> consider not only rules that directly specify the type but rules that
> may indirectly include the type via attribute or set complement (~).
> Requiring explicit marking of types to allow expansion of descendants
> would presumably require more work by someone who wants to extend a
> type, but would avoid unintentional expansion.

OK, I'll fix up the latest patch with your notion.
Please wait for a while.

Thanks,
--
DO NOTHING IS THE WORST POLICY.
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
