Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAQDloRb019357
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 08:47:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAQDlnqY003209
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 13:47:49 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hAQDln0o003206 for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 13:47:49 GMT
Subject: Re: Network security contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@ipen.br>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <3FC49D7D.4090507@ipen.br>
References: <3FC49D7D.4090507@ipen.br>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1069854465.30315.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 26 Nov 2003 08:47:45 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-11-26 at 07:33, Carlos Anísio Monteiro wrote:
> Hi.
> 
> How can I verified if the network entities are setting to the proper 
> security contexts ? What can I command use ?
> The security contexts to the network entities are setting in the 
> net_contexts file.

As noted in the selinux-doc README, the SELinux network access controls
were temporarily removed when SELinux was reworked for mainline 2.6
because the implementation depended on a set of security fields and
hooks that were not accepted into mainline 2.6.  James Morris has begun
reimplementing these controls.  If you want to experiment with them, you
will need to use a very recent snapshot of our kernel patch.  I'll post
our current 2.6.0-test10-selinux1 patch in a separate message.  Also, we
have begun to submit our patches for inclusion in Arjan's 2.6 kernel
RPMS as a holding place until we can get them upstreamed post 2.6.0, so
you can use his kernel RPMs if you like (under
http://people.redhat.com/arjanv/2.5).

There is no command to show the context of a network entity.  But (with
very recent snapshot of the kernel patch) you can see the effect by
enabling auditing of the corresponding permissions, e.g.
	auditallow domain netif_type:netif *;
	auditallow domain node_type:node *;

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
