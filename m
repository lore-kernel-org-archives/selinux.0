Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3M86M7C014291
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 04:06:23 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3M7wPrf021542
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 07:58:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com
Subject: Re: Updates to dcc [patch]
Date: Fri, 22 Apr 2005 18:00:44 +1000
Cc: David Hampton <hampton-rh@rainbolthampton.net>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <1113514561.6056.41.camel@hampton-pc.rainbolthampton.net>
In-Reply-To: <1113514561.6056.41.camel@hampton-pc.rainbolthampton.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504221800.47811.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 15 April 2005 07:36, David Hampton <hampton-rh@rainbolthampton.net> 
wrote:
> The attached patch updates the (unused) dcc policy to work with the
> changes in the FC strict/1.23.10-2 policy.  It also makes a couple of
> tweaks to the policy

+allow initrc_t dcc_var_run_t:dir rw_dir_perms;

Use the pidfile attribute for dcc_var_run_t and you won't need that.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
