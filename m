Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA26045
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 09:34:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA12235
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 13:33:19 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA12231 for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 13:33:19 GMT
Date: Fri, 3 May 2002 09:34:21 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: kmod.te
In-Reply-To: <Pine.GSO.4.33.0205030812390.16931-100000@raven>
Message-ID: <Pine.GSO.4.33.0205030933360.16931-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 3 May 2002, Stephen Smalley wrote:

> If you perform a transition from kmod_t to insmod_t, then you can no
> longer distinguish between module insertions initiated by the kernel vs.
> module insertions initiated by some user process that can transition to
> insmod_t.  Consider the scenario where someone wishes to prohibit all
> insertions by user processes but is willing to allow insertions initiated
> by the kernel.  Hence, it seems preferable to remain in kmod_t so that the
> policy can distinguish these events if desired.

By the way, this is mentioned in the old policy technical report, although
it is admittedly buried:

When executed by the kernel module loader, the \texttt{modprobe} and
\texttt{insmod} programs remain in the \emph{kmod\_t} domain.  This
allows the security policy to distinguish between permissions granted
to the kernel module loader and permissions granted to module
utilities executed by user processes.  For example, the
security policy could be configured to prohibit any transitions
to the \emph{modprobe\_t} and \emph{insmod\_t} domains while
still allowing the kernel module loader to function.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
