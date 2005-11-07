Subject: Re: [ SELINUX ] [ POLICYCOREUTILS ] Convert
	setsebool	-P	to	use	libsemanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
   Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, James Morris <jmorris@redhat.com>,
   Chad Sellers <csellers@tresys.com>
In-Reply-To: <436F8383.9030909@cornell.edu>
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
	 <436F8383.9030909@cornell.edu>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 11:33:29 -0500
Message-Id: <1131381209.20591.89.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-07 at 11:40 -0500, Ivan Gyurdiev wrote:
> > No, the presence of libsemanage or even a particular version of
> > libsemanage doesn't tell us whether the system policy is managed via
> > libsemanage.  It only tells us that some code on the system is linked
> > against libsemanage.  Conversion of a system to being managed via
> > libsemanage is a change in the policy package, not a change in
> > libsemanage.  In particular, it involves converting the policy package
> > to using policy modules and using semodule.
> >   
> Does the existance of some random file in /etc/selinux/?/modules/active 
> imply that libsemanage is managing the system. Shouldn't we be looking 
> at /etc/selinux/config instead?

My semanage_is_managed() patch is simply using the same check as
semanage_connect(), except with create=0 so that it doesn't create the
store if it doesn't already exist.  Whether or not that is a "good" test
can be debated, but it is consistent, and it ensures that when you
initialize the store via libsemanage (via semodule),
semanage_is_managed() will return the desired result for subsequent
setsebool invocations.

Putting an indicator in /etc/selinux/config (or relying on the presence
or absence of SETLOCALDEFS= as an indicator) makes it more likely that
you'll have inconsistent states, as a semodule -b isn't going to update
that file, and that file is consulted by libselinux, not libsemanage.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
