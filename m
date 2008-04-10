Subject: Enabling policy capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>, Daniel J Walsh <dwalsh@redhat.com>,
        Paul Moore <paul.moore@hp.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 10 Apr 2008 09:38:39 -0400
Message-Id: <1207834719.21223.730.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Where do we stand on actually enabling policy capabilities in policy so
that people can start using newer features that depend on them?

I've definitely seen patches adding permissions for the peer checks, so
is there anything preventing us from trying to enable
network_peer_controls in policy and seeing what breaks (after Fedora 9
at this point, I suppose - unfortunate that we didn't enable it sooner)?

I haven't seen patches adding permissions for open other than just to
define them, IIRC.  So enabling open_perms would be rather bad right now
except for unconfined domains.  As a possible strategy for gradual
roll-out of open perm, we could add open everywhere there is a read or
write granted, enable the open_perms capability, verify no breakage, and
then gradually remove open permission where we know it to be unneeded.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
