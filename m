Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA02505
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2001 09:40:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA07706
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2001 13:39:31 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id NAA07702
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2001 13:39:30 GMT
Date: Fri, 5 Oct 2001 09:39:42 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: James Bishop <james.bishop@jrc.it>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Compiling for SuSE 7.2
In-Reply-To: <3BBD5F8C.6090309@jrc.it>
Message-ID: <Pine.GSO.4.33.0110050931280.29582-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 5 Oct 2001, James Bishop wrote:

> I had that feeling that it was too easy...
>
> When I boot selinux (or SuSE linux) into runlevel 3 (no X), I get the
> login prompt, I enter username and password, and then answer the query
> about choosing a new context (in selinux only). After replying "no", I'm
> back at the login prompt again; not the shell prompt.
>
> So my modified login doesn't actually work - awareness dawns (somewhat
> slowly). I had assumed that the same login binary was used for all
> logins to the system, but apparently X, and / or Gnome, do things
> differently. Is this really so?

Yes, the X Display Manager handles login separately from the login
program.  Likewise, sshd handles remote logins without ever running the
login program.

Does the modified login program still work when running the original SuSE
kernel?  It is supposed to function as usual when SELinux is not running.
If it doesn't work on the SuSE kernel, then this suggests that your
util-linux MCONFIG is wrong for SuSE.  Does the SuSE login use PAM?

If the modified login program does work when running the original SuSE
kernel, then check /var/log/messages to see if there were any error
messages from login.  Did you remember to edit and install the
/etc/security/default_context file?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
