Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KIDERb021469
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:13:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KIDBAR020007
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 18:13:11 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
        by jazzband.ncsc.mil  with ESMTP id i4KIDAHn020001 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 18:13:10 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KID9WG026093
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:13:09 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id i4KID93u026091
	for selinux@tycho.nsa.gov; Thu, 20 May 2004 14:13:09 -0400
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KI5CRd021358
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:05:13 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KHZwAR015071
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 17:35:58 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i4KHYiHn014667 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 17:34:45 GMT
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: start of patch to dpkg's start-stop-daemon
Date: Fri, 21 May 2004 03:33:37 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040520084306.GL24597@lkcl.net> <200405210132.17391.russell@coker.com.au> <20040520162343.GL8810@lkcl.net>
In-Reply-To: <20040520162343.GL8810@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405210333.37234.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 21 May 2004 02:23, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > it's a patch to dpkg 1.10.21's utils/start-stop-daemon.c
> > > which causes a context switch just before
> > > the setuid/setgid calls.
> >
> > What is the benefit in that?
>
>  it's easier than breaking pre-existing /etc/init.d/* scripts where
>  people expect the -u option to act as it should?

How is it broken?  initrc_t has setuid and setgid capabilities so SE Linux 
does not stop the regular function of start-stop-daemon.

In fact it's good for start-stop-daemon to be used to run a daemon as UID != 
0, that means that the daemon domain does not need setuid capability.

>  in other words, the benefit in patching start-stop-daemon is to
>  provide legacy transition support.

My systems have been working fine with a non-patched start-stop-daemon for two 
years.  When I first started working on SE Linux I had a similar idea to 
avoid the use of run_init, that turned out to be a bad idea and I've been 
using the regular start-stop-daemon since then.

>  i _really_ don't want the -u option on my custom /etc/init.d/custom
>  script to suddenly start running the daemon as root.

Why not?

If root is the appropriate UID for Unix permissions to allow all required 
operations, then this is OK as SE Linux can still prevent it from doing 
anything bad.

>  as an inexperienced SE/Linux user i might not _know_ that i have to
>  write a domain_auto_trans() rule in the /etc/selinux policy.
>
>  therefore all of a sudden, by upgrading to SE/Linux i suddenly have
>  my -u option effectively ignored.

No, if you install a daemon which has no policy and you don't write any then 
the daemon will run as initrc_t.  This may allow the daemon to work or may 
prevent it from operating depending on what the daemon does.

>  under which circumstances, what you are saying is that
>  because the script will run as system_u:system_r:initrc_t,
>  and because that context will not have (shouldn't have!)
>  permission to do anything outrageous, my startup script will
>  break.

initrc_t has a lot of access to the system.  It's designed for startup scripts 
and breaks very few of them.

-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
