Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA24037
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 07:12:25 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA14832
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 12:09:30 GMT
Received: from unicorn.lemuria.org (b067096.adsl.hansenet.de [62.109.67.96])
	by jazzswing.ncsc.mil  with ESMTP id MAA14828
	for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2003 12:09:29 GMT
Date: Tue, 28 Jan 2003 13:06:53 +0100
From: Tom <tom@lemuria.org>
To: j.logsdon@lancaster.ac.uk
Cc: selinux@tycho.nsa.gov
Subject: Re: Some questions ...
Message-ID: <20030128130652.I3842@lemuria.org>
References: <Pine.LNX.4.10.10301281113250.1316-100000@mercury.quantex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10301281113250.1316-100000@mercury.quantex>; from j.logsdon@lancaster.ac.uk on Tue, Jan 28, 2003 at 11:34:33AM +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jan 28, 2003 at 11:34:33AM +0000, j.logsdon@lancaster.ac.uk wrote:
> 1) When booting up, I still get a large number of avc denied messages. Do
> (some of) these always come up or is it in principle possible to boot up
> with no such messages?  I am obviously in permissive mode at the moment!:)

I've never managed to let all of them disappear, but my current dev
machine is down to very few that don't seem to matter (i.e. it works
fine even in enforcing mode).


> 3) If I boot into another kernel then back into selinux, do I have to run
> make relabel each time?  It takes ages on my box - I would go into
> overdose if I made coffee all the time.

Yes, you have to run make relabel again. The bootup process creates or
modifies quite a few files that will mess up your next boot into the
SELinux kernel.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
