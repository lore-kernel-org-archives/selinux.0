Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1Gj6XZ027558
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 11:45:06 -0500 (EST)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1GheCC011446
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 16:43:45 GMT
Subject: Re: dynamic context transitions
From: Colin Walters <walters@verbum.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <20041101141025.GZ8897@lkcl.net>
References: <4182959B.4080503@trustedcs.com>
	 <20041029211809.GJ8897@lkcl.net> <20041030090603.GK8897@lkcl.net>
	 <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil>
	 <20041101141025.GZ8897@lkcl.net>
Content-Type: text/plain
Date: Mon, 01 Nov 2004 11:45:07 -0500
Message-Id: <1099327507.408.0.camel@decepticon.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-01 at 14:10 +0000, Luke Kenneth Casson Leighton wrote:

>  and also would it be possible to use this proposal to track
>  what famd does, too?
> 
> 	 [reminder: famd doesn't spawn per-user processes to
> 	  see what files need monitoring on a per-user basis,
> 	  it uses seteuid instead, just like samba (or maybe
> 	  setfsuid)].

We've already fixed famd by replacing it with a per-user daemon:
http://www.gnome.org/~veillard/gamin/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
