Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4G2GdRb018828
	for <selinux@tycho.nsa.gov>; Sat, 15 May 2004 22:16:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4G2EHRA028133
	for <selinux@tycho.nsa.gov>; Sun, 16 May 2004 02:14:17 GMT
Received: from abyss.simplyaquatics.com (abyss.simplyaquatics.com [69.44.152.139])
	by jazzswing.ncsc.mil  with ESMTP id i4G2EGjN028119
	for <selinux@tycho.nsa.gov>; Sun, 16 May 2004 02:14:16 GMT
From: "Ed Street" <edstreet@street-tek.com>
To: "'Thomas Bleher'" <bleher@informatik.uni-muenchen.de>,
   "'Selinux'" <selinux@tycho.nsa.gov>
Subject: RE: Suse
Date: Sat, 15 May 2004 22:16:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <20040515232756.GB2095@jmh.mhn.de>
Message-Id: <20040516021620.D3F2F3A404F@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I would be more than happy to give it a spin.  I put it on my mini-itx
machine and maybe buying a micro-atx for suse.  My cd's just arrived a few
days ago and I installed it last night.  I did notice that libselinux and
the basic userland mod's have been included but it's a few versions behind.
Overall I am greatly pleased with this as it's a big step forward for the
project.  

One thing that I'm very displeased over, when doing my 200+ meg updates (yea
200+ already) I noticed that many of the packages are NOT gpg signed by the
maintainers!

Ed

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
Behalf Of Thomas Bleher
Sent: Saturday, May 15, 2004 7:28 PM
To: 'Selinux'
Subject: Re: Suse

* Ed Street <edstreet@street-tek.com> [2004-05-15 02:09]:
> As was suspected it appears that suse 9.1 pro (shipping) has all the
selinux
> userland patches in place but no policy and no kernel support. I see the
> same startup in suse 9.1 as I do in fedora fc2t3 so it's disabled.

I just glanced over the SuSE 9.1 packages and made the following
observations (Note: didn't test or install anything):
Most relevant packages have SELinux support included. Things that are
still missing: cron, init and util-linux (vipw, chfn, context mount support)

It should not be all too difficult to add the missing pieces by looking
at the Fedora packages and mine for 9.0.
Updating policycoreutils, libselinux and checkpolicy (at version 1.8 in
SuSE 9.1) should be very easy, I just took the fedora packages and
recompiled them on SuSE.

Please note that I will support the SuSE 9.0 packages but won't update
to 9.1 in the forseeable future (6-9 months).

Another thing is policy: The included policy contains some SuSE-specific
cleanup but otherwise is very old (v1.4). I have been working on a proper
policy for SuSE for some time now in the background. It still has some
rough edges which I want to smooth before I submit the policy for
inclusion. If you or anyone else wants an intermediate copy, just drop
me a note!

Thanks,
Thomas

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.686 / Virus Database: 447 - Release Date: 5/14/2004
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
