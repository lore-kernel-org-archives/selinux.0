Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA11914
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 18:59:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA28806
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 22:58:08 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id WAA28802 for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 22:58:06 GMT
Date: Tue, 20 Aug 2002 08:59:38 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: type_change rules
Message-ID: <20020819225938.GC12997@snoopy.apana.org.au>
References: <Pine.GSO.4.33.0208190900150.14458-100000@raven> <20020819152726.B3533267@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020819152726.B3533267@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 19, 2002 at 05:27:26PM +0200, Russell Coker wrote:
> > If compiled with PAM support, the util-linux login forks a child process
> > that waits for the user shell to exit and then cleans up the session
> > (including relabeling the tty back to its original SID, with the SELinux
> > patch).
> 
> I'll have to look into that.  Debian is using the shadow utils login which is 
> different.

I may have missed something here, but Debian login only forks a child
process to wait for the user to logout if CLOSE_SESSIONS is set to YES
in /etc/login.defs.

This is required for instance if you want a kerberos PAM module
to destroy the ticket when you logout.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
