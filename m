Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KGYaWt020869
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 12:34:36 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9KGYO0p013157
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 16:34:24 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9KGYNr7013154
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 16:34:23 GMT
Subject: Re: [PATCH] Warnings and 64bit
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joerg Hoh <joerg@devone.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031008173416.GB3537@hydra.joerghoh.de>
References: <20031004231832.GE3573@hydra.joerghoh.de>
	 <1065467759.3919.121.camel@moss-spartans.epoch.ncsc.mil>
	 <20031007213151.GG4359@hydra.joerghoh.de>
	 <1065619026.8181.83.camel@moss-spartans.epoch.ncsc.mil>
	 <20031008173416.GB3537@hydra.joerghoh.de>
Content-Type: text/plain
Message-Id: <1066667672.22196.205.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 20 Oct 2003 12:34:32 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-08 at 13:34, Joerg Hoh wrote:
> IMHO it isn't defined how a cast between a 32bit and 64bit value behaves.
> Are the 32bit moved into the lower 32bit of that 64bit or into the higher
> ones? And the second problem is the different endianess on different
> machines. So the (physical) lower 32 bit can be the higher ones if you
> consider the value of that number. And the cast vice versa also isn't clearly 
> defined. 

AFAIK,

u32 i = 4;
void *p = (void*)i;
u32 j= (u32)p;

will always work in practice.  As long as a consistent behavior is
applied for conversion, it will store and extract correctly, and you can
certainly store 32bit values in 64bit variables.  Endianness doesn't
come into play, as we aren't crossing a machine boundary when passing
this value, and checkpolicy does convert to a standard ordering (little
endian) before writing to the binary policy file (and the kernel
converts to the native ordering upon reading it).

> That's the cause for changing so many parameters.

But the changes aren't consistent (e.g. the fields are still being
converted and written as 32bit quantities to the binary policy file in
write.c, and are still being read as such by the kernel).  Your patch
silences the warnings, but doesn't fix the real problem.  

> These warnings soon becomes errors if you go off your 32bit plattform. The
> unpatched policy loader simply crashed because of such errors.

This is what we need to know more about in order to develop a correct
and complete fix to the problem.  Where does it crash?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
