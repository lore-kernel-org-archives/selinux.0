Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA00640
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 14:00:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA16824
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 17:59:55 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id RAA16820
	for <selinux@tycho.nsa.gov>; Mon, 12 Aug 2002 17:59:54 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: James Morris <jmorris@intercode.com.au>
Subject: Re: depmod errors
Date: Mon, 12 Aug 2002 20:00:41 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Mutt.LNX.4.44.0208130031040.8983-100000@blackbird.intercode.com.au>
In-Reply-To: <Mutt.LNX.4.44.0208130031040.8983-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Message-Id: <20020812180042.84B41860B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 12 Aug 2002 16:31, James Morris wrote:
> On Sun, 11 Aug 2002, Russell Coker wrote:
> > I've got a depmod error building 2.4.19 with the latest patch when I
> > enabled labelled networking.
> >
> > root@test:/usr/src# depmod -a -e
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.19lsm/kernel/security/selinux/selopt/selopt.o
> > depmod:         nsid_register_ops
> > depmod:         nsid_unregister_ops
> > root@test:/usr/src#
> >
> > I've attached my .config.
>
> It should be working.  What happens if you boot into the kernel, then
> manually insmod selopt.o?  (may provide more information).

It works.  Running depmod after booting the machine works too.

Running depmod after installing the kernel without booting is something 
that's expected to not work (must have been too late at night).  But it also 
gave an error in the kernel build process (Debian kernel build scripts run 
depmod).

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
