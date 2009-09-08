Subject: Re: Limitations in modular policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <4AA5AB73.6050306@ak.jp.nec.com>
References: <4AA5AB73.6050306@ak.jp.nec.com>
Content-Type: text/plain
Date: Tue, 08 Sep 2009 11:20:23 -0400
Message-Id: <1252423223.13634.389.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-09-08 at 09:55 +0900, KaiGai Kohei wrote:
> Is there any good reason why the current modular policy doesn't, cannot
> or shouldn't support to contain definitions of object classes and its
> access vectors except for the base policy?

The class and permission values are determined based on declaration
ordering.  There are no ordering guarantees among modules, and thus any
order dependent statements have to go into the base module presently.

Even for modern userspace object managers that dynamically look up the
class and permission values, we don't yet have a way to atomically roll
them over to a new set of values upon a policy reload, which could
easily happen upon module removal or insertion if they are declared in
individual modules.  I think we'd have to extend avc_reset() to also
call flush_class_cache() to force rediscovery of the class/permission
values from selinuxfs and to then call selinux_set_mapping() with the
original security_class_mapping (to which we would have to save a
reference upon the earlier selinux_set_mapping call) to re-create the
mapping.  It would have to be done while holding the AVC lock.

> For example, it seems to me reasonable to have the following statement
> to support experimental object classes and access vectors.
> --------------------------------
> policy_module(sepostgresql-devel, 1.23)
> 
> gen_require(`
>     class db_database all_db_database_perms;
>     attribute sepgsql_unconfined_type;
>     type sepgsql_db_t;
> ')
> 
> ## 1. Add an experimental access vector
> class db_database { superuser };
> 
> ## 2. Add an experimental object class
> class db_schema
> inherits database
> {
> 	search
> 	add_name
> 	remove_name
> };
> 
> ## 3. Add an experimental MLS/MCS rules
> ifdef(`enable_mcs',`
> 	mlsconstrain db_database { superuser }
> 		( h1 dom h2 );
> 	mlsconstrain db_schema { create relabelto }
> 		(( h1 dom h2 ) and ( l2 eq h2 ));
> 	mlsconstrain db_schema { drop getattr setattr relabelfrom search add_name remove_name }
> 		( h1 dom h2 );
> ')
> ifdef(`enable_mls`,`
> 	  :
> 	<snip>
> 	  :
> ')
> ## 4. avtab rules currently supported
> type sepgsql_schema_t;
> 
> allow sepgsql_unconfined_type sepgsql_db_t : db_database *;
> allow sepgsql_unconfined_type sepgsql_schema_t : db_schema *;
> --------------------------------
> 
> Currently, SE-PostgreSQL has several experimental object classes and access
> vectors (such as db_schema class and db_database:{superuser}), but we will
> need more several months to fix its specifications at least, because progress
> in the pgsql-hackers too slow.
> So, we must replace the standard selinux-policy package to run it with full
> functionalities, but it will get troubled for each "yum update".
> 
> Thanks,
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
