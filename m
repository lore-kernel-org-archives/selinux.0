Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i28HS5Rb007206
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 12:28:05 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i28HS40F004176
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 17:28:04 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i28HS3gZ004173 for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 17:28:03 GMT
Subject: Re: system_r and sysadm_r roles
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@baitaca.ipen.br>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <404CAA11.2070909@net.ipen.br>
References: <404C5B57.9020209@net.ipen.br>
	 <1078757447.30181.82.camel@moss-spartans.epoch.ncsc.mil>
	 <404CAA11.2070909@net.ipen.br>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1078766880.30181.140.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 08 Mar 2004 12:28:00 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-03-08 at 12:14, Carlos Anísio Monteiro wrote:
> Sorry, but don´t understand this. If a fail (that it provide a shell
> root) to occur in a system process, can´t occur a transition to
> sysadm_r role ?

Not unless the domain can transition to a domain associated with
sysadm_r, and the role transition meets the boolean condition specified
in policy/constraints for role changes.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
