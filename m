Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6SEruHa016029
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 10:53:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6SEqfFB014100
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 14:52:41 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [144.51.25.14])
	by jazzswing.ncsc.mil  with ESMTP id h6SEqeGD014097
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 14:52:40 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [127.0.0.1])
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6SErhYS002683
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2003 10:53:43 -0400
Received: (from hdholm@localhost)
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h6SErg8r002681
	for selinux@tycho.nsa.gov; Mon, 28 Jul 2003 10:53:42 -0400
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6RF3nHa013100
	for <selinux@tycho.nsa.gov>; Sun, 27 Jul 2003 11:03:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6RF2eFB023936
	for <selinux@tycho.nsa.gov>; Sun, 27 Jul 2003 15:02:40 GMT
Received: from unicorn.lemuria.org (b067151.adsl.hansenet.de [62.109.67.151])
	by jazzswing.ncsc.mil  with ESMTP id h6RF2dGD023930
	for <selinux@tycho.nsa.gov>; Sun, 27 Jul 2003 15:02:40 GMT
Date: Sun, 27 Jul 2003 17:00:38 +0200
From: Tom <tom@lemuria.org>
To: Colin Walters <walters@verbum.org>
Cc: SE Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
Subject: Re: experimental SEDebian 2.5 packages
Message-ID: <20030727170038.R542@lemuria.org>
References: <1058648176.681.14.camel@columbia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1058648176.681.14.camel@columbia>; from walters@verbum.org on Sat, Jul 19, 2003 at 04:56:16PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jul 19, 2003 at 04:56:16PM -0400, Colin Walters wrote:
> Before you install these; note that I doubt I am going to have time to
> continuously keep up with all the rapid changes that happen in Debian
> unstable.  This means you have to be very careful when upgrading to
> ensure that a .selinux package isn't removed.  I recommend you put all
> the .selinux packages on hold after you've installed them.

This, btw. is true for all of them. Well, at least for sid which is
moving rapidly, but also for woody you can not GUARANTEE that a
security fix doesn't replace the package.

I've found it a good idea to put them on hold for all debian releases.


> With all that out of the way: Just put the following in your
> /etc/apt/sources.list:
> 
> deb http://web.verbum.org/debian/ experimental/
> 
> (The above URI will probably change once these packages stop being
> experimental).

If you want me to set up a mirror for this like I did for Russel and
Brian, just tell me how to best fetch them (rsync-over-ssh or
something). I'd be happy to do it.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
