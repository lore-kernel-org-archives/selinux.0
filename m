Subject: Re: [RFC & PATCH] inherited type definition.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>, kaigai@ak.jp.nec.com
In-Reply-To: <4236CC03.5010104@kaigai.gr.jp>
References: <42346C17.3090301@kaigai.gr.jp>
	 <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>
	 <4235C937.3030404@kaigai.gr.jp>
	 <1110824712.21378.196.camel@moss-spartans.epoch.ncsc.mil>
	 <4236CC03.5010104@kaigai.gr.jp>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 09:42:31 -0500
Message-Id: <1110897751.25947.52.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-15 at 20:50 +0900, KaiGai Kohei wrote:
> Does 'unifying file type' means as follows ?
> e.g)
>  /var             ... var_t
>  /var/lib         ... var_lib_t extends var_t
>  /var/log         ... var_log_t extends var_t
>  /var/log/message ... var_log_message_t extends var_log_t
> Of course, such a usage is also possible.

I was thinking more of an example like:
type samba_httpd_content_t extends samba_share_t, httpd_sys_content_t;
in order to create a union type that can be accessed by both samba and
httpd.  See the earlier "multiple contexts" thread on this list.

> In user_t/user_ext_t example, user_ext_t is same as user_t without tiny difference.
> Thus, it is strange, if user_t process which has a permission to user_t does not
> have a same permission to user_ext_t.

But if user_ext_t has more permissions than user_t, then allowing user_t
to access user_ext_t in the same manner as it can access user_t means
that a user_t process can effectively gain control of those same
permissions too, just by transitioning to user_ext_t and running code in
it or by ptrace'ing or otherwise acting upon a separate user_ext_t
process.   Thus, you gain nothing from having a separate user_ext_t
type; there is no real protection/separation between user_t and
user_ext_t, and you might as well directly allow the permissions to
user_t.  Why create a new type if you gain no security benefit?

> Common part of user_t and user_ext_t should have a permission for each other, I think.
> The outbounds part of user_ext_t from user_t should not have a permission
> for each other, indeed.

I'm not sure how you distinguish the "common part" from the "outbounds
part".  Is this a notion of "private" and "public" portions of a type
definition?

> I want to reserve this matter once for a certain time.
> Because there is a problem as you notice, and I noticed the amount of modification
> with DENY implementation is so large.
> Sorry, I want to concentrate the discussion for TYPE ... EXTENDS first.

Ok, but we still need a way to make the "type...extends" feature
practically useful by itself.  As it stands, if you use it to define a
more privileged child than the parent, the parent can easily take
control of it and effectively gain those permissions too, so you might
as well directly allow the permissions to the parent and not create the
child at all.  The only use it has in its current form is to create
union types.

> In addition, it's possible not to decide a transition type/domain
> when a type has multiple parents. Should the number of parent
> types/domains be limited to one ?

No, I think the multiple inheritance is useful, e.g. for the union file
type case.  Possibly we need a way to mark which parent should be used
for inheriting type transitions.
  
-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
