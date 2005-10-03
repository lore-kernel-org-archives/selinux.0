Subject: RE: [RFC][PATCH] New interface for loading policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, SELinux-dev@tresys.com
In-Reply-To: <200510031256.j93CugYs013021@gotham.columbia.tresys.com>
References: <200510031256.j93CugYs013021@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 10:17:30 -0400
Message-Id: <1128349050.26285.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-03 at 08:56 -0400, Karl MacMillan wrote:
> I think that it needs to remain. In the future all requests for changing
> bools, either persistently or temporarily, should go through the policy
> server so that it can a) notify all security servers and b) enforce access
> control over the changes. It does not, however, make sense to save all
> states to disk. This means that load_policy needs to take care of saving the
> state on reload. I think this is significantly "safer" than the users case -
> the fallback is the defaults in the on-disk policy.

True.  The only potential concern is that we are trying to preserve the
active boolean values of the booleans that were defined in the previous
policy in the new policy.  If the boolean is no longer defined at all,
we just skip it.  But if a given boolean name has changed its semantic
meaning between the policies, then preserving its value could have
interesting effects.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
