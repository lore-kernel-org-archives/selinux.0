Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA07155
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 04:04:09 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA09112
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 08:02:30 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id IAA09104
	for <selinux@tycho.nsa.gov>; Wed, 9 Oct 2002 08:02:29 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: Apache 2 file contexts
Date: Tue, 8 Oct 2002 19:06:13 +0200
References: <20021008160033.A5253@lemuria.org>
In-Reply-To: <20021008160033.A5253@lemuria.org>
MIME-Version: 1.0
Message-Id: <200210081906.13285.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 8 Oct 2002 16:00, Tom wrote:
> Having just installed Apache 2 (from the sid Debian packages) on my
> SELinux test system, I found that it works flawless once some additions
> to the apache.fc file have been made. Here's a preliminary patch, I
> haven't yet experimented with CGIs, vhosts and SSL:

Good work!  You not only got it working with apache2 but fixed a couple of 
things I missed in getting it to work properly with Debian!

If you'd like to make Apache your thing then you could start working on the 
policy for Apache, there's quite a few things that could be improved.  For 
starters a set of macros for different features commonly used with Apache 
would be good.  Something like define(`apache_php') for using PHP, etc would 
be really handy to have.  Also we'll probably need support for multiple user 
domains for cgi-bin scripts.

Apache policy would be a starter project for someone who wants to get 
seriously involved in SE Linux (I think that you do).  The Apache policy was 
written in the early days and hasn't benefited from the re-writes that have 
covered most of the other policy.  I haven't done anything serious with it as 
it's functional enough that I was not forced to, but ugly enough that I 
didn't want to...

Anyway I've updated my tree with the equivalent code to your patch (I've 
changed the order a bit but it's essentially what you wrote).  I'll send in a 
patch to Steve tomorrow.

> + /etc/vhosts                   system_u:object_r:httpd_config_t

What is /etc/vhosts?  I've never used Apache2...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
