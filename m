Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i92APLrT008080
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 06:25:21 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i92APKlM027951
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 10:25:20 GMT
Date: Sat, 2 Oct 2004 11:36:26 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: /usr/sbin/fstab-sync from HAL
Message-ID: <20041002103626.GI8507@lkcl.net>
References: <20040926195755.GH28076@lkcl.net> <200410020059.31398.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200410020059.31398.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Oct 02, 2004 at 12:59:31AM +1000, Russell Coker wrote:
> On Mon, 27 Sep 2004 05:57, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > anyone got any good ideas about what domain fstab-sync should be in?
> >
> > it's run by HAL on-demand from /etc/hal/device.d/50-fstab-sync.hal as
> > a symlink.
> 
> updfstab_t.

i'd missed out updfstab.te - thanks for alerting me to that one.  l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
