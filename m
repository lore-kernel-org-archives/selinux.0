Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2OHAwx6004045
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 12:10:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2OH7QlY001862
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 17:07:26 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h2OH7NKX001859
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 17:07:24 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Chris Vance <cvance@tislabs.com>
Subject: Re: general policy stuff
Date: Mon, 24 Mar 2003 18:10:43 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0303240942130.31241-100000@zorg.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0303240942130.31241-100000@zorg.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200303241810.43124.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 24 Mar 2003 15:58, Chris Vance wrote:
> On Mon, 17 Mar 2003, Russell Coker wrote:
> > Recently the line
> > allow $2_t console_device_t:chr_file rw_file_perms;
> > was added to the daemon_sub_domain() macro.  I don't think that this is
> > desired as the ability to read/write to the console can allow a daemon a
> > dangerous level of access (maybe offering a trojan login prompt).
>
> Define recently?  CVS annotate indicates that this change was committed to
> our internal tree 14-Jun-02 and was subsequently pushed out to sourceforge
> 03-Jul-02.  Our internal CVS log also indicates that this has always been
> a part of the daemon_sub_domain() -- which I thought you submitted, our
> log only says: 'Merge Russell Coker's selinux-small_2002053110-3.diff
> policy changes.'

You are correct that I originally wrote the daemon_sub_domain() policy.  I 
think I must have removed that rule from my tree as part of a general cleanup 
of unwanted rules and forgot about that change.  Then when I noticed that my 
tree differed from the CVS tree I incorrectly concluded that it was something 
that had been added to CVS.

> We can remove this line, but I'm curious how many child domains will break
> when we do that?

I don't think that any will break.  In my tree only the qmail and Apache 
policy use that macro, and they both work fine without it.

The concept is that a daemon needs access to the console to enable writing 
critical error messages at boot time.  Actually this should not be, the 
daemon should instead write to a pipe or a pty so that it never gains any 
write access to the console device - this requires changes to the 
distribution startup scripts.  I think that I can do something suitable for 
Debian to address this, but that still leaves the other distributions.

Anyway the main daemon process needs to write error messages to the console, 
the daemon_sub_domain() macro is used for other processes that the daemon 
starts (which do not communicate error conditions directly to the user - they 
talk to the main process and/or the syslog).

There are still some differences between my tree and the CVS tree however, and 
it's possible that daemons other than Qmail and Apache use that macro, but I 
expect that they still won't have any problems from this change.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
