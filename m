Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA08567
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 11:27:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA20360
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 15:26:36 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA20356
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 15:26:35 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: type_change rules
Date: Mon, 19 Aug 2002 17:27:26 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0208190900150.14458-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0208190900150.14458-100000@raven>
MIME-Version: 1.0
Message-Id: <20020819152726.B3533267@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 19 Aug 2002 15:04, Stephen Smalley wrote:
> On Mon, 19 Aug 2002, Russell Coker wrote:
> > In my case it appears that login exec's the user's shell and is gone from
> > memory.
> >
> > So it seems that to get this working correctly I need some changes to the
> > login program to make it hang around (as login programs apparently do in
> > other distributions), and I need to make sure that the SAK is blocked
> > from killing the login process.
>
> If compiled with PAM support, the util-linux login forks a child process
> that waits for the user shell to exit and then cleans up the session
> (including relabeling the tty back to its original SID, with the SELinux
> patch).

I'll have to look into that.  Debian is using the shadow utils login which is 
different.

> > rc scripts aren't involved.  Doing it in init is ugly.  Changing getty
> > means changing 4 getty programs that I use on machines I run (and more
> > getty programs for a comprehensive solution).  I don't think that this is
> > the real fix.
>
> I think it is.  Keep in mind that the same issue arises for the Linux
> ownership and modes on ttys, and that this must be addressed somewhere in
> getty or init.  But I concede that it may be a lot of work to support all
> getty programs.

I think it's simply impractical to change all getty programs.  I think that 
the solution is a wrapper that either:
1)  Relabels the tty device based on a config file or command line parameter 
and then exec's the real getty.
2)  Monitors the real getty and changes the SID back after that session 
finishes.

Option 2 was what I first thought of, but it means more processes, and 
there's the issue that init writes the PID to the utmp file (and code to 
manage utmp is a PITA to write).

I'll probably implement option 1 some time this week.  I think it'll make a 
useful addition to selinux-small, I can imagine other uses for such a program 
as well.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
