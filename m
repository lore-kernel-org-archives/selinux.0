Subject: Re: [ SELINUX ] [ POLICYCOREUTILS ] Convert setsebool
	-P	to	use	libsemanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
   Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, James Morris <jmorris@redhat.com>,
   Chad Sellers <csellers@tresys.com>
In-Reply-To: <1131375396.20591.20.camel@moss-spartans.epoch.ncsc.mil>
References: <436915FB.3040500@tresys.com>
	 <1131027033.23420.30.camel@moss-spartans.epoch.ncsc.mil>
	 <436A86E6.4040205@cornell.edu>  <436AF7BC.5000705@cornell.edu>
	 <1131116390.23420.247.camel@moss-spartans.epoch.ncsc.mil>
	 <436B8185.4050508@cornell.edu>
	 <1131118424.23420.265.camel@moss-spartans.epoch.ncsc.mil>
	 <436B8771.60203@redhat.com>
	 <1131120757.23420.279.camel@moss-spartans.epoch.ncsc.mil>
	 <1131121900.23420.288.camel@moss-spartans.epoch.ncsc.mil>
	 <436BD878.1070300@cornell.edu>  <436BD9DB.2050700@cornell.edu>
	 <1131371323.20591.16.camel@moss-spartans.epoch.ncsc.mil>
	 <1131375396.20591.20.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 10:09:52 -0500
Message-Id: <1131376192.20591.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-07 at 09:56 -0500, Stephen Smalley wrote:
> On Mon, 2005-11-07 at 08:48 -0500, Stephen Smalley wrote:
> > Let me clarify:  setsebool needs to fall back to the original behavior
> > (i.e. direct call to security_set_boolean_list with permanent=1) if the
> > system policy is not managed via libsemanage.  So I'm not talking about
> > having libsemanage and/or setsebool automatically initialize the
> > sandbox; I'm just talking about having a fall back to the original
> > behavior for setting persistent boolean values on non-managed systems.
> > In order to do this, we need to be able to detect whether the system
> > policy is managed via libsemanage.  Which leads us to the next point...
> 
> Something like the patch below (un-tested):

Ok, compiled and ran a quick test on a system with and without
a /etc/selinux/$SELINUXTYPE/modules tree, and it had the expected
behavior, except for a spurious error message from libsemanage in the
non-managed case:
libsemanage.semanage_create_store: Could not read from module store at /etc/selinux/strict/modules.

I would have expected semanage_create_store to just return -1 silently
w/o error output in the !create case.  I think I can just suppress it in
the !create case.

Does the patch seem sane otherwise?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
