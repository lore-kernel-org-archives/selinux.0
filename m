Subject: RE: [PATCH] semanage-functionality 4/17
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   "'Joshua Brindle'" <jbrindle@tresys.com>
In-Reply-To: <200509272038.j8RKcKYs000732@gotham.columbia.tresys.com>
References: <200509272038.j8RKcKYs000732@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 17:10:18 -0400
Message-Id: <1127855418.21671.203.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-27 at 16:38 -0400, Karl MacMillan wrote:
> These are the stubs that we put in a while ago - we will send a patch to
> remove those. I would prefer that everything be in semanage.h, however. I
> don't think that it will make the header too long and it will make it
> clearer I believe. 

Clearer in what sense?  Logically, the module interfaces are distinct
from the user interfaces, and they will have different clients
(programs) typically.  

> These also need to be routed through the handle function pointers so that
> alternative implementations for the policy server can be provided.

Right, the handles have to be common to all, but that can certainly be
done by a handle.h that is included by the other headers.

> As above - I disagree. I would prefer a single header for everything that
> works with the transactions. The header will not be that large and it makes
> it easier to see the API as a whole.

But if the API consists of logically separable components, with
different clients/users, then why do you want that?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
