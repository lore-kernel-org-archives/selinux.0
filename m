Subject: Re: [PATCH -trunk][RFC] setsebool: only use libsemanage for
	persistent boolean changes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <method@manicmethod.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <1177007815.21732.22.camel@localhost.localdomain>
References: <1177007764.27654.193.camel@moss-spartans.epoch.ncsc.mil>
	 <1177007815.21732.22.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 19 Apr 2007 16:05:43 -0400
Message-Id: <1177013143.27654.257.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-19 at 14:36 -0400, Karl MacMillan wrote:
> On Thu, 2007-04-19 at 14:36 -0400, Stephen Smalley wrote:
> > While the optimizations I introduced for libsemanage helped somewhat in reducing the
> > extraneous work done by setsebool for transient boolean changes, there were still a lot
> > of files that were unnecessarily created or modified due to the entire transactional model of
> > libsemanage, and I couldn't see a clean way of fixing that.  In retrospect, while libsemanage
> > needs to understand active booleans in order to affect persistent changes (due to boolean
> > preservation on reloads), setsebool should just apply active boolean changes directly via libselinux.
> > And with the dropped setlocaldefs support, we can require managed policy for persistent boolean
> > changes.
> > 
> 
> The only problem is if semanage starts enforcing access control on the
> booleans in a different way than the selinuxfs nodes. In that case we
> want the change to go through libsemanage.
> 
> Personally, I think that libsemanage should just fake file access
> decisions for persistent changes, but Josh never liked that idea.

I think they need to be consistent, so emulating file access checks
works for me.  And that will simplify life when we switch over to
path-based access control ;)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
