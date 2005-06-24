Subject: Re: Alternative user management approach
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@redhat.com>
Cc: "Brian T. Sniffen" <bsniffen@mitre.org>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <Xine.LNX.4.44.0506241549100.19660-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0506241549100.19660-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 15:58:53 -0400
Message-Id: <1119643133.12865.181.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-24 at 15:50 -0400, James Morris wrote:
> On Fri, 24 Jun 2005, Stephen Smalley wrote:
> 
> > Yes, but SELinux doesn't isolate those shells even if they have
> > different SELinux user identities if they have the same role and domain.
> > In fact, you only get real isolation in SELinux between domains (or MLS
> > levels, if using MLS).  
> 
> But how would this change impact MLS, given that levels are associated 
> with SELinux users?

Ok, so instead of just "role class", the SELinux user identity becomes a
"role/level class", and you just have an extra level of indirection
between Linux users and levels, just as you would have between Linux
users and roles.  So you can map a set of Linux users who are authorized
for a given range to a single SELinux user identity if you want.  But
you still have the freedom to maintain separate SELinux user identities
per Linux uid if you truly want that; that would all be controlled by
the new config file that specifies the mappings.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
