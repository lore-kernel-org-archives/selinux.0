Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i28HccRb007285
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 12:38:38 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i28Hav6Q004112
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 17:36:57 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i28Hav5t004109
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 17:36:57 GMT
Subject: Re: system_r and sysadm_r roles
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@baitaca.ipen.br>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1078766880.30181.140.camel@moss-spartans.epoch.ncsc.mil>
References: <404C5B57.9020209@net.ipen.br>
	 <1078757447.30181.82.camel@moss-spartans.epoch.ncsc.mil>
	 <404CAA11.2070909@net.ipen.br>
	 <1078766880.30181.140.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1078767513.30181.147.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 08 Mar 2004 12:38:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-03-08 at 12:28, Stephen Smalley wrote:
> On Mon, 2004-03-08 at 12:14, Carlos Anísio Monteiro wrote:
> > Sorry, but don´t understand this. If a fail (that it provide a shell
> > root) to occur in a system process, can´t occur a transition to
> > sysadm_r role ?
> 
> Not unless the domain can transition to a domain associated with
> sysadm_r, and the role transition meets the boolean condition specified
> in policy/constraints for role changes.

Oh, and it would also have to transition to a user identity authorized
for sysadm_r, which would require meeting another boolean condition
specified in policy/constraints for user identity changes.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
