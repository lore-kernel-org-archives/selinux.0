Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA11783
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 11:38:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA10820
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 16:37:21 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA10816 for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2002 16:37:20 GMT
Date: Mon, 25 Feb 2002 11:37:34 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: nscd
In-Reply-To: <20020224121902.8EA77286E2@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0202251134540.16566-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 24 Feb 2002, Russell Coker wrote:

> I have just created some rules for nscd (the name service caching daemon).
>
> In domains/system/initrc.te I put the following:
> domain_auto_trans(initrc_t, nscd_exec_t, nscd_t)
>
> I put the following in file_contexts:
> /usr/sbin/nscd                  system_u:object_r:nscd_exec_t

I'd suggest including the above domain_auto_trans rule and the role types
definition (role system_r types nscd_t) in the nscd.te file.  That keeps
the entire domain definition isolated to nscd.te.  I've merged this
domain with these minor changes.  At some point, I'd like to revise the
other domains in the example policy configuration to do likewise.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
