Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA25492
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 09:19:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA02357
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 13:19:33 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA02353
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 13:19:32 GMT
Date: Thu, 27 Jun 2002 09:19:22 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Michael Nyika <nyix@yahoo.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Object Security Classes
In-Reply-To: <20020627130726.32770.qmail@web40202.mail.yahoo.com>
Message-ID: <Pine.GSO.4.33.0206270915550.1331-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 27 Jun 2002, Michael Nyika wrote:

> Good day: I have a question and it is about Object
> Security Classes. How does one know before hand what
> identifiers they can take? For example, i have come
> across "file", "capability", "process". In what file
> have they been predefined (if at all)?

As explained in the Configuring the SELinux Policy report, the security
classes are defined in a configuration file that is shared between the
SELinux kernel module and the example policy configuration.  The file is
named security_classes and is located under lsm-2.4/security/selinux/flask
in the source tree.  The upstream distribution installs it into
/usr/local/selinux/flask, while the Debian selinux package install it into
/usr/lib/selinux (I think).  There are a set of macros defined for common
sets of classes in the selinux/policy/macros/global_macros.te file, as
also discussed in the report.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
