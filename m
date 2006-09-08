Message-ID: <45019F50.1090408@trustedcs.com>
Date: Fri, 08 Sep 2006 11:50:24 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
CC: jmorris@namei.org, sds@tycho.nsa.gov, chanson@TrustedCS.com
Subject: [PATCH 0/7] secid reconciliation-v02: Repost patchset with updates
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following are the changes included in this patchset since the previous post:

- Perform flow_in check before (as opposed to after) computing transition
  secid on inbound; this seems more intuitive and correct.
- Implement reconciliation and flow control for outbound traffic
  (forward case being a sequence of inbound checks followed by outbound checks).
- Make selinux_xfrm_postroute_last checks conditional on compat_net.

This patchset is relative to David Miller's net-2.6.19.git (last updated on Sep 1st).

Please consider for inclusion in 2.6.19.


UPCOMING WORK:

The following per the discussion at:
  http://marc.theaimsgroup.com/?l=selinux&m=115755980516072&w=2

- Create IPSec SAs to be acquired with the creating sock's context as opposed
  to that of the matching SPD rule, resulting in a simpler SPD as well as policy.
- Set peer_sid on tcp sockets to the reconciled secmark so trusted applications
  can retrieve and service the data at the appropriate context.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
