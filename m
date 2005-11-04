Subject: Re: [ SELINUX ] [ POLICYCOREUTILS ] Convert setsebool -P
	to	use	libsemanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, James Morris <jmorris@redhat.com>,
   Chad Sellers <csellers@tresys.com>
In-Reply-To: <1131121900.23420.288.camel@moss-spartans.epoch.ncsc.mil>
References: <436915FB.3040500@tresys.com>
	 <1131027033.23420.30.camel@moss-spartans.epoch.ncsc.mil>
	 <436A86E6.4040205@cornell.edu>  <436AF7BC.5000705@cornell.edu>
	 <1131116390.23420.247.camel@moss-spartans.epoch.ncsc.mil>
	 <436B8185.4050508@cornell.edu>
	 <1131118424.23420.265.camel@moss-spartans.epoch.ncsc.mil>
	 <436B8771.60203@redhat.com>
	 <1131120757.23420.279.camel@moss-spartans.epoch.ncsc.mil>
	 <1131121900.23420.288.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 12:11:37 -0500
Message-Id: <1131124297.23420.303.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-04 at 11:31 -0500, Stephen Smalley wrote:
> On Fri, 2005-11-04 at 11:12 -0500, Stephen Smalley wrote:
> > Then the options would seem to be:
> > 1) Have libsemanage internally detect whether the sandbox has been
> > initialized, and if not, fall back to calling the libselinux function to
> > manipulate booleans.local, or
> > 2) Have libsemanage provide an interface (is_semanage_enabled?) to allow
> > setsebool to detect whether the system is "managed" via libsemanage
> > (i.e. has the sandbox been initialized via prior semodule -b), and have
> > setsebool use that interface and fall back to calling the libselinux
> > function if it is not enabled.
> > 
> > Note that libsemanage (and thus semanage.conf) will be present on the
> > system regardless of whether or not the system is "managed" using it
> > since policycoreutils depends on it now.
> 
> I think I favor #1, as this is a legacy issue that is only going to
> exist for booleans.  When someone creates a setseport or setseinterface
> or ..., they are just going to use the semanage interfaces, and if the
> system isn't managed via libsemanage, it simply isn't going to work
> (i.e. there is no fallback mechanism, as such support didn't exist prior
> to the introduction of libsemanage).  Thus, setsebool should likewise
> unconditionally use the semanage interfaces, and libsemanage should
> internally route the requests to the old libselinux interfaces if the
> system isn't managed for legacy support.

On the other hand, #2 looks a lot simpler to implement, as setsebool can
then just call security_set_boolean_list() on the entire list when
semanage is disabled.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
