Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8BDQkNs003732
	for <selinux@tycho.nsa.gov>; Sun, 11 Sep 2005 09:26:47 -0400 (EDT)
Received: from free.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8BDOFoJ006853
	for <selinux@tycho.nsa.gov>; Sun, 11 Sep 2005 13:24:15 GMT
Date: Sat, 10 Sep 2005 20:59:36 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Petter Reinholdtsen <pere@hungry.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: (fwd) Bug#270919: Can you test a new version of sysvinit?
Message-ID: <20050910195936.GD9179@lkcl.net>
References: <20050909143142.GC27535@saruman.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050909143142.GC27535@saruman.uio.no>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 09, 2005 at 04:31:42PM +0200, Petter Reinholdtsen wrote:
> My message was rejected from the mailing list.  Perhaps you are
> interested, so I forward it directly to you.
> 
> ----- Forwarded message from Petter Reinholdtsen <pere@hungry.com> -----
> 
> X-Sieve: CMU Sieve 2.2
> Date: Thu, 8 Sep 2005 22:48:00 +0200
> From: Petter Reinholdtsen <pere@hungry.com>
> To: SE-Linux <selinux@tycho.nsa.gov>
> Bcc: Petter Reinholdtsen <petter.reinholdtsen@usit.uio.no>
> Subject: Re: [pere@hungry.com: Bug#270919: Can you test a new version of sysvinit?]
> X-UiO-Spam-info: not spam, SpamAssassin (score=-5.616, required 12,
> 	autolearn=disabled, ALL_TRUSTED -2.82, AWL 2.20,
> 	UIO_MAIL_IS_INTERNAL -5.00)
> 
> [Luke Kenneth Casson Leighton]
> > basically this simple fix - attempting "touch /etc/mtab" as a test
> > instead of "touch /etc" - stops a debian/selinux system getting into
> > deeper and deeper shit :)
> 
> The patch I applied just removed the test, it did not change it into a
> touch /etc/mtab.  Would that be a better fix?  Better patches are
> welcome. :)

 *thinks*

 this is from memory, from over six months ago when i had the
 time to look at this stuff.
 
 iirc selinux permissions are granted to initrc_t to write to
 /etc/mtab but not to /etc.

 therefore i believe it is acceptable to allow the test to be
 "touch /etc/mtab" like wot i believe i wrote in followup messages to
 bugs.debian.org.

 it's generally - no it's totally - bogus to assume that write
 permission to a directory being banned implies that files _in_ that
 directory are also banned.

 selinux allows far finer grained permissions than the out-of-date
 [20-year-old] unix filesystem permissions.


 anyway: if you think that you can get away with removing the test,
 _great_.

 l.


> ----- End forwarded message -----

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
