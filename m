Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9MHmhWt004722
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 13:48:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9MHmbIE000254
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 17:48:37 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9MHmb1J000250 for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 17:48:37 GMT
Subject: Re: [Patch] checkpolicy (3)
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joerg Hoh <joerg@devone.org>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <20031021205052.GC3638@hydra.joerghoh.de>
References: <20031020212056.GF3579@hydra.joerghoh.de>
	 <1066738297.27065.9.camel@moss-spartans.epoch.ncsc.mil>
	 <20031021154814.GA3638@hydra.joerghoh.de>
	 <1066762919.27065.207.camel@moss-spartans.epoch.ncsc.mil>
	 <20031021195947.GB3638@hydra.joerghoh.de>
	 <1066767195.27065.227.camel@moss-spartans.epoch.ncsc.mil>
	 <20031021205052.GC3638@hydra.joerghoh.de>
Content-Type: text/plain
Message-Id: <1066844907.32228.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 Oct 2003 13:48:28 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-21 at 16:50, Joerg Hoh wrote:
> The compiler itself does the this automatic cast (and only warns about
> that); yeah, we may exclude this patch.

Ok, so let's consider the changes in this patch besides the casting of
constants, i.e. changing certain variables from int to size_t since they
are used to store the return value of functions that return size_t, e.g.
fwrite, strlen.  Using size_t for these variables avoids truncation on
the return value, but note that some of these variables are subsequently
assigned to u32 entries in a buf array (after conversion to little
endian) and written out to the binary policy file.  So truncation of the
value is still possible, and I'm puzzled that the compiler is not
warning about this if sizeof(size_t) != sizeof(u32).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
