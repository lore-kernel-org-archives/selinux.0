Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAGESjS6025855
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 09:28:45 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id kAGES2aI009826
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 14:28:02 GMT
Subject: Re: Strange file context issues
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Bradley Chapman <kakadu@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e294b46e0611160618xecaa0d9j48c47e9658cc44e5@mail.gmail.com>
References: <e294b46e0611160537p10c3224cmfecac57ac4c1f4bc@mail.gmail.com>
	 <1163686348.7374.37.camel@sgc.columbia.tresys.com>
	 <e294b46e0611160618xecaa0d9j48c47e9658cc44e5@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 09:29:11 -0500
Message-Id: <1163687352.7374.39.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-16 at 14:18 +0000, Bradley Chapman wrote:
> On 11/16/06, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> > Are you using udev?  If you have udev and static device nodes under them
> > on the regular fs, those are probably mislabeled.  Anything trying to
> > use them early in the boot process before udev is started would hit
> > denials like this.  Relabeling wouldn't get them since they're covered
> > up by udev's tmpfs.  You'd have to unmount the tmpfs to relabel them.
> 
> Ahhhh. All is made clear now. I am indeed using udev on this machine.
> Would it be best to turn it off, or easier to simply switch to
> runlevel 1 and do a relabel of the root filesystem?

I would just do the latter.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
