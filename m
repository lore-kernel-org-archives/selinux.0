Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA06411
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 15:04:23 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA21432
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 20:03:48 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id UAA21428
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 20:03:48 GMT
Date: Thu, 17 Jan 2002 15:04:18 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Trent Jaeger <jaegert@us.ibm.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: klogd_t problem
In-Reply-To: <OF90AA15D0.BDA8EACC-ON85256B44.0068C05D@pok.ibm.com>
Message-ID: <Pine.GSO.4.33.0201171426520.18610-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 17 Jan 2002, Trent Jaeger wrote:

> Should the following be changed as follows, should System.map always be a
> file, or is there something else wrong.
>
> old: allow domains boot_t:file r_file_perms;
> to:   allow domains boot_t:{file lnk_file} r_file_perms;

This change is fine (except that you presumably mean 'domain' not
'domains').  This is just an oversight in the example policy.  I expect
that there are a number of similar omissions.  Thanks for mentioning it.
Please keep in mind that the example policy is just an example to help
demonstrate SELinux and to provide people with a starting point.  We don't
view it as "complete" (indeed, "complete" is meaningless without a better
definition of the target environment and the security requirements).  As
always, we encourage feedback and contributions to the example policy to
help make it more "complete".

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
