Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA12742
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 13:15:52 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA16052
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 18:14:53 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA16048 for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 18:14:52 GMT
Date: Mon, 25 Feb 2002 13:15:01 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: RE: nscd
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A1015242DE@csoc-mail-box.csoconline.com>
Message-ID: <Pine.GSO.4.33.0202251252160.16566-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 25 Feb 2002, Westerman, Mark wrote:

> I agree that the example policy configuration needs to be modified
> such that domains are contained completely with in a xxxx.te file.

We can't provide "complete" encapsulation of each domain, since domains
interact with each other directly (transitions, signals, IPC) and
indirectly (via shared files).  In cases where you have a rule involving
two domains or where you have a rule involving a domain and a type derived
from another domain, the optimal location for the rule isn't always clear
(and it doesn't always fit an easy convention, e.g. always place the rule
in the source domain's .te file or always place the rule in the target
domain's .te file).  Of course, with good policy tools, it should be
possible to easily generate lists of rules from either viewpoint (e.g.
show me all domains that can transition to domain X, show me all domains
to which domain X can transition).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
