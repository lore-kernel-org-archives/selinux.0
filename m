Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA18022
	for <selinux@tycho.nsa.gov>; Wed, 6 Nov 2002 14:25:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA24589
	for <selinux@tycho.nsa.gov>; Wed, 6 Nov 2002 19:23:37 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id TAA24583 for <selinux@tycho.nsa.gov>; Wed, 6 Nov 2002 19:23:36 GMT
Date: Wed, 6 Nov 2002 14:24:25 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Subba Rao <sailorn@attglobal.net>
cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: SELinux and security tools?
In-Reply-To: <200211061707.RAA16093@jazzband.ncsc.mil>
Message-ID: <Pine.LNX.4.33.0211061419220.1200-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 6 Nov 2002, Subba Rao wrote:

> I am planning to install SELinux on one of my laptop.  The key tools I
> plan to use are security tools such as Nessus, nmap, Snort and
> tcpdump. Will these tools work well on on SELinux?  Has anyone
> experienced problems with these tools on SELinux?
>

  There shouldn't be a problem running these utilities under SELinux, but
you will have to modify the policy for some of them. tcpdump is already
known to the example policy (in the netutils domain), as is snort (it has
it's own domain). Nessus and nmap are not in the current policy, but
contributions are welcome.

  I've run tcpdump without problem on SELinux.


-- 
Wayne Salamon
wsalamon@tislabs.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
