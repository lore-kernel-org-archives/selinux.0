Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5BNQOrT008014
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 19:26:27 -0400 (EDT)
Received: from ms-smtp-01.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5BNQJP2009875
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 19:26:19 -0400 (EDT)
Received: from sasami.localdomain (CPE-24-31-241-155.kc.rr.com [24.31.241.155])
	by ms-smtp-01.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id i5BNQKBm027162
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 18:26:20 -0500 (CDT)
Received: from yggdrasil.localdomain ([192.168.0.2])
	by sasami.localdomain with esmtp (Exim 4.34)
	id 1BYvPZ-000191-SN
	for selinux@tycho.nsa.gov; Fri, 11 Jun 2004 18:26:13 -0500
Received: from adric by yggdrasil.localdomain with local (Exim 4.34)
	id 1BYvPZ-0002cV-P4
	for selinux@tycho.nsa.gov; Fri, 11 Jun 2004 18:26:13 -0500
Date: Fri, 11 Jun 2004 18:26:13 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid)
Message-ID: <20040611232613.GA10019@yggdrasil.localdomain>
References: <20040609144404.GJ5477@philips.com> <20040610120344.GM5477@philips.com> <20040610215418.GR2861@lkcl.net> <200406111413.40262.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406111413.40262.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 11, 2004 at 02:13:40PM +1000, Russell Coker wrote:
> 1.12-2 has been out for a while, and yesterday I uploaded 1.12-3 which fixes 
> some issues discussed in this thread.

Speaking of which, I'm trying to install this version (new install) on
one of my Debian sid systems.  It gets through all of the interactive
policy prompting OK, but then croaks with the following messages:

   /usr/bin/checkpolicy:  loading policy configuration from policy.conf
   domains/user.te:42:ERROR 'unknown type user_xserver_tmp_t' at token ';' on line 21459:
   #line 42
   allow user_uml_t user_xserver_tmp_t:sock_file { write };
   /usr/bin/checkpolicy:  error(s) encountered while parsing configuration
   make: *** [/etc/security/selinux/policy.17] Error 1

Any idea what I need to fix here?  I've tried to sort it out myself,
but am still finding it somewhat difficult to follow...

Thanx!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
