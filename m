Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA03153
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 11:25:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA17169
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 15:25:23 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA17165
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 15:25:23 GMT
Date: Tue, 28 May 2002 11:24:57 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Trent Jaeger <jaegert@us.ibm.com>
cc: Frank Mayer <mayerf@tresys.com>, <selinux@tycho.nsa.gov>,
        Ian Sollars <ian.sollars@gmx.net>
Subject: RE: Policy creation RFC
In-Reply-To: <OF8E41A9E0.D4ECB574-ON85256BC0.00522D85@us.ibm.com>
Message-ID: <Pine.GSO.4.33.0205281120050.1315-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 21 May 2002, Trent Jaeger wrote:

> --- Default versus "operational dynamic" policy -- My opinion is that any
> legitimately modifiable policy needs a simpler model (not just interface)
> than the SELinux model.  As Tom pointed out, the level of expertise of the
> folks making changes is less than those who established the original
> policy.   Policies that are likely to be changed by folks with less
> expertise require a simpler model (simpler policies will result).

Can you clarify what you mean by a simpler model?  By "SELinux model", are
you referring to the combined RBAC+TE+Identity security model implemented
by the example security server (described in the new policy technical
report)?  Are you suggesting a simpler model (e.g. Biba rather than TE) or
just a fixed base TE configuration?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
