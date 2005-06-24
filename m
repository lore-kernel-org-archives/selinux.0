Date: Fri, 24 Jun 2005 19:23:21 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: "Brian T. Sniffen" <bsniffen@mitre.org>,
   Karl MacMillan <kmacmillan@tresys.com>, <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>
Subject: Re: Alternative user management approach
In-Reply-To: <1119643133.12865.181.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0506241922240.20022-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 24 Jun 2005, Stephen Smalley wrote:

> > But how would this change impact MLS, given that levels are associated 
> > with SELinux users?
> 
> Ok, so instead of just "role class", the SELinux user identity becomes a
> "role/level class", and you just have an extra level of indirection
> between Linux users and levels, just as you would have between Linux
> users and roles.  So you can map a set of Linux users who are authorized
> for a given range to a single SELinux user identity if you want.  But
> you still have the freedom to maintain separate SELinux user identities
> per Linux uid if you truly want that; that would all be controlled by
> the new config file that specifies the mappings.

Ok, this sounds quite flexible for MLS (cd'd Chad in case he has some
input).


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
