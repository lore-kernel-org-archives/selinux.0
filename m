Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1IYNXZ028719
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 13:34:23 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1IX2CC023689
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 18:33:02 GMT
Date: Mon, 1 Nov 2004 18:23:06 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Colin Walters <walters@verbum.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>
Subject: Re: dynamic context transitions
Message-ID: <20041101182306.GA9643@lkcl.net>
References: <4182959B.4080503@trustedcs.com> <20041029211809.GJ8897@lkcl.net> <20041030090603.GK8897@lkcl.net> <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil> <20041101141025.GZ8897@lkcl.net> <1099327507.408.0.camel@decepticon.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099327507.408.0.camel@decepticon.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 01, 2004 at 11:45:07AM -0500, Colin Walters wrote:
> On Mon, 2004-11-01 at 14:10 +0000, Luke Kenneth Casson Leighton wrote:
> 
> >  and also would it be possible to use this proposal to track
> >  what famd does, too?
> > 
> > 	 [reminder: famd doesn't spawn per-user processes to
> > 	  see what files need monitoring on a per-user basis,
> > 	  it uses seteuid instead, just like samba (or maybe
> > 	  setfsuid)].
> 
> We've already fixed famd by replacing it with a per-user daemon:
> http://www.gnome.org/~veillard/gamin/
 
 yes, sorry colin, i didn't make it clear that i was aware of
 that: the reason i mentioned famd was because people would be aware of
 the reasons why famd was abandoned.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
