Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA00164
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 12:03:20 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA00095
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 16:02:11 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id QAA00091
	for <selinux@tycho.nsa.gov>; Mon, 26 Aug 2002 16:02:09 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: devfs_t vs device_t
Date: Mon, 26 Aug 2002 18:03:04 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0208260729030.10972-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0208260729030.10972-100000@raven>
MIME-Version: 1.0
Message-Id: <20020826160304.CCE6D6B13@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 26 Aug 2002 13:32, Stephen Smalley wrote:
> On Mon, 26 Aug 2002, Russell Coker wrote:
> > I have created a new test policy tree with no devfs_t and which uses
> > device_t for /dev in both devfs and non-devfs.  I have it working on
> > three machines without any problems (apart from the need to change to
> > permissive mode before the install of the new policy and reboot
> > afterwards).
> >
> > Steve, please let me know what you think of this idea.
>
> I'm in favor of such a change.

OK, I'll send you a suitable patch as soon as you have decided on what 
patches you will accept from the ones I emailed you yesterday.  Then I'll 
send you a patch that applies on top of it.

> > As an aside, for future upgrade paths I have been considering a mechanism
> > for a policy snippet to be inserted in the running policydb but not in
> > the policydb that is loaded from disk at boot time, so therefore you can
> > have some temporary rules for running programs that will disappear at
> > reboot time. Of course it would be a bad idea to run for weeks or months
> > in such a state, but it could be very handy if you want to install a new
> > policy now and then schedule a reboot at 8PM to take care of any
> > left-over processes.
>
> Yes, this would likely be useful.

OK.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
