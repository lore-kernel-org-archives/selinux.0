Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA05126
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 07:33:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA17355
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 11:32:17 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA17351 for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 11:32:17 GMT
Date: Mon, 15 Jul 2002 07:33:42 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Belch <belch76@libero.it>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Compiling a simple policy
In-Reply-To: <200207131142.51302.belch76@libero.it>
Message-ID: <Pine.GSO.4.33.0207150729140.29432-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 13 Jul 2002, Belch wrote:

> /usr/local/selinux/bin/checkpolicy -o tmp/policy.11-mls policy.conf
> /usr/local/selinux/bin/checkpolicy:  loading policy configuration from policy.conf
> ERROR 'no range for user' at token ';' on line 126447:
> #
> user system_u roles system_r ;
> /usr/local/selinux/bin/checkpolicy:  error(s) encountered while parsing configuration
> make: *** [policy.11-mls] Error 1
> [root@localhost policy]#
>
> Line 126447:
> user system_u roles system_r ;

To use the experimental MLS policy option, you must also follow the
instructions in selinux/README.MLS.   I suspect that you forgot to set
MLS=y in the policy/Makefile, and you should define MLS ranges for at
least one user.  Please note that the MLS policy option is experimental,
and that you do not need to enable it to use SELinux with the RBAC and TE
logic.  Don't enable it unless you truly want to experiment with the MLS
support.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
