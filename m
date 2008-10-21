Subject: Re: Conditional Access to Network Resources
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris Kuester <c.kuester@tarent.de>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Paul Moore <paul.moore@hp.com>
In-Reply-To: <20081021092518.GA6606@localdomain>
References: <20081021092518.GA6606@localdomain>
Content-Type: text/plain
Date: Tue, 21 Oct 2008 08:03:03 -0400
Message-Id: <1224590583.15821.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-10-21 at 11:25 +0200, Chris Kuester wrote:
> Hi List,
> 
> I'm facing the following problem:
> 
> I want to allow my domain to access certain ports on the local interface
> and certain ports on a nonlocal interface. 
> Example:
> Domain may connect to port 25 over eth0
> Domain may connect to port 4242 only on the loopback interface.
> 
> But if I allow my domain to access port 25 over eth0 it can also 
> access port 25 on the local interface because I have to allow full
> access to both, local and remote nodes and sending traffic over
> both network interfaces.
> 
> I think I need to have some kind of condition, or do I missunderstand 
> something here?
> 
> Constraint: Switching to SECMARKing instead of the "old" network 
> confinement code is not an option at the moment. :(

Offhand, I think that is your only option if you want to express
combinations of restrictions like this - this is precisely why SECMARK
was created.

Now, if your goal instead is to control the end point domains to which a
domain can connect, then you might investigate using labeled networking
and its controls instead to enforce restrictions over what domains can
talk with what other domains.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
