Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3M8SU7C014391
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 04:28:30 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3M8KZrf022052
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 08:20:36 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com
Subject: Re: Tweaks to the clamav policy
Date: Fri, 22 Apr 2005 18:23:32 +1000
Cc: David Hampton <hampton-rh@rainbolthampton.net>, selinux@tycho.nsa.gov
References: <1110979071.20316.17.camel@hampton-pc.rainbolthampton.net>
In-Reply-To: <1110979071.20316.17.camel@hampton-pc.rainbolthampton.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504221823.35789.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 17 March 2005 00:17, David Hampton 
<hampton-rh@rainbolthampton.net> wrote:
> I've added support to the (unused) clamav policy to allow listening for
> service requests on a TCP socket, and for interacting with amavis.  I
> also made some tweaks that  tighten up the network access allowed by
> freshclam, split the freshclam and spamd log files into two different
> types, and make the clamd control socket a unique type.  Thanks.

Another thing, please don't add new _sock_t types.  Among other things you 
didn't give it the pidfile attribute to mark it as something that init 
scripts can unlink.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
