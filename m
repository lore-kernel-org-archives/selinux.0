Subject: Re: [ SEPOL ] Further users cleanup
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4359199A.40303@cornell.edu>
References: <435903C2.2050805@cornell.edu>
	 <1129908379.27663.59.camel@moss-spartans.epoch.ncsc.mil>
	 <4359199A.40303@cornell.edu>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 13:38:07 -0400
Message-Id: <1129916287.27663.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-21 at 12:38 -0400, Ivan Gyurdiev wrote:
> > Ok.  Note that we'll likely want to remove all wildcards from the map
> > files (for both libsepol and libsemanage) and explicitly list all
> > interfaces we want exported to avoid surprises, or at least check that
> > we aren't exporting anything accidentally.  
> > nm src/libsepol.so.1 | grep ' T ' shows some interfaces that shouldn't
> > really be public at present.
> >   
> Which ones? I tend to not prefix local things with sepol...

The services.c functions also had sepol_ prefixes added when audit2why
was created (it uses the static libsepol, but also uses libselinux, and
libselinux has similar functions that interact with the kernel policy
rather than a policy file/image).  Hence, we get symbols like
sepol_context_to_sid and sepol_port_sid exported by the wildcards.
Also, one exported symbol that was pre-existing was
sepol_genbools_policydb, which was likewise created for audit2why and
accidentally exported by the wildcard there, but as there should be no
other users and it was never put into the "public" header, it likely
does no harm to correct it now to only export genbools and
genbools_array.

Also need to fix this:
$ relinfo.pl src/libsepol.so.1
src/libsepol.so.1: 68 relocations, 61 relative (89%), 94 PLT entries, 60 for local syms (63%), 0 users

There shouldn't be any for local syms; need to bring over dso.h and
hidden_def/hidden_proto stuff from libselinux.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
