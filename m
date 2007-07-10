Subject: Re: using newrole to reset the mls level
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD01FB6D93@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD01FB6D93@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Tue, 10 Jul 2007 16:49:17 -0400
Message-Id: <1184100557.3392.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-07-10 at 10:48 -0700, Clarkson, Mike R (US SSA) wrote:
> I've found that I need to provide the following mls privileges to allow
> resetting the mls level with newrole (newrole -l s2)
> 
> 
> mls_process_set_level (needed to allow modifying the level)
> mls_file_write_down (needed to allow relabeling the tty)
> mls_file_read_up (needed to read the tty)
> mls_file_upgrade (needed to set a new level for the tty)
> mls_file_downgrade (needed to restore tty when exiting newrole)
> mls_fd_use_all_levels (needed to allow using the tty fd)
> 
> These are a lot of privileges to provide to a domain.
> 
> Is there another way to allow newrole to work without having to provide
> all of these privileges?

First, most if not all of those should already be included in the
existing -mls policy, see policy/modules/selinuxutil.te for the newrole
definitions.

Second, you already described why it needs those MLS privileges above.
newrole by its very nature is crossing a level boundary and thus must
violate the usual BLP restrictions.  Keep in mind however that it is
still being limited to least privilege and protected from interference
by the TE policy.  It cannot for example downgrade arbitrary files, only
files with types to which its domain has relabelfrom permission.

You could possibly try to refactor the newrole code, e.g. splitting out
different functions into different helper programs each with its own
domain, but I'm not sure how much you would gain there.

Finer granularity in policy might be possible by rewriting the mls
constraints, or by extending the constraint mechanism.  In early SELinux
or perhaps pre-SELinux (e.g. Flask, DTOS), we supported defining
constraints on a per-type-pair basis (e.g. you could constrain how a
given domain can act on a given type differently than how it may act on
a different type), or defining separate access vectors for each MLS
relationship on a per-type-pair basis.  That allowed for very granular
assignment but yielded much more verbose specifications and had a cost.
It was later pruned down to the current constraint language.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
