Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9A5rUWt000955
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 01:53:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9A5rTUb023626
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 05:53:29 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9A5rShX023609 for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 05:53:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: init
Date: Fri, 10 Oct 2003 15:53:20 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200310080111.50210.russell@coker.com.au> <1065708008.8181.219.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1065708008.8181.219.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310101553.20047.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 10 Oct 2003 00:00, Stephen Smalley wrote:
> While I'm willing to concede the point, I would like to note that
> performing the policy load from an initrd (or initramfs) has the
> advantage of allowing a security-enhanced boot loader to verify the
> kernel and policy before kernel startup.

What verification are you referring to?  Is this something like a TCPA 
verification?

In any case, I can't imagine any verification being done that can't be done at 
least as easily from /sbin/init.

> > An idea that came up was to modify init so that it would do the
> > following:
>
> Note that Magosanyi Arpad previously posted to the list a similar
> solution that he implemented by renaming the real /sbin/init and
> replacing it with a small program that exec'd a shell script to perform
> the policy load and then executed the real init program.

I've done that before too.  However correctly handling "telinit u" (and some 
similar things that happen when you run "reboot") is a bit fiddly in a shell 
script.  I currently have a check for "if [ ! -f /selinux/load ]" in my 
script for such configurations.  Also when running bash in init_t you need 
some extra allow or dontaudit rules...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
