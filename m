Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAAE2BSf003641
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 09:02:11 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAAE29Kl001479
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 14:02:09 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hAAE285m001475 for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 14:02:08 GMT
Subject: Re: Do we break POSIX?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Tom <tom@lemuria.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031110143701.S16119@lemuria.org>
References: <20031110143701.S16119@lemuria.org>
Content-Type: text/plain
Message-Id: <1068472925.32532.3.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 10 Nov 2003 09:02:05 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-11-10 at 08:37, Tom wrote:
> One point brought up by Theo DeRaadt during PacSec was that according
> to POSIX, write operations can not return a permission denied error.
> 
> I could not argue with him on that because I have not actually read the
> POSIX standard, but he has a valid point in that breaking standards
> would be a big no.
> 
> Does anyone know immediately if this is so and if we are indeed
> breaking POSIX? If nobody can answer that, I will find out myself, as
> I've promised him to check.

NFS can yield the same behavior.  If you are holding a file open on the
client and writing to it, and someone changes the ownership of the file
on the server, then subsequent write() requests will fail with
Permission denied.  I just tested with a Linux client and server to
verify, and this is what happens.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
