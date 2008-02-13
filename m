Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1DHIwWC021347
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 12:18:58 -0500
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1DHIvNg028278
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 17:18:58 GMT
Received: by fg-out-1718.google.com with SMTP id 16so45763fgg.40
        for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 09:18:56 -0800 (PST)
Message-ID: <cadfc0e40802130852m46a6930ag396ed655d54c88b4@mail.gmail.com>
Date: Wed, 13 Feb 2008 10:52:45 -0600
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

libselinux from SVN? Is this change not in rawhide?

>  an updated refpolicy (or just add "getattr" and "setattr" permissions to
>  your x_property class and tweak the x_contexts file to add poly_property
>  notations).  I'll push it into the master branch next week unless I get
>  any feedback directing otherwise.
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
