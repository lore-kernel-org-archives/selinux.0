Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KKlfWt022890
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 16:47:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9KKlfmR029857
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 20:47:41 GMT
Received: from extern.mail.waldi.eu.org (wavehammer.waldi.eu.org [82.139.196.55])
        by jazzband.ncsc.mil  with ESMTP id h9KKlejp029848 for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 20:47:40 GMT
Date: Mon, 20 Oct 2003 22:47:28 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: init patch for loading policy
Message-ID: <20031020204728.GA664@wavehammer.waldi.eu.org>
References: <200310200148.15852.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200310200148.15852.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Oct 20, 2003 at 01:48:15AM +1000, Russell Coker wrote:
> I've attached a patch for /sbin/init to load the policy and set enforcing 
> mode.  Here's a quick summary of the algorithm:

isn't it easier to divert /sbin/init and use a script which loads the
policy and execs the real init after?

bastian


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
