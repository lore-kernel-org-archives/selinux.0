Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4OERRRb010863
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 10:27:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4OEOQB2027534
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 14:24:26 GMT
Received: from mcfeely.r00td0wn.net (dsl093-212-010.clb1.dsl.speakeasy.net [66.93.212.10])
	by jazzswing.ncsc.mil  with ESMTP id i4OEOOwi027505
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 14:24:25 GMT
From: Timothy <timothy@diyab.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH][RFC] Allow administrator control over per-user default_contexts
Date: Mon, 24 May 2004 10:25:43 -0400
Cc: Russell Coker <russell@coker.com.au>, Valdis.Kletnieks@vt.edu,
   selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   selinux-dev@tresys.com
References: <1085155374.2789.131.camel@moss-spartans.epoch.ncsc.mil> <200405240612.15645.russell@coker.com.au> <1085402633.26446.45.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1085402633.26446.45.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405241025.43837.timothy@diyab.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 24 May 2004 08:43, Stephen Smalley wrote:
> Requiring the
> admin to create a stub entry under /etc/security/default_contexts.user
> for every user just to prevent use of $HOME/.default_contexts is
> unreasonable. 

Scratch what I said. I somehow misread that..

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
