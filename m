Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8F1YRLa009192
	for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2003 21:34:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8F1YQmw022142
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 01:34:26 GMT
Received: from out006.verizon.net (out006pub.verizon.net [206.46.170.106])
        by jazzband.ncsc.mil  with ESMTP id h8F1YQ9d022139 for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 01:34:26 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Bill Laut <wlsel@verizon.net>
To: russell@coker.com.au, trelane@digitasaru.net, selinux@tycho.nsa.gov
Subject: Re: New Potential Research Area for SELinux
Date: Sun, 14 Sep 2003 21:35:18 -0400
References: <20030914043007.GD5651@digitasaru.net> <200309141651.42416.russell@coker.com.au>
In-Reply-To: <200309141651.42416.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200309142135.18546.wlsel@verizon.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 14 September 2003 02:51 am, Russell Coker wrote:
> On Sun, 14 Sep 2003 14:30, Joseph Pingenot wrote:
> >
> > [...]
>
> > Hope I'm not too far off my rocker; I think this would be an excellent
> >   system for running untrusted code (or even "trusted" code. ;)  Examples
> >   which immediately come to mind are executable email attachments and
> >   networked collaboration/p2p environments (part of my netshard project,
>
> Regular SE Linux functionality should be enough for such things IMHO.  Why
> do you think you need more than a separate domain for such untrusted code?
>
> The biggest problem we have at the moment (IMHO) is that Security Enhanced
> X isn't implemented yet.
>

SE-X is something I'm working on as time permits, based on the current XFree86 
v4.3.0.  I'm hoping to have an initial draft of an implementation strategy I 
can publish on the mailing list sometime towards the end of September to 
middle of October, with the desire that all mailing list participants 
critically review it for completeness and/or security loopholes.

Bill


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
