Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0TFmbnJ016187
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 10:48:37 -0500
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0TFmatk009387
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 15:48:37 GMT
Received: by fg-out-1718.google.com with SMTP id 16so1976020fgg.40
        for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 07:48:36 -0800 (PST)
Message-ID: <cadfc0e40801290748v3e02a305i8ef36f39ceef16af@mail.gmail.com>
Date: Tue, 29 Jan 2008 09:48:35 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Subject: Re: X avcs
Cc: "Glenn Faden" <Glenn.Faden@sun.com>, "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <4797D7CB.6010501@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40712261301l3765f85fyc813a6ccfb262e3b@mail.gmail.com>
	 <cadfc0e40712281326k31e9238ci8604298596ade04d@mail.gmail.com>
	 <cadfc0e40801020711w1e3a3a2dv422280f1f9d9595d@mail.gmail.com>
	 <477BEFF1.2090507@sun.com> <47867FCA.50408@tycho.nsa.gov>
	 <47878130.5010000@gmail.com> <4787D5B7.9090606@sun.com>
	 <478FD1A7.8060401@tycho.nsa.gov> <4793FDC7.9050700@sun.com>
	 <4797D7CB.6010501@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Has this made it into the git tree yet?

On Jan 23, 2008 6:11 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
>
> Glenn Faden wrote:
> > Eamon Walsh wrote:
> >
> >>
> >> OK, I worked on this today.  The property polyinstantiation itself is
> >> easy enough, but I've run into a problem with the PropertyNotify
> >> events that occur when a polyinstantiated property is changed or
> >> deleted - everyone can see them!  Some major changes to the event
> >> delivery model are probably going to be necessary to make this work.
> >>
> >> I can't immediately see how it's done in Trusted Extensions.  In
> >> TsolDeleteProperty there is just a regular DeliverEvents call to send
> >> the event.
> >>
> >> I think there will have to be a way to pass some private data down
> >> with all events, and then have another hook call further down that
> >> gives a yes/no answer for each client.
> >>
> > You're probably right that unnecessary PropertyNotify events may be
> > distributed to any client who has expressed interest in this event on
> > the root window. I don't think this is a big problem, however. If the
> > client cares to read the property whose atom is associated with the
> > event it will get the value which matches its security context.
> >
> > If your concern is that this presents a covert channel, that is an issue
> > that we generally ignore. For example we don't prevent higher-level
> > windows from generating exposure events which may be delivered to lower
> > level windows. We only prevent normal clients from mapping windows into
> > a Trusted Path workspace.
> >
> > --Glenn
> >
>
> I'll press forward with this then, putting the event delivery on the
> to-do list.
>
>
>
> --
> Eamon Walsh <ewalsh@tycho.nsa.gov>
> National Security Agency
>
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
