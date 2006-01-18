Subject: Re: [SEMANAGE(lib/tool)] Remove add_local/set_local
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43C82889.7020901@cornell.edu>
References: <43C2C414.9070503@cornell.edu>
	 <1137160220.3445.116.camel@moss-spartans.epoch.ncsc.mil>
	 <43C82889.7020901@cornell.edu>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 11:27:29 -0500
Message-Id: <1137601649.8926.172.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-01-13 at 15:24 -0700, Ivan Gyurdiev wrote:
> Steven, will you be increasing the major number with the next official 
> release? Some of the changes made are suspect API changes (size_t 
> conversion in sepol/semanage, commit numbers in semanage, compare 
> behavior in sepol/semanage), and this one is a clear change... What 
> about sepol?

I'd prefer not to do so, as that will cause a non-trivial amount of pain
and so far I don't think that we have affected anything outside of core
SELinux code that we maintain ourselves, and I don't think that there
will be any significant development of third party code against these
libsepol and libsemanage interfaces until there is a stable Linux
distribution release that includes them.

> If the number will be increased, I'll change some other not-so-smart 
> APIs, like port_get_proto_str, and fcontext_get_proto_str, which should 
> take an integer, and return a string, instead of taking a port or 
> context. We could also deprecate some things in sepol, or add more 
> handles here and there.

To the extent that such APIs are only used by code we maintain
ourselves, this is likely fine, and the interfaces you list above
weren't even exported in the last nsa.gov release IIRC, much less a
stable Linux distribution release.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
