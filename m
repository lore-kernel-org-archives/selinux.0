Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i28EovRb006032
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 09:50:57 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i28EnH6Q019962
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 14:49:17 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i28EnG5t019959
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2004 14:49:16 GMT
Subject: Re: system_r and sysadm_r roles
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@baitaca.ipen.br>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <404C5B57.9020209@net.ipen.br>
References: <404C5B57.9020209@net.ipen.br>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1078757447.30181.82.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 08 Mar 2004 09:50:47 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-03-08 at 06:39, Carlos Anísio Monteiro wrote:
> I´d  like to know why there is a transition permission between system_r 
> and sysadm_r.
> 
> Example:  allow system_r sysadm_r;

The login process (which is a system_r process) transitions to sysadm_r
for administrative logins.  

> This would can induce the a problem of security ?

No, domain transitions are the key.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
