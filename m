Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA11883
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 07:08:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA16716
	for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 11:07:07 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA16712 for <selinux@tycho.nsa.gov>; Tue, 16 Jul 2002 11:07:07 GMT
Date: Tue, 16 Jul 2002 07:07:59 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ed Street <blacknet@simplyaquatics.com>
cc: Selinux <selinux@tycho.nsa.gov>
Subject: Re: netfilter
In-Reply-To: <017901c22c6b$d8655e80$0a01a8c0@ed>
Message-ID: <Pine.GSO.4.33.0207160707250.23767-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 15 Jul 2002, Ed Street wrote:

> Started working with netfilter under Selinux and I noted that it was
> grouped with ipchains and labeled as
> /sbin/iptables                  system_u:object_r:ipchains_exec_t
>
> Should this have a separate label and it's own te file?

Only if it requires a distinct set of permissions and you want to enforce
that distinction in the policy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
