Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA18150
	for <selinux@tycho.nsa.gov>; Thu, 10 Oct 2002 12:48:01 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA05510
	for <selinux@tycho.nsa.gov>; Thu, 10 Oct 2002 16:46:21 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA05506
	for <selinux@tycho.nsa.gov>; Thu, 10 Oct 2002 16:46:19 GMT
Date: Thu, 10 Oct 2002 12:47:37 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: another policy patch
In-Reply-To: <200210101804.46869.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0210101247080.23968-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 10 Oct 2002, Russell Coker wrote:

> This one has:
>
> Postfix changes Carsten requested
>
> Some named changes that are needed for the latest bind9 (didn't seem to be
> needed for the previous version of bind9 though).
>
> Makes rlogind.te work
>
> Has the Apache2 changes Tom sent me
>
> Has the /proc change to fix that problem that bit Tom
>
> Has some ssh changes (mainly from Brian)
>
> Defines shell_exec_t in types.te (has to be also removed from user.te).  This
> is necessary because sometimes you don't want any users on a system but you
> still need a file type for the shell.

Thanks, merged along with the removal of shell_exec_t from user.te (not in
the patch).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
