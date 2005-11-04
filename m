Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA4GLrMA028403
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 11:21:54 -0500 (EST)
Subject: Re: [ SELINUX ] [ POLICYCOREUTILS ] Convert setsebool -P
	to	use	libsemanage
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, James Morris <jmorris@redhat.com>,
   Chad Sellers <csellers@tresys.com>
In-Reply-To: <436B8771.60203@redhat.com>
References: <436915FB.3040500@tresys.com>
	 <1131027033.23420.30.camel@moss-spartans.epoch.ncsc.mil>
	 <436A86E6.4040205@cornell.edu>  <436AF7BC.5000705@cornell.edu>
	 <1131116390.23420.247.camel@moss-spartans.epoch.ncsc.mil>
	 <436B8185.4050508@cornell.edu>
	 <1131118424.23420.265.camel@moss-spartans.epoch.ncsc.mil>
	 <436B8771.60203@redhat.com>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 11:12:37 -0500
Message-Id: <1131120757.23420.279.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-04 at 11:08 -0500, Daniel J Walsh wrote:
> > BTW, the new setsebool presumes a system that is "managed" via
> > libsemanage and already has its policy in the sandbox, so it will break
> > if used on a system that hasn't been converted to that model.  Do we
> > care?  Do we need to support the old behavior (direct manipulation of
> > the installed booleans.local file via libselinux) as a fallback on a
> > non-managed system?
> >
> >   
> Yes I think we need to maintain the previous setsebool, otherwise we 
> will need to tie. policycoreutils to policy version.

Then the options would seem to be:
1) Have libsemanage internally detect whether the sandbox has been
initialized, and if not, fall back to calling the libselinux function to
manipulate booleans.local, or
2) Have libsemanage provide an interface (is_semanage_enabled?) to allow
setsebool to detect whether the system is "managed" via libsemanage
(i.e. has the sandbox been initialized via prior semodule -b), and have
setsebool use that interface and fall back to calling the libselinux
function if it is not enabled.

Note that libsemanage (and thus semanage.conf) will be present on the
system regardless of whether or not the system is "managed" using it
since policycoreutils depends on it now.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
