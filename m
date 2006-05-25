Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4P581AN023030
	for <selinux@tycho.nsa.gov>; Thu, 25 May 2006 01:08:01 -0400
Received: from mail7.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4P5809h029665
	for <selinux@tycho.nsa.gov>; Thu, 25 May 2006 05:08:01 GMT
Date: Thu, 25 May 2006 01:07:57 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Russell Coker <russell@coker.com.au>
cc: SE-Linux <selinux@tycho.nsa.gov>,
        Shintaro Fujiwara <shin216@xf7.so-net.ne.jp>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: daemons and MCS categories
In-Reply-To: <200605220930.05483.russell@coker.com.au>
Message-ID: <Pine.LNX.4.64.0605250105520.15655@d.namei>
References: <200605220930.05483.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 22 May 2006, Russell Coker wrote:

> Another possibility is to have the ability to configure which categories are 
> assigned to a daemon via run_init or some similar program.  It would not be 
> difficult to read a config file that maps the domain of a daemon to the range 
> that should be granted to it.

I think the latter is a better idea if this is going to be done, rather 
than imposing semantics in the MCS categories.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
