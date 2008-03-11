Subject: Re: [PATCH] libsepol: support for permissive types
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>, tmiller@tresys.com, jbrindle@tresys.com
In-Reply-To: <1205261201.23866.186.camel@moss-spartans.epoch.ncsc.mil>
References: <1205243961.5297.79.camel@localhost.localdomain>
	 <1205260096.23866.168.camel@moss-spartans.epoch.ncsc.mil>
	 <1205260543.5297.113.camel@localhost.localdomain>
	 <1205261201.23866.186.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 11 Mar 2008 17:28:26 -0400
Message-Id: <1205270906.5297.141.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-11 at 14:46 -0400, Stephen Smalley wrote:
> On Tue, 2008-03-11 at 14:35 -0400, Eric Paris wrote:
> > On Tue, 2008-03-11 at 14:28 -0400, Stephen Smalley wrote:
> > > On Tue, 2008-03-11 at 09:59 -0400, Eric Paris wrote:

> > > Have you tested the handling of aliases, e.g. declare a type alias to a
> > > type in one module, then mark that type alias as permissive in another
> > > module, and confirm proper propagation of the permissive flag?
> > 
> > I tested declare a type in base and then in a module require that base
> > type, alias to that base type, and then permissive the alias.  Is there
> > a different between that and actually declaring the type in another
> > module?
> 
> The interesting case is when you declare the type and alias in one
> module, then use that alias as if it were a type in another module.
> Then checkmodule doesn't know that it is dealing with an alias while
> compiling the latter module, and the link/expand logic has to properly
> deal with it.  Same issue occurs for attributes.

Let me know if this is what you wanted tested:

******
module define_alias 1.0;

require {
	type type1_t;
}

type type_t;
typealias type_t alias alias_t;
*****
module perm_alias 1.0;

require {
	type alias_t;
}

permissive alias_t;
******
[root@dhcp231-146 perm]# semodule -s tmp -l
No modules.
[root@dhcp231-146 perm]# semodule -s tmp -i define_alias.pp
[root@dhcp231-146 perm]# semodule -s tmp -i perm_alias.pp
[root@dhcp231-146 perm]# semodule -s tmp -l
define_alias	1.0
perm_alias	1.0
******
[root@dhcp231-146 perm]# sedispol /etc/selinux/tmp/policy/policy.23 
Reading policy...
libsepol.policydb_index_others: security:  1 users, 2 roles, 4 types, 1 bools
libsepol.policydb_index_others: security: 2 sens, 2 cats
libsepol.policydb_index_others: security:  1 classes, 1 rules, 0 cond rules
binary policy file loaded

[snip]

Command ('m' for menu):  p
permissive sids:
	 type_t

Command ('m' for menu):  
*******

Looks like it worked to me.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
