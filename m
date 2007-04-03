Subject: Re: Identification of Attribute values within the Security Server
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <20070403140044.77116.qmail@web86915.mail.ukl.yahoo.com>
References: <20070403140044.77116.qmail@web86915.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Tue, 03 Apr 2007 10:20:36 -0400
Message-Id: <1175610036.16182.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-04-03 at 14:00 +0000, JanuGerman wrote:
> Hi Every one,
> 
> 
> 1) Can constraint(s) be specified in the "RefPolicy" e.g. is this
> Refpolicy is correct:

I think you mean "loadable policy module" rather than "RefPolicy".
The answer is no, constraints are not supported by the current module
language.  Only RBAC, TE, and user statements are supported in the
current module language.

> policy_module(local, 1.0)  
> 
> require {
>          type unconfined_t;
>          type fs_t priv_type;
> }
> 
> type x_t;
> bool test true;
> 
> allow x_t fs_t:filesystem associate;
> if (test) {
>          # allow unconfined_t all access to x_t
>          allow unconfined_t x_t:dir *;
>          allow unconfined_t x_t:file *;
> } else {
>          # allow unconfined_t only ls access
>          allow unconfined_t x_t:dir { getattr read search };
>          allow unconfined_t x_t:file {getattr }; 
> }
> constrain filesystem associate (t1=priv_type)
> 
> The intended semantics of this policy is to associate an attribute with the fs_t typeand then further constrain the permissions. But the above semantics can be achieved by (t1=t2) may be?.

filesystem associate is a check between a file's security context and
the security context of the containing filesystem
(superblock/partition).  It is rarely used at present but could be used
to e.g. bind specific file types to specific filesystems.  It is not a
process-based check.

> 2) SELinux policy may contain attributes, which can be associated with
> types and can be checked within the constrain(t) expressions in a
> further step. Within the security server i.e. ss/services.c however,
> the function "constraint_expr_eval" checks the types only and there is
> no check for delcared attribute seperately i think so. It seems that
> attributes are internally mapped to types and within the
> "constraint_expr_eval" function, only types are checked?

Correct; attributes are expanded to their type sets when the policy is
generated (at expand time for modular policy).  Originally this was
always done and attributes were completely discarded from the policy at
that time; later support was added for preserving allow rules based on
attributes as a more compact representation, which is why there is now a
type_attr_map in the policydb, but this is only used for avtab lookups
by compute_av, not by the constraint evaluator.

>  Secondly, integers are associated with these types. Whether these
> types are mapped to integers seperately some where else?. Actually, my
> intension is to identify a particular type within the
> "constraint_expr_eval" but i found that, types are first mapped to
> integers first, and not directly machted based on their names. Is this
> a correct approach for the identification of particular types or a
> better approach can be taken before entering into the security server?

Types (and all other symbols) are mapped to integer index values during
policy generation, and those indices are used within the security server
to identify them and efficiently represent sets of them (via ebitmaps).
The values can change upon policy reload and should never be exposed
outside of the security server.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
