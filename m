Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAEExjSf024749
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 09:59:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAEExiqY002137
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 14:59:44 GMT
Received: from unthought.net (unthought.net [212.97.129.88])
        by jazzband.ncsc.mil  with ESMTP id hAEExi0o002134 for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 14:59:44 GMT
Date: Fri, 14 Nov 2003 15:59:37 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: Do we break POSIX?
Message-ID: <20031114145937.GA4993@unthought.net>
References: <20031110143701.S16119@lemuria.org> <1068472925.32532.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1068472925.32532.3.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 10, 2003 at 09:02:05AM -0500, Stephen Smalley wrote:
...
> > 
> > Does anyone know immediately if this is so and if we are indeed
> > breaking POSIX? If nobody can answer that, I will find out myself, as
> > I've promised him to check.
> 
> NFS can yield the same behavior.  If you are holding a file open on the
> client and writing to it, and someone changes the ownership of the file
> on the server, then subsequent write() requests will fail with
> Permission denied.  I just tested with a Linux client and server to
> verify, and this is what happens.

Yep.

But NFS doesn't claim to have POSIX semantics.

I doubt there are any real-world programs that would treat a write
returning -1 with errno set to an 'unknown error', as a successful
write.

(if such a program should exist, the author will be most thoroughly
 dealt with when I take over  ;)

So all in all I think that you are both correct, but the (my) conclusion
is that it wouldn't matter if write returned EACCESS.

 / jakob


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
