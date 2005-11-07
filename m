Subject: Re: [ SELINUX ] [ POLICYCOREUTILS ] Convert setsebool
	-P	to	use	libsemanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
   Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, James Morris <jmorris@redhat.com>,
   Chad Sellers <csellers@tresys.com>
In-Reply-To: <436BD9DB.2050700@cornell.edu>
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
Content-Type: text/plain
Date: Mon, 07 Nov 2005 08:48:43 -0500
Message-Id: <1131371323.20591.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-04 at 16:59 -0500, Ivan Gyurdiev wrote:
> > I'm not sure that this makes sense... let's get to back to the reason 
> > _why_ the sandbox is uninitialized - it's because we haven't copied 
> > the proper files into the sandbox yet. Falling back to other functions 
> > seems equivalent to doing the initialization ourselves - copy the 
> > proper files into the sandbox. We could just do that instead, but I'm 
> > not sure it's a good idea. It would require the same privileges....

Let me clarify:  setsebool needs to fall back to the original behavior
(i.e. direct call to security_set_boolean_list with permanent=1) if the
system policy is not managed via libsemanage.  So I'm not talking about
having libsemanage and/or setsebool automatically initialize the
sandbox; I'm just talking about having a fall back to the original
behavior for setting persistent boolean values on non-managed systems.
In order to do this, we need to be able to detect whether the system
policy is managed via libsemanage.  Which leads us to the next point...

> I am also wondering whether migration code should go into the 
> libsemanage %post script, rather than the policy %post script.
> Then we don't have to deal with this issue, because the fact that you're 
> linking to the library, means it's installed, and %post was executed - 
> haven't thought much about this, so maybe it's a stupid idea, but ... 
> what do you think?

No, the presence of libsemanage or even a particular version of
libsemanage doesn't tell us whether the system policy is managed via
libsemanage.  It only tells us that some code on the system is linked
against libsemanage.  Conversion of a system to being managed via
libsemanage is a change in the policy package, not a change in
libsemanage.  In particular, it involves converting the policy package
to using policy modules and using semodule.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
