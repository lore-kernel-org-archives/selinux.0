Subject: Re: Policyrep to policydb
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SELinux List <selinux@tycho.nsa.gov>, Todd Miller <tmiller@tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015880153F4D2@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015880153F4D2@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 09 Jan 2008 15:06:35 -0500
Message-Id: <1199909195.9393.353.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-01-09 at 14:37 -0500, Joshua Brindle wrote:
> So we are at the point where we are trying to create a policydb out of
> the tree in policyrep and are wondering what the best approach is:
> 
> 1) create an API in libsepol that lets us add each kind of object
> (symbol, rules, ocontexts, etc). For the sake of comparison this yeilds
> 14 functions just for symbol tables (symbol_add, role_set_type,
> user_set_role, level_set_alias and so on). 
> 
> 2) Let libpolicyrep statically link against libsepol. This creates much
> strangeness such as inconsistencies in the runtime behavior if libsepol
> changes on the system but libpolicyrep wasn't rebuilt.
> 
> 3) (Karls suggestion), remove libsepol entirely and replace the libsepol
> api with wrappers in libpolicyrep.
> 
> Thoughts?

Does (3) mean fold the useful bits of libsepol code into libpolicyrep?
If so, why not just fold the useful bits of libpolicyrep into libsepol
and prune what we don't still need there?  The latter is less disruptive
to existing packages (both in terms of source and binaries).

We presently have a build time dependency on libsepol for checkpolicy
(and audit2why).  Do we expect that to be replaced by libpolicyrep even
when building monolithic policy?

We presently have a (originally link-time, now dlopen'd) run time
dependency on libsepol for libselinux to support policy loading.  Do we
expect that to be replaced by libpolicyrep?

I had thought that we wanted to keep them separate as libpolicyrep
wasn't necessarily going to be required on the target system (e.g. for
embedded w/ monolithic policy) and thus having a minimal libsepol might
be useful.  If not, then just directly folding libpolicyrep into
libsepol makes more sense than removing libsepol.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
