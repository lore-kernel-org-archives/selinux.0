Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA19856
	for <selinux@tycho.nsa.gov>; Tue, 26 Mar 2002 03:46:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id IAA15416
	for <selinux@tycho.nsa.gov>; Tue, 26 Mar 2002 08:45:08 GMT
Received: from toe.terreactive.ch (gate.terreactive.ch [212.90.202.121])
        by jazzband.ncsc.mil  with SMTP id IAA15412 for <selinux@tycho.nsa.gov>; Tue, 26 Mar 2002 08:45:07 GMT
Message-ID: <3CA03523.118E1850@tac.ch>
Date: Tue, 26 Mar 2002 09:45:23 +0100
From: Roberto Nibali <ratz@tac.ch>
MIME-Version: 1.0
To: Russell Coker <russell@coker.com.au>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: talks about SE Linux
References: <20020326011659.E9F5D22ADE@lyta.coker.com.au>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Russell,

> Also at OLS I would like to arrange a BOF on advanced security (where we can
> discuss SE Linux, GR Security, OpenWall, LIDS, and anything else that seems
> appropriate).  This will be entirely separate from the LSM BOF.
> Another thing I was thinking of was an install-fest for these things.

Excellent. I'll be attending OLS too like every year. I'm not sure if you
were there last year at the LSM BOF. I'd be very interesting in having
a BOF on selinux. I had a long and extensive talk with P. Loscocco last year
about several issues they might address before porting to LSM (which has 
already happened). I've been working very closely with B+ systems from Argus 
on Solaris and thus I hope to be able to give some valuable input. I also 
like to talk about a possible clean meta policy configuration description
for LSM/selinux since I've got a very clean, stripped and secure linux
distro handy, which has been developed by 3 people over the course of 2 
years. This is namely the biggest problem when dealing with C2 and upwards
systems. It should be possible though to write a kind of matrix and a 
translation function to reflect the security policy needed for a certain
application framework. This would leed to widely adaption of LSM/<put your
favourite MAC/TE/ACL implementation in> for commercial purposes.

I certainly hope that Stephen Smalley and Pete Loscocco will be attending
OLS too so we might have other interesting talks while having a cool beer.

Cheers and looking forward to seeing you at OLS,
Roberto Nibali, ratz

-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
