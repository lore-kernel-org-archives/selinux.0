Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA22744
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 07:27:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA16656
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 11:27:00 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA16652
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 11:27:00 GMT
Date: Fri, 12 Jul 2002 07:26:48 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Brad Chapman <jabiru_croc@yahoo.com>
cc: Russell Coker <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: Re: revising the su decision
In-Reply-To: <20020712111941.30466.qmail@web40009.mail.yahoo.com>
Message-ID: <Pine.GSO.4.33.0207120725020.28541-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Jul 2002, Brad Chapman wrote:

>           Why do you have to change your role to sysadm_r before su'ing to
> root? I was under the impression that becoming uid 0 by either logging in or
> su'ing was sufficient.....

The Linux root uid is not privileged with respect to the SELinux
mandatory access controls.  Hence, in order to perform most administrative
operations, you have to be both sysadm_r:sysadm_t and have the Linux root
uid (or at least the proper Linux capabilities).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
