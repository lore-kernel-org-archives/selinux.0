Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA10162
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 08:48:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA11827
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 12:46:51 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA11823 for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 12:46:50 GMT
Date: Fri, 19 Apr 2002 08:47:41 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: initrc question and initrc+proftpd patch
In-Reply-To: <20020419143800.B18906@lemuria.org>
Message-ID: <Pine.GSO.4.33.0204190845550.18117-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 19 Apr 2002, Tom wrote:

> I have one question about the initrc handling in the example policy:
>
> Why does it not do a domain transition to initrc_t when the scripts are
> executed by sysadm_t (i.e. manually by the sysadmin) ?
> With the example policy, the same process started at system boot or
> manually later will run in different domains. I've added this line to
> domains/program/initrc.te:
>
> domain_auto_trans(sysadm_t, initrc_exec_t, initrc_t)

The init scripts should be run via run_init by an administrator.  A domain
transition is not sufficient, as it does not address the user identity or
role attributes, and a direct transition poses risks from malicious code.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
