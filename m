Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA01418
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 12:29:44 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA03287
	for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 17:28:43 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA03281 for <selinux@tycho.nsa.gov>; Wed, 6 Mar 2002 17:28:43 GMT
Date: Wed, 6 Mar 2002 12:28:44 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: suggested policy change
In-Reply-To: <1015433359.1457.1.camel@vorpal>
Message-ID: <Pine.GSO.4.33.0203061227420.24985-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 6 Mar 2002, Justin Smith wrote:

> i.e., they conflict with some of the neverallow rules. Should I simply
> get rid of the appropriate neverallow rules?

I changed the existing neverallow rule in assert.te to include kmod_t and
insmod_t in the list for this assertion, i.e.:

neverallow ~{ initrc_t admin kmod_t insmod_t } sysctl_kernel_t:file {
write append };

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
