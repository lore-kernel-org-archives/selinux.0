Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA16231
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 09:06:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA25635
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 14:03:30 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA25631
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 14:03:29 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: PHP and other CGI stuff
Date: Mon, 20 Jan 2003 15:05:47 +0100
References: <20030120141112.B29104@lemuria.org>
In-Reply-To: <20030120141112.B29104@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301201505.47688.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 20 Jan 2003 14:11, Tom wrote:
> I was planning to have really seperated domains for virtual hosting,
> which means each PHP process should run in its own domain, e.g. dom1
> for user 1, dom2 for user 2, etc.

I looked into that some time ago but discovered that PHP didn't work the same 
when invoked as an external process.  When run by the php-cgi method it would 
not correctly support IMP (the only PHP software I really care about).

Due to this I was unable to determine a better solution than to have a 
seperate instance of Apache for every separate PHP domain.  This consumes 
extra resources, but generally you don't have that many PHP customers...

> How would I go about this? I've successfully added a new user (the
> second_user comments are really helpful here), but I can't get the
> domain macro set up correctly. This is probably caused by me being
> unable to use suexec_domain($1), because this violates some assertions
> for the sysadm_r and others.

second_user is designed for someone who can login via ssh, read mail with 
mutt, etc.  For a different domain for web processes we need something a bit 
different.  Some of the various options have been discussed here over the 
last 18 months, but nothing has been done because the Apache policy basically 
works, and is complex enough that no-one really wants to do a serious 
re-write.

I think that the entire way that Apache operates should be reviewed in light 
of the way things are currently working in SE Linux policy and the usage of 
typical systems.  Many things have changed since the Apache policy was 
written, it's a bit of a dinosaur.

> I haven't found much documentation on the whole user management stuff,
> but if I missed something, please point it out to me.

Yes, we need some documentation on multiple user roles.  I briefly covered it 
in my tutorial at L-K, but we probably need something easier to understand 
than my L-K notes.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
