Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1QGxqRb007310
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2004 11:59:53 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1QGxpQQ011626
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2004 16:59:51 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id i1QGxoP0011619 for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2004 16:59:50 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id i1QGxob26056
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2004 11:59:50 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [172.16.52.156])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i1QGxo824797
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2004 11:59:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16446.9733.300596.566738@neuro.alephnull.com>
Date: Thu, 26 Feb 2004 11:59:49 -0500
From: Rik Faith <faith@redhat.com>
To: selinux@tycho.nsa.gov
Subject: Re: Patch for auditing framework 
In-Reply-To: [Rik Faith <faith@redhat.com>] Wed 25 Feb 2004 15:38:06 -0500
References: <16445.1966.74416.309923@neuro.alephnull.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed 25 Feb 2004 15:38:06 -0500,
   Rik Faith <faith@redhat.com> wrote:
> For the brave, I have also attached a small user-space test program and
> pseudo-daemon (it logs to stdout).  No man pages, but some online help.
> E.g., you can try:
>     Window 1:
>         ./auditd
>     Window 2 (you don't have to have the daemon running to try this, but
>     enabled has to be 1):
>         ./auditctl -s
>         ./auditctl -a entry,always -S open
>         ls
>         ./auditctl -d entry,always -S open

The tarball was missing a file, so there is a new version available:
    http://people.redhat.com/faith/audit/auditd-0.2b.tar.gz

Also, to build the example program, you have to pass the location of the
patched kernel headers to configure, e.g.:

    ./configure --with-audith=/wrk/selinux/linux-2.6.3/include

Where "/wrk/selinux/linux-2.6.3/include" is the path to the audit.h
file.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
