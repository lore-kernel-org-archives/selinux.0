Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA07421
	for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 22:50:51 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id DAA24455
	for <selinux@tycho.nsa.gov>; Sat, 18 Jan 2003 03:48:05 GMT
Received: from unicorn.lemuria.org (b067140.adsl.hansenet.de [62.109.67.140])
	by jazzswing.ncsc.mil  with ESMTP id DAA24451
	for <selinux@tycho.nsa.gov>; Sat, 18 Jan 2003 03:48:04 GMT
Date: Sat, 18 Jan 2003 04:45:55 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: Cambridge Security Group talk
Message-ID: <20030118044554.A19790@lemuria.org>
References: <200301180149.27476.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200301180149.27476.russell@coker.com.au>; from russell@coker.com.au on Sat, Jan 18, 2003 at 01:49:27AM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jan 18, 2003 at 01:49:27AM +0100, Russell Coker wrote:
> One issue that drew a number of comments from the audence was the length of 
> security contexts and the amount of typing that it can involve.  One audience 
> member said "space in an Xterm is precious", another audience member 
> mentioned having three servers without X that were not administered remotely 
> (IE everything is done at the console without even an X based cut/paste 
> facility).

One partial solution (for those of us using it) would be to make bash's
"tab complete everything" feature aware of security contexts. It's
already pretty powerful (e.g. on an scp it can tab-complete remote
paths, for many programs it can tab-complete commandline parameters,
etc)

Another partial solution are aliases. For example, I have aliases for
ls --context and ps --context.


> Also an audience member asked me if it would be possible to run a machine with 
> all files and processes UID=0, which was a strange co-incidence as I have 
> been planning to do that for play machine ][ (but I may have mentioned it on 
> a mailing list or something and the word may have got around).  This idea 
> seemed to get a lot of interest from the audience, who seemed to actually 
> want to do it as a serious way of running a system (rather than as a fun 
> demonstration of the power of SE Linux).  

Well, essentially it would condense the current 2D matrix we have on
permissions back to a one-dimensional system, only along the other
axis.

It would definitely be interesting for embedded systems, consoles and
other stuff that doesn't really have very much of a user concept. For
example, the iPAQ distribution (familiar) runs everything as root
unless you install some add-on packages.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
