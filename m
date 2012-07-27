Message-ID: <1343396040.17570.9.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] Support for sebool in seapp_contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: William Roberts <w.roberts@sta.samsung.com>,
        "selinux@tycho.nsa.gov"
	 <selinux@tycho.nsa.gov>
Date: Fri, 27 Jul 2012 09:34:00 -0400
In-Reply-To: <CAFftDdrJNDh=kNdHFiJ1xRDRed-JujhQfbhWusJC_RpmHR6j0A@mail.gmail.com>
References: <1343330131-11754-1-git-send-email-w.roberts@sta.samsung.com>
	 <1343330962.5186.21.camel@moss-pluto.epoch.ncsc.mil>
	 <E24EB765E1998A40A0C06DE52672C4820176F6C8A5F5@staex7mb1.telecom.sna.samsung.com>
	 <1343333073.5186.25.camel@moss-pluto.epoch.ncsc.mil>
	 <CAFftDdrJNDh=kNdHFiJ1xRDRed-JujhQfbhWusJC_RpmHR6j0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-07-26 at 13:30 -0700, William Roberts wrote:
> In general I would like to add this feature. I think it is much more
> palatable checking for denials and errors with the device "working",
> rather then having it freak out at the splash screen. For instance,
> suppose the launcher isn't in the right domain, you fix that, just to
> find out some other app luanched off the launcher would fail too. If
> you could just audit, you could review the denials and then make your
> policy change in one movement.
> 
> Just doing it for sebool doesn't make sense to me, as adding the
> boolean rule is no different than seinfo or other rules. Either it
> matches or not.

Understood.  But here's the counterargument.  Let's suppose I am testing
my system in permissive mode, looking for avc denials in my dmesg and
logcat output (the latter for zygote denials), and everything looks ok.
Now I switch to enforcing mode and suddenly find that all apps fail to
launch because there was an error in my seapp_contexts configuration.  I
never thought to look for other kinds of error messages while in
permissive mode (and SEAndroidManager won't currently show me these
other messages).  And now I can't switch back to permissive mode without
going to ADB because I can't even run my SEAndroidManager app to set it.
See the concern?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
