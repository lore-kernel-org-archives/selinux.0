Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7GMGYrT010190
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2004 18:16:34 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7GMFsqL027896
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2004 22:15:54 GMT
Date: Mon, 16 Aug 2004 23:27:07 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: 265920@bugs.debian.org
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Bug#265920 acknowledged by developer (Re: Bug#265920: kdm 3.3 is deleting /var/run/xdmctl (causes problem under selinux))
Message-ID: <20040816222707.GG18321@lkcl.net>
References: <20040816193813.GA24520@chistera.yi.org> <E1BwPrf-0002ZQ-RX@lkcl.net> <handler.265920.D265920.109268509825661.notifdone@bugs.debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <handler.265920.D265920.109268509825661.notifdone@bugs.debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi there adeodato,

then this needs to be made the default behaviour in the kdm package!

it is unfortunately unreasonable to expect ordinary
people using SE/Linux to go editing policy files, creating
/var/run/xdmctl/.keep or to edit anything in /etc/kde3 at all.

you are of course entitled to close this bug however you may wish to
remain aware that as the number of Debian / SE/Linux / KDE users goes
up, the number of reports of problems like "i upgraded and now i can't log
in" will also go up.

it is fortunate that i was able to track this because i understand
SE/Linux.

other users will not be so fortunate: they will likely give up, or
worse, do something horrible to their SE/Linux policy files.

l.



On Mon, Aug 16, 2004 at 12:48:10PM -0700, Debian Bug Tracking System wrote:
> This is an automatic notification regarding your Bug report
> #265920: kdm 3.3 is deleting /var/run/xdmctl (causes problem under selinux),
> which was filed against the kdm package.
> 
> It has been closed by one of the developers, namely
> Adeodato =?iso-8859-1?Q?Sim=F3?= <asp16@alu.ua.es>.
> 
> Their explanation is attached below.  If this explanation is
> unsatisfactory and you have not received a better one in a separate
> message then please contact the developer, by replying to this email.
> 
> Debian bug tracking system administrator
> (administrator, Debian Bugs database)
> 
> Received: (at 265920-done) by bugs.debian.org; 16 Aug 2004 19:38:18 +0000
> >From asp16@alu.ua.es Mon Aug 16 12:38:18 2004
> Return-path: <asp16@alu.ua.es>
> Received: from 84-120-64-227.onocable.ono.com (chistera.yi.org) [84.120.64.227] 
> 	by spohr.debian.org with esmtp (Exim 3.35 1 (Debian))
> 	id 1BwnJC-0006fL-00; Mon, 16 Aug 2004 12:38:18 -0700
> Received: from userid 1000 by chistera.yi.org with local (Exim 4.34) 
> 	  id 1BwnJ8-0006Nq-0R; Mon, 16 Aug 2004 21:38:14 +0200
> Date: Mon, 16 Aug 2004 21:38:14 +0200
> From: Adeodato =?iso-8859-1?Q?Sim=F3?= <asp16@alu.ua.es>
> To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
> 	265920-done@bugs.debian.org
> Subject: Re: Bug#265920: kdm 3.3 is deleting /var/run/xdmctl (causes problem under selinux)
> Message-ID: <20040816193813.GA24520@chistera.yi.org>
> References: <E1BwPrf-0002ZQ-RX@lkcl.net>
> Mime-Version: 1.0
> Content-Type: text/plain; charset=iso-8859-1
> Content-Disposition: inline
> Content-Transfer-Encoding: 8bit
> In-Reply-To: <E1BwPrf-0002ZQ-RX@lkcl.net>
> X-No-CC: Please respect my Mail-Followup-To header
> User-Agent: Mutt/1.5.6+20040810i
> Delivered-To: 265920-done@bugs.debian.org
> X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2004_03_25 
> 	(1.212-2003-09-23-exp) on spohr.debian.org
> X-Spam-Status: No, hits=-4.8 required=4.0 tests=BAYES_00,FROM_ENDS_IN_NUMS,
> 	HAS_BUG_NUMBER autolearn=no version=2.60-bugs.debian.org_2004_03_25
> X-Spam-Level: 
> 
> * Luke Kenneth Casson Leighton [Sun, 15 Aug 2004 19:36:19 +0100]:
> 
> > the directory is being deleted and recreated.
> 
> > whilst this makes it nice and easy for dealing with sockets in it,
> > it makes for an impossible situation for selinux.
> 
> > the issue is that kdm will have to be given both unlink and write access
> > to /var/run, in order for /var/run/xdmctl to be deleted and recreated.
> 
> > neither of these things are desirable.
> 
> > this behaviour was not present in kdm 3.2.X.
> 
>   you have two options:
> 
>     # touch /var/run/xdmctl/.keep
> 
>   kdm will refrain from unlinking the directory, then (checked).
> 
>   set, in /etc/kde3/kdm/kdmrc, FifoDir to some directory which you don't
>   mind being created and unlinked on each kdm start-stop cycle. e.g.
>   FifoDir=/tmp/xdmctl.
> 
>   I'm closing this bug, since I can't see why at least one of these
>   options won't work for you.
> 
>   thanks, and please write back if this doesn't solve your problem,
> 
> -- 
> Adeodato Sim?
>     EM: asp16 [ykwim] alu.ua.es | PK: DA6AE621
>  
> Hanlon's Razor: Never attribute to malice that which is adequately
> explained by stupidity.
> 

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
