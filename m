Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1FErRe3020256
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 09:53:27 -0500
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1FErQ31023881
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 14:53:26 GMT
Received: by fg-out-1718.google.com with SMTP id 16so445170fgg.40
        for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 06:53:16 -0800 (PST)
Message-ID: <cadfc0e40802150653q54e1bec9m3437e0a68af36f4f@mail.gmail.com>
Date: Fri, 15 Feb 2008 08:53:15 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Subject: Re: X avcs
Cc: "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <47ACEB0C.4030201@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40712261301l3765f85fyc813a6ccfb262e3b@mail.gmail.com>
	 <47867FCA.50408@tycho.nsa.gov> <47878130.5010000@gmail.com>
	 <4787D5B7.9090606@sun.com> <478FD1A7.8060401@tycho.nsa.gov>
	 <4793FDC7.9050700@sun.com> <4797D7CB.6010501@tycho.nsa.gov>
	 <cadfc0e40801290748v3e02a305i8ef36f39ceef16af@mail.gmail.com>
	 <47A131D5.2030906@tycho.nsa.gov> <47ACEB0C.4030201@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Feb 8, 2008 at 5:51 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
> Eamon Walsh wrote:
>  > Xavier Toth wrote:
>  >
>  >> Has this made it into the git tree yet?
>  >>
>
>  It's pushed into the XACE-SELINUX branch, so you can play with it now.
>  I did some simple testing of the polyinstantiation and it worked OK for
>  me.  You'll need the kernel patch, an updated libselinux from SVN, and
>  an updated refpolicy (or just add "getattr" and "setattr" permissions to
>  your x_property class and tweak the x_contexts file to add poly_property
>  notations).  I'll push it into the master branch next week unless I get
>  any feedback directing otherwise.

I've been running the rawhide xserver and a patched metacity which
uses the _SELINUX_CLIENT_CONTEXT xproperty to get the context for
window labels. Because of my desire to maintain a working system I've
taken the approach of changing just one thing at a time. So I chose to
update my policy first by merging the refpolicy with the rawhide
source rpm and patch-20071130.patch. After a few issues I've built and
installed the new policy but now metacity is no longer getting a
context in _SELINUX_CLIENT_CONTEXT. I've looked around in the audit
log but nothing jumps out at me as being amiss. Any ideas on how I can
track down why this property was impacted by this new policy?

>
>  With regard to the rawhide X server, I just ran "strings" on a rawhide
>  Xorg binary and it shows SELinux extension messages.  The package has a
>  date of Jan 7 in the version number.  So you might try compiling an X
>  server from SRPM, passing the --enable-xselinux=yes flag to the
>  configure script.  It might just work, however there have been some
>  changes since Jan 7.
>
>  --
>
>
> Eamon Walsh <ewalsh@tycho.nsa.gov>
>  National Security Agency
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
