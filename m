Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA00443
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 13:03:28 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id SAA10381
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 18:01:57 GMT
Received: from ics.com (ics.com [216.112.183.3])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id SAA10375
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 18:01:57 GMT
Message-ID: <3A62F4E8.2CC6C8E@ics.com>
Date: Mon, 15 Jan 2001 08:02:32 -0500
From: Robert Hartley <rhartley@ics.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Goal / Danger: Attack by malicious root
References: <01011516091701.13938@linux16>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Jan,

If we were to play paranoiac for a moment, we would have to assume that the application
that does the encryption would be compromised by the malicious root, and that even system
calls could be compromised by using a trace facility.

The only solution would be to either trust in the root users' lack of technical expertise,
or in their good will.

The alternative is not to allow access to your data using your crypto keys in an execution
environment you have no real control over.

Like Bennett just mentioned while I was typing this, you need assurance you have control
over the hardware.

Have you considered using something like your own bootable CD, or a Jazz/Zip drive?

Robert


Jan Petranek wrote:

> dear guys,
>
> did You consider the possibility of an malicious root attacks? In most
> Linuxdistributions, the priviliged user can read & manipulate all of the user's
> data.
>
> This is indeed a situation I find myself in today: I am working on a
> Linux-Machine in the university's computer pool. And I find my own
> (non-encrypted) home directory far too insecure to put a private key or
> something like that in here.  This is also from the point of view, that the
> root-login may be hacked on a campus site like this.
>
> So to me, there is a need of encrypting the user's data. The question of the
> key yet remains: A key like a password / passphrase is quite limited in it's
> length (by the memory of the user). A key on a medium (like a CD-ROM,
> chipcard etc.) could be longer, but still there is the demand, that it can't be read by
> somebody else (not even the superuser), when mounted /
> used by the user.
> Also, the key medium could compromise the encryption, but that is another
> problem.
>
> I'd be quite glad, if you could take this point in consideration,
>
> JanP
>
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
=  Robert Hartley                 Mail:         201 Broadway        =
=  Central Region Systems Engineer              Cambridge, MA 02139 =
=  Integrated Computer            Email:        rhartley@ics.com    =
=  Solutions, Inc.                Web Site:     www.ics.com         =
=  Tech Support: support@ics.com  Phone:        800-800-4271        =
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Visit the MotifZone (www.motifzone.org) for info on Motif!




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
