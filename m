Subject: Re: [RFC] Ability to allow unknown class and permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        James Morris <jmorris@redhat.com>
In-Reply-To: <4574AD50.5090305@tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885C82ED@exchange.columbia.tresys.com>
	 <45749461.7050405@mentalrootkit.com>  <4574AD50.5090305@tresys.com>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 08:41:43 -0500
Message-Id: <1165326103.15979.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-12-04 at 18:20 -0500, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > But you can tell if unknown permissions will be allowed (and even which 
> > object classes and permissions for a specific kernel) without reference 
> > to the _configuration_ of a specific system. You only need to look at 
> > the policy and the version of the kernel / userspace components. That 
> > is, in my opinion, an important difference.
> > 
> 
> Unless there is a permission associated with setting this option (via 
> semanage or similar) you don't buy anything. And I'm not sure what value 
> you get out of knowing unknown permissions are allowed or denied in an 
> analysis anyway.

I don't follow the first statement - trusting the policy toolchain to
correctly propagate and apply this flag when generating kernel policy is
not substantially different than trusting it to correctly propagate
other elements of policy to the kernel policy.  On the second statement,
the value is being able to say something about actual information flow -
if I know that kernel x.y.z introduced new flows along with
corresponding permission checks and that policy a.b.c doesn't define
those permissions but says to not allow undefined permissions, then I
know that those flows are not possible at all, versus being an
uncontrolled channel.  If the behavior is decoupled from (kernel,
policy) pair, then I don't really know whether there might be
uncontrolled channels or not (w/o looking at a transient value at the
time the operation occurred).

However, I do think that this would be simpler to implement in kernel,
at the same time it is validating the kernel classes and permissions
during policy load.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
