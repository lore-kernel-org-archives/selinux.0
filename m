Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i83EY9rT007809
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 10:34:10 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i83EY9UQ021242
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 14:34:09 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id i83EYcMS028774
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 10:34:38 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id i83EYchU028773
	for selinux@tycho.nsa.gov; Fri, 3 Sep 2004 10:34:38 -0400
Date: Thu, 2 Sep 2004 12:07:34 -0500
To: Russell Coker <russell@coker.com.au>
Cc: fedora-selinux-list@redhat.com, Nigel Kukard <nkukard@lbsd.net>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: [OT] SELinux vs. other systems [was Re: [idea] udev + selinux]
Message-ID: <20040902170734.GA9645@austin.ibm.com>
References: <20040830173744.GD10151@lbsd.net> <20040831191809.GC4375@lkcl.net> <20040831224447.GA4964@austin.ibm.com> <200409022215.20830.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409022215.20830.russell@coker.com.au>
From: Linas Vepstas <linas@austin.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 02, 2004 at 10:15:20PM +1000, Russell Coker was heard to remark:
> On Wed, 1 Sep 2004 08:44, Linas Vepstas <linas@austin.ibm.com> wrote:
> > Every now and then, I look at SELinux, and I get scared away by its
> > complexity.  This complexity makes it very hard to audit, and assure
> 
> What auditing are you referring to?  Kernel code, application code, or policy?

policy.
 
> > oneself that its actually providing any real security, as opposed to
> > the illusion of security.  During this email thread, there are
> > references to mysterious rules that neither party in the conversation
> > fully understands; this scares me.
> 
> Which mysterious rules are you referring to?

I wasn't refering to them, the posters to the thread were.  Unfortunately,
I've already deleted those emails.

> labelled as device_t.  This means that there is no window of opportunity for 
> an attacker to access a device before it is correctly labelled.

OK.

Well, here's another idle question, again off-topic: Does SELinux provide 
any sort of assurances that storage media weren't tampered with between
reboots?  

For example, with BIOS/firmware getting more sophisticated over time,
there's potential for an attacker to break in, remotely, into
bios/firmware, shortly before booting into the OS, and then alter 
disk contents.  Yes, I know this is far-fetched, but was just curious.

What got me going on that thread was thinking about udev/hotplug again:
with devices coming and going, disappearing and re-appearing, it isn't
obvious that there wasn't tampering while the device was gone. 

Again, excuse me if this sounds naive, un-informed or far-fetched, 
or terribly off-topic, but: In ye olden days, viruses spread through 
diskettes.   These days, we're plugging-n-playing usb keychains,
cameras, ipods, bluetooth this-n-that; although I haven't heard of 
attacks carried out through these media, its not obivious that these
couldn't be carriers for an attack.

--linas

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
