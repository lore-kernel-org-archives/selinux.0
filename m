Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA19720
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 12:32:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA12293
	for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 16:31:05 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA12288 for <selinux@tycho.nsa.gov>; Fri, 26 Apr 2002 16:31:04 GMT
Date: Fri, 26 Apr 2002 12:31:12 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>
cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: enforcing mode
In-Reply-To: <3CC95420.E87F2FFE@dr-baldeweg.de>
Message-ID: <Pine.GSO.4.33.0204261228200.24756-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 26 Apr 2002, Carsten Grohmann wrote:

> this time I use SELinux and after each start it is run in the permissive
> mode. After each start I change manual to the enforcing mode. It is
> possible to start automatic in the enforcing Mode? Or need I a script to
> do this?

This is discussed in step 20 of selinux/README and in the kernel
configuration help text for the SELinux Development Module option.
Quoting from README:

Once you are satisfied that your policy configuration is sufficient for
your system, you should either run avc_toggle from an rc script to switch
into enforcing mode during initialization, or you should rebuild the
kernel without this option [SELinux Development Module] so that it is
always in enforcing mode.  The first option leaves open the possibility of
switching back to permissive mode by an administrator, while the latter
option provides stricter security.  If you choose the latter option, be
sure to keep a kernel that is built with the Development Module option
available for emergency recovery (e.g. if you make an error in your policy
configuration that renders your system unuseable).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
