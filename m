Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA25036
	for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 09:23:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA18157
	for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 13:23:02 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA18153
	for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 13:23:01 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 163C492467
	for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 23:23:47 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id BF4DB256
	for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 15:23:39 +0200 (CEST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Fwd: Re: Secure Computing statement of assurance
Date: Sun, 28 Jul 2002 15:23:39 +0200
MIME-Version: 1.0
Message-Id: <20020728132339.BF4DB256@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This should have gone to the SE List too...

----------  Forwarded Message  ----------

Subject: Re: Secure Computing statement of assurance
Date: Sat, 27 Jul 2002 21:27:29 -0700
From: Crispin Cowan <crispin@wirex.com>
To: SCC <SCC@securecomputing.com>
Cc: "'linux-security-module@wirex.com'" <linux-security-module@wirex.com>

SCC wrote:
> Secure Computing has reviewed the concerns expressed by the open
> source community about SELinux and certain Secure Computing patents.

Up-front caveats:

    * I am not a lawyer.
    * I don't speak for anyone but myself.
    * I have no interest in any of these issues

That said, IMHO the crux of this issue has to do with who released what:

    * The various restrictions imposed by SCC in the
      _Statement_of_Assurance_
      <http://www.securecomputing.com/pdf/Statement_of_Assurance.pdf>
      are *not* compatible with the GPL, which says in clause 6 that
      "You may not impose any further restrictions on the recipients'
      exercise of the rights granted herein." So had it been SCC that
      released SELinux, they would be in full violation of the GPL.
    * But it was *not* SCC that released SELinux; it was the NSA and
      NAI. At issue is whether the NSA and NAI had obtained appropriate
      rights to SCC's patents to release SELinux. But since that issue
      involves complex contracts that I was not party to, I refuse to
      discuss it.
    * Therefore, NSA and NAI are within the GPL to release the code, at
      the risk of SCC some day changing their mind about the terms on
      their patent. LSM makes a lovely buffer here: Linus can accept LSM
      without infringing on the patent, and anyone who wants to use the
      module can use it. If SCC later withdraws the public's use of the
      patent, Linus doesn't have to take it out.

This results in an odd conclusion: anyone can distribute SELinux-derived
works under the terms of the GPL (provided they're willing to risk SCC
later changing their mind) *except for SCC*. Because SCC's Statement of
Assurance is in violation of the GPL, SCC is specifically enjoined from
releasing modified linux kernels based on this restricted use of their
patent. If SCC ever wants to distribute SELinux based products, they are
going to have to actually GPL the patent, as opposed to this "assurance"
document.

Crispin

--
Crispin Cowan, Ph.D.
Chief Scientist, WireX                      http://wirex.com/~crispin/
Security Hardened Linux Distribution:       http://immunix.org
Available for purchase: http://wirex.com/Products/Immunix/purchase.html

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
