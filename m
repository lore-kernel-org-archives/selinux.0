Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA07608
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 06:29:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA27528
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 10:27:46 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id KAA27524 for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 10:27:46 GMT
Date: Wed, 9 Oct 2002 12:29:35 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: Apache 2 file contexts
Message-ID: <20021009122935.B18828@lemuria.org>
References: <20021008160033.A5253@lemuria.org> <200210081906.13285.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200210081906.13285.russell@coker.com.au>; from russell@coker.com.au on Tue, Oct 08, 2002 at 07:06:13PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 08, 2002 at 07:06:13PM +0200, Russell Coker wrote:
> Good work!  You not only got it working with apache2 but fixed a couple of 
> things I missed in getting it to work properly with Debian!

Thought so, but I wasn't sure. :)


> If you'd like to make Apache your thing then you could start working on the 
> policy for Apache, there's quite a few things that could be improved.  For 
> starters a set of macros for different features commonly used with Apache 
> would be good.  Something like define(`apache_php') for using PHP, etc would 
> be really handy to have.  Also we'll probably need support for multiple user 
> domains for cgi-bin scripts.

I will definitely work further on Apache, especially the PHP/CGI part
and interaction with proftpd (so users can upload stuff and it
automatically gets the right types).


> Anyway I've updated my tree with the equivalent code to your patch (I've 
> changed the order a bit but it's essentially what you wrote).  I'll send in a 
> patch to Steve tomorrow.
> 
> > + /etc/vhosts                   system_u:object_r:httpd_config_t
> 
> What is /etc/vhosts?  I've never used Apache2...

I have no idea, actually. I've just started working with Apache2. I
will find out soon, though, and then decide if it warrants its own
type.
(I know for sure that it's part of Apache2)


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
