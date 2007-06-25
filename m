Subject: Re: Question on security_load_policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nagendra Tomar <tomer_iisc@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <994059.5156.qm@web53704.mail.re2.yahoo.com>
References: <994059.5156.qm@web53704.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 10:31:49 -0400
Message-Id: <1182781909.5636.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-06-24 at 17:11 -0700, Nagendra Tomar wrote:
> In the security_load_policy() function, for the not-first-time policy
> load case (ss_initialized is true) what is the significance of cloning
> the existing sidtab and then updating the contexts of all the sidtab
> entries (sidtab_map_remove_on_error) ?
>           
>  Why can't we just drop the table and then let the new table be
> populated dynamically as and when new contexts are looked up. As this
> is how the original sidtab was populated in the first place.
> 
> I can see that it might have some performance benefits in terms of
> not requiring to create SIDs for the security contexts that were
> already present in the current sidtab, but is that overhead really
> worth this effort.  
> 
> If we remove the code that does the cloning and conversion of contexts
> (sidtab_map and sidtab_map_remove_on_error calls)
> we will have uniform code for both the first-time and the
> not-first-time policy load case. IMHO, that will result in slightly
> cleaner security_load_policy function.  
>        If we do that, we will have to call policydb_load_isids() also
> for the not-first-time poliy load case.

In addition to the already noted fact that SIDs are pervasively cached
outside of the security server (in the object security structs, in the
AVC, even outside of the SELinux "module", e.g. in audit and ipsec/xfrm
structures), I wanted to also note that this is not the only difference
in behavior between first-time policy load and a policy reload, so
removing this difference would not make them uniform.  In particular,
selinux_complete_init() is only called on first-time policy load.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
