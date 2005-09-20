Subject: Re: [ SEPOL/SEMANAGE ] Boolean record
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com
In-Reply-To: <43306E1D.2070508@cornell.edu>
References: <432FBD08.2050903@cornell.edu>
	 <1127243186.14569.135.camel@moss-spartans.epoch.ncsc.mil>
	 <4330648F.7040609@cornell.edu>
	 <1127246178.14569.143.camel@moss-spartans.epoch.ncsc.mil>
	 <43306E1D.2070508@cornell.edu>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 16:22:41 -0400
Message-Id: <1127247761.14569.159.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-20 at 16:16 -0400, Ivan Gyurdiev wrote:
> >- keep the shared libsepol, and have applications use its interfaces
> >directly.
> >
> To clarify, are you saying that we should have?
> 
> semanage_user_add(semanage_handle_t handle, sepol_user_key_t key, 
> sepol_user_t data)
> semanage_user_del(semanage_handle_t handle, sepol_user_key_t key)
> semanage_user_modify(semanage_handle_t handle, sepol_user_t key, 
> sepol_user_t data)
> 
> The sepol and semanage functionality is different - it's just the data 
> structure that's shared.

If the data structures and interfaces are truly identical, then I see no
value in relaying them in this manner from libsepol to libsemanage.  I
understand wrapping them if we are going to add further state to the
equivalent libsemanage data structures and provide further processing in
the equivalent libsemanage interfaces, but not otherwise.  Especially as
the types are just pointers to opaque structures anyway and always
manipulated via get/set methods.

> I don't know - it's just a design thing to allow future change - Joshua?
> I'm not sure if the wrap functions add value, but at least they don't 
> cause any harm.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
