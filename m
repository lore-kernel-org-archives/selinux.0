Subject: Impact of IPSEC integration on policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Trent Jaeger <tjaeger@cse.psu.edu>, James Morris <jmorris@namei.org>,
   Russell Coker <russell@coker.com.au>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 09:17:36 -0500
Message-Id: <1133792256.20862.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

As a heads-up, the LSM-IPSEC network hooks patches by Trent that are
queued up for 2.6.16 (and already in -mm) have an impact on policy
(assuming people enable CONFIG_SECURITY_NETWORK_XFRM) even if not using
IPSEC.  We need to add rules to policy on the 'association' class to
allow sending and receiving of non-IPSEC protected packets (aka
unlabeled packets); otherwise, network traffic is going to be dropped.
The checks are between the socket SID and the unlabeled SID when no
association is used.  So I think it would look like:

allow $1 unlabeled_t:association { sendto recvfrom };

in the networking macros and in the unconfined macro.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
