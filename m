Subject: Re: user_trans/user_trans_boolean macro
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <1110692016.29852.77.camel@cobra.ivg2.net>
References: <1110692016.29852.77.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 07:45:53 -0500
Message-Id: <1110804353.21378.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-03-13 at 00:33 -0500, Ivan Gyurdiev wrote:
> Is there anything wrong with this patch?
> 
> It continues to remove stuff from x_client_domain.
> This time the type declaration is removed, along with 
> the transboolean stuff. The transition stuff is placed
> in new macros called user_trans and user_trans_boolean.

Why user_trans?  Nothing is specific to users or even user domains.

> Points of interest:
> 
> - can_exec($1_$2_t, $2_exec_t)
> I don't quite understand what this does, but I remember
> domains needed it. It was also in the x_client rules.

This seems wrong to me; domain_trans already allows rx_file_perms
between the new domain and the executable, so the only further
permission being added by this macro is execute_no_trans, and that is
wrong unless the program re-executes itself at times and wants to stay
in the same domain upon such re-execution.

in_user_role() is typically what is used for the role statement
> 
> - nscd_client_domain was removed for mplayer and mozilla.
> I didn't see any problems.

Are you running nscd?  If you are using it, it will be used for any
passwd, group, and host lookups, so many programs use it.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
