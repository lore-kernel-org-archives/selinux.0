Message-ID: <4237B950.2090604@ak.jp.nec.com>
Date: Wed, 16 Mar 2005 13:42:56 +0900
From: Kaigai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC & PATCH] inherited type definition.
References: <42346C17.3090301@kaigai.gr.jp>	 <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>	 <4235C937.3030404@kaigai.gr.jp>	 <1110824712.21378.196.camel@moss-spartans.epoch.ncsc.mil>	 <4236CC03.5010104@kaigai.gr.jp> <1110897751.25947.52.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1110897751.25947.52.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen, Thanks for your comments ?

> I was thinking more of an example like:
> type samba_httpd_content_t extends samba_share_t, httpd_sys_content_t;
> in order to create a union type that can be accessed by both samba and
> httpd.  See the earlier "multiple contexts" thread on this list.

Indeed, this is interresting usage.
I'll try to re-read above thread earnestly.


>>In user_t/user_ext_t example, user_ext_t is same as user_t without tiny difference.
>>Thus, it is strange, if user_t process which has a permission to user_t does not
>>have a same permission to user_ext_t.
>
> But if user_ext_t has more permissions than user_t, then allowing user_t
> to access user_ext_t in the same manner as it can access user_t means
> that a user_t process can effectively gain control of those same
> permissions too, just by transitioning to user_ext_t and running code in
> it or by ptrace'ing or otherwise acting upon a separate user_ext_t
> process.   Thus, you gain nothing from having a separate user_ext_t
> type; there is no real protection/separation between user_t and
> user_ext_t, and you might as well directly allow the permissions to
> user_t.  Why create a new type if you gain no security benefit?

Indeed, a user_t process can take permissions of a user_ext_t process
through ptrace. It was blid spot for me.
I think, this has the cause in inheriting all of parent-permissions
unconditionally, not selective. Thus, there is no difference in between
user_ext_t and user_t essentially.
If we can resolve this matter, what we can define domain with EXTENDS
statement has worthiness in that we can use existing correct type as
a template to define a new type/domain.

I have an idea that ALLOW statement is added an new option
For example:
  ALLOW @user_t @user_t:process {ptrace};
  ALLOW user_t @user_t:process {transition};

When '@' is added in front of the type name, this means source/target
type is only user_t, not including user_ext_t and descendant.
Above example is rolled out as follows:
  ALLOW user_t user_t:process {ptrace};
  ALLOW {user_t user_ext_t}:process {transition};

It restrains unlimited inheritance of permissions to child type/domain.
Can this approach solve such a concern ?


>>In addition, it's possible not to decide a transition type/domain
>>when a type has multiple parents. Should the number of parent
>>types/domains be limited to one ?
>
> No, I think the multiple inheritance is useful, e.g. for the union file
> type case.  Possibly we need a way to mark which parent should be used
> for inheriting type transitions.

I see. The multiple inheritance is indeed useful and interresting, I noticed.
So, does above '@' proposal make such a marking possible ?

Thanks.
--
DO NOTHING IS THE WORST POLICY.
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
