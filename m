Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA10380
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 09:28:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA13654
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 13:26:56 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA13650 for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 13:26:56 GMT
Date: Fri, 19 Apr 2002 09:27:13 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: initrc question and initrc+proftpd patch
In-Reply-To: <20020419150046.A19154@lemuria.org>
Message-ID: <Pine.GSO.4.33.0204190919571.18117-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 19 Apr 2002, Tom wrote:

> That makes sense and leaves just one question: Why then do some of the
> program.te files contain a domain transition for the sysadmin user?
> snort is one example.

Some programs are directly executed by administrators as utilities in
addition to being executed from init scripts.  In that case, you can
simply use a domain transition from sysadm_t to the program domain.
However, I wouldn't be surprised if there are unnecessary transitions
from sysadm_t to some of the program domains.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
