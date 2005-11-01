Subject: Re: [ SEMANAGE ] Some seusers mapping validation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43670528.8050701@cornell.edu>
References: <4366EE1B.1060303@cornell.edu> <4366F160.2070005@cornell.edu>
	 <4367044C.1000501@cornell.edu>  <43670528.8050701@cornell.edu>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 12:17:38 -0500
Message-Id: <1130865458.22731.205.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-01 at 01:03 -0500, Ivan Gyurdiev wrote:
> > +extern int semanage_seuser_validate(
> > +	semanage_handle_t* handle);
> >   
> Doh... will be exported by the map wildcard...
> Should I get rid of wildcards?

Or we can mark it hidden, once I add dso.h.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
