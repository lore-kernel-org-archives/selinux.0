Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7GMCOrT010165
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2004 18:12:24 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7GMBhqL027775
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2004 22:11:44 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id 680D9BF9C
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2004 23:12:19 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 08649-01-3 for <selinux@tycho.nsa.gov>;
	Mon, 16 Aug 2004 23:12:16 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 8C7E6BF85
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2004 23:12:16 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BwpsV-0005TQ-Dy
	for selinux@tycho.nsa.gov; Mon, 16 Aug 2004 23:22:55 +0100
Date: Mon, 16 Aug 2004 23:22:55 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: [owner@bugs.debian.org: Bug#265920 acknowledged by developer (Re: Bug#265920: kdm 3.3 is deleting /var/run/xdmctl (causes problem under selinux))]
Message-ID: <20040816222255.GF18321@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

okay, there's a way to "keep" the directory...


----- Forwarded message from Debian Bug Tracking System <owner@bugs.debian.org> -----

Envelope-to: lkcl@localhost
Delivery-date: Mon, 16 Aug 2004 22:42:09 +0100
X-Sieve: CMU Sieve 2.2
From: Debian Bug Tracking System <owner@bugs.debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Bug#265920 acknowledged by developer
         (Re: Bug#265920: kdm 3.3 is deleting /var/run/xdmctl (causes problem under selinux))
X-Debian-PR-Message: they-closed 265920
X-Debian-PR-Package: kdm
X-Debian-PR-Keywords: 
Reply-To: 265920@bugs.debian.org
X-Virus-Scanned: by amavisd-new-20030616-p7 (Debian) at hands.com

This is an automatic notification regarding your Bug report
#265920: kdm 3.3 is deleting /var/run/xdmctl (causes problem under selinux),
which was filed against the kdm package.

It has been closed by one of the developers, namely
Adeodato =?iso-8859-1?Q?Sim=F3?= <asp16@alu.ua.es>.

Their explanation is attached below.  If this explanation is
unsatisfactory and you have not received a better one in a separate
message then please contact the developer, by replying to this email.

Debian bug tracking system administrator
(administrator, Debian Bugs database)

Received: (at 265920-done) by bugs.debian.org; 16 Aug 2004 19:38:18 +0000
>From asp16@alu.ua.es Mon Aug 16 12:38:18 2004
Return-path: <asp16@alu.ua.es>
Received: from 84-120-64-227.onocable.ono.com (chistera.yi.org) [84.120.64.227] 
	by spohr.debian.org with esmtp (Exim 3.35 1 (Debian))
	id 1BwnJC-0006fL-00; Mon, 16 Aug 2004 12:38:18 -0700
Received: from userid 1000 by chistera.yi.org with local (Exim 4.34) 
	  id 1BwnJ8-0006Nq-0R; Mon, 16 Aug 2004 21:38:14 +0200
Date: Mon, 16 Aug 2004 21:38:14 +0200
From: Adeodato =?iso-8859-1?Q?Sim=F3?= <asp16@alu.ua.es>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
	265920-done@bugs.debian.org
Subject: Re: Bug#265920: kdm 3.3 is deleting /var/run/xdmctl (causes problem under selinux)
Message-ID: <20040816193813.GA24520@chistera.yi.org>
References: <E1BwPrf-0002ZQ-RX@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1BwPrf-0002ZQ-RX@lkcl.net>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.6+20040810i
Delivered-To: 265920-done@bugs.debian.org
X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2004_03_25 
	(1.212-2003-09-23-exp) on spohr.debian.org
X-Spam-Status: No, hits=-4.8 required=4.0 tests=BAYES_00,FROM_ENDS_IN_NUMS,
	HAS_BUG_NUMBER autolearn=no version=2.60-bugs.debian.org_2004_03_25
X-Spam-Level: 

* Luke Kenneth Casson Leighton [Sun, 15 Aug 2004 19:36:19 +0100]:

> the directory is being deleted and recreated.

> whilst this makes it nice and easy for dealing with sockets in it,
> it makes for an impossible situation for selinux.

> the issue is that kdm will have to be given both unlink and write access
> to /var/run, in order for /var/run/xdmctl to be deleted and recreated.

> neither of these things are desirable.

> this behaviour was not present in kdm 3.2.X.

  you have two options:

    # touch /var/run/xdmctl/.keep

  kdm will refrain from unlinking the directory, then (checked).

  set, in /etc/kde3/kdm/kdmrc, FifoDir to some directory which you don't
  mind being created and unlinked on each kdm start-stop cycle. e.g.
  FifoDir=/tmp/xdmctl.

  I'm closing this bug, since I can't see why at least one of these
  options won't work for you.

  thanks, and please write back if this doesn't solve your problem,

-- 
Adeodato Sim?
    EM: asp16 [ykwim] alu.ua.es | PK: DA6AE621
 
Hanlon's Razor: Never attribute to malice that which is adequately
explained by stupidity.


----- End forwarded message -----

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
