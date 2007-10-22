Subject: Re: error is expansion behavior
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "J. Tang" <jtang@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1192818788.2647.34.camel@venom.columbia.tresys.com>
References: <1192818788.2647.34.camel@venom.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 22 Oct 2007 10:59:20 -0400
Message-Id: <1193065160.24622.69.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-10-19 at 14:33 -0400, J. Tang wrote:
> There appears to be a problem with how semodule_expand handles aliases
> within optional blocks.  Consider this module:
> 
> optional {
>   require {
>     type not_exist_in_base_t;
>   }
>   typealias not_exist_in_base_t alias bogus_alias_t;
> }
> 
> The resulting expanded policy [correctly] does not contain
> not_exist_in_base_t, but does have bogus_alias_t.  This is because
> type_copy_callback() in expand.c calls is_id_enabled(), but
> alias_copy_callback() does not.  The contents of the alias's value will
> be set to zero because there is no entry in state's typemap for the
> primary (line 479 of expand.c, libsepol 2.0.12).
> 
> In terms of everyday usage, this is not a problem because bogus_alias_t
> will never be referenced.  However, tools that analyze policy by
> iterating over hash tables (e.g., SETools) will fail because
> bogus_alias_t's value is zero.  We suspect this is the cause of the
> segfault reported in https://bugzilla.redhat.com/show_bug.cgi?id=336841,
> for the targetted policy currently in rawhide has such an alias,
> unconfined_mozilla_rw_t.
> 
> One solution is to check if newalias->s.value will be zero, and if so
> then do not insert the alias into the hash table.  This seems brittle
> because it relies on a side-effect of the typemap (i.e., unfulfilled
> types have a value of zero).  Unfortunately, other solutions will
> involve much more work.  What should be done about this problem, if any?

You mentioned above that alias_copy_callback() does not check
is_id_enabled().  Should it?  Would that solve the problem?

If not, then I'd suggest going with the approach you describe above,
along with a comment that identifies the dependency.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
