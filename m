Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA03186
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 09:06:47 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1QE6kI29144
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 14:06:46 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id h1QE6kf29140 for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 14:06:46 GMT
Date: Wed, 26 Feb 2003 09:06:18 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Clem Skorupka <ragnor@mitre.org>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Core policy
In-Reply-To: <3E5A7BBC.63AF1F96@mitre.org>
Message-ID: <Pine.LNX.4.33.0302260900300.3682-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 24 Feb 2003, Clem Skorupka wrote:

> Basically think of core as the minimum services/policy that any stripped-down
> "specialty" server would want.

  We're trying to define 'core' as what a SELinux experimenter needs to
get up and running. I'd say basic workstation functionality, sshd, the
policy tools, but not X Windows.

> So if I was building a hardened dns server, I would have no need of printing, or an
> apache web server.  Or inetd/xinetd.
> I wouldn't need sound.  Or dhcp client.
>

  I've done that for another project. A hardened server (a comm router)
that doesn't even allow remote administration. Policy can be very small.
That larger challenge is integrating SELinux policy with other policies
that affect the operation of the server.

> After that I'd create some category of "server" policy, to cover the webservers,
> ftp servers, dns, et al.
> Some might want to slice this up into internal servers (e.g. printing, databases)
> vs. external servers (e.g. web).  I'd follow common industry practices such as
> keeping servers "headless".
>
> Another category would be "user-workstation/gui", which would include dhcp client,
> x-windows, sound, web browsers.
>

  I don't mind the ideas of categories, but how do we want to distribute
such things as part of the SELinux distribution? Is it a build option
('make workstation'), is it a set of guidelines? Suggestions?

  For now, though, the focus is on defining the core as described above,
then cleaning up this policy to provide least privilege, removing some
macros, cleaning up the dependencies between policy files, etc.

Thanks for the suggestions.

 --
Wayne Salamon
wsalamon@tislabs.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
