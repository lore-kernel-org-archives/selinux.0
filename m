Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i59NgTrT023700
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 19:42:29 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i59NgQQd019873
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 19:42:26 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 9 Jun 2004 23:42:27 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BYC4j-0001df-N8
	for selinux@tycho.nsa.gov; Wed, 09 Jun 2004 23:01:41 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BYCfa-000565-Nu
	for selinux@tycho.nsa.gov; Wed, 09 Jun 2004 23:39:46 +0000
Date: Wed, 9 Jun 2004 23:39:46 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Message-ID: <20040609233946.GI5727@lkcl.net>
References: <20040609214126.GF5727@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040609214126.GF5727@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 09, 2004 at 09:41:26PM +0000, Luke Kenneth Casson Leighton wrote:
> hi,
> 
> debian's postfix init.d script does a whole stackload of
> things like copy over /etc/localtime, /etc/services.
 
 i should be more specific: in the creation of the chroot jail,
 in /var/spool/postfix, the permissions (contexts) are preserved
 and recreated (see file_contexts/programs/postfix.fc)

 i.e., in order for the /etc/init.d/postfix script to create the
 chroot jail, it is necessary to give initrd_t permissions
 sufficient to write to etc_t, amongst other things.

 the chroot jail needs a copy of /etc/localtime and /lib/libnss* and
 such-like.

 clearly from an selinux perspective, the /etc/init.d/postfix
 script cannot be an appropriate place to set up a chroot jail.

 can anyone think of a way in which this could be better achieved?

 bearing in mind that the solution must take into account that
 postfix can be run in a chroot jail or not, depending on
 an administrative decision.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
