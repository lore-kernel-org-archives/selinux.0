Subject: Re: [RFC & PATCH] inherited type definition.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <4237B950.2090604@ak.jp.nec.com>
References: <42346C17.3090301@kaigai.gr.jp>
	 <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>
	 <4235C937.3030404@kaigai.gr.jp>
	 <1110824712.21378.196.camel@moss-spartans.epoch.ncsc.mil>
	 <4236CC03.5010104@kaigai.gr.jp>
	 <1110897751.25947.52.camel@moss-spartans.epoch.ncsc.mil>
	 <4237B950.2090604@ak.jp.nec.com>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 09:05:28 -0500
Message-Id: <1110981928.4802.81.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-16 at 13:42 +0900, Kaigai Kohei wrote:
> I have an idea that ALLOW statement is added an new option
> For example:
>   ALLOW @user_t @user_t:process {ptrace};
>   ALLOW user_t @user_t:process {transition};
> 
> When '@' is added in front of the type name, this means source/target
> type is only user_t, not including user_ext_t and descendant.
> Above example is rolled out as follows:
>   ALLOW user_t user_t:process {ptrace};
>   ALLOW {user_t user_ext_t}:process {transition};
> 
> It restrains unlimited inheritance of permissions to child type/domain.
> Can this approach solve such a concern ?

Note that at least in this case, even the ability to transition prevents
any real separation between user_t and user_ext_t, because user_t and
user_ext_t can be entered by a shell, so with transition permission,
user_t can then run a shell in user_ext_t and perform arbitrary actions
with those permissions.

One obvious question is how @<attributename> would be interpreted;
offhand, I would expect it to prevent expansion of the descendants of
the individual types that have the attribute.  One concern with this
approach is that you have to explicitly mark types in order to prevent
expansion rather than having to explicitly mark types that you want to
expand, which seems prone to accidental expansion.  Note that we have to
consider not only rules that directly specify the type but rules that
may indirectly include the type via attribute or set complement (~).
Requiring explicit marking of types to allow expansion of descendants
would presumably require more work by someone who wants to extend a
type, but would avoid unintentional expansion.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
