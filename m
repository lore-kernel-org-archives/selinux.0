Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA15111
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 09:05:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA25100
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 14:04:45 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA25096 for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 14:04:44 GMT
Date: Mon, 25 Mar 2002 09:05:12 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Leslie J. French" <ljf@semandex.net>
cc: <selinux@tycho.nsa.gov>
Subject: RE: SMP mode?
In-Reply-To: <BFEMIIHKHLALNELLMPOMMEMOCAAA.ljf@semandex.net>
Message-ID: <Pine.GSO.4.33.0203250901130.1015-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 23 Mar 2002, Leslie J. French wrote:

> I read somewhere that SeLinux will return EPERM if it thinks I'm trying a
> buffer overflow exploitation.

That isn't correct.  SELinux simply enforces access controls in accordance
with the security policy configuration.  It doesn't perform any kind of
dynamic detection and response to anamolous behavior.

You never responded to my earlier questions, sent on 3/20 to the list.  Is
it failing on a sendto/sendmsg call or some other call?  Does the problem
occur with a kernel built with the CONFIG_SECURITY_IP option disabled?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
