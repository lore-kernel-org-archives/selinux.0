Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA25532
	for <selinux@tycho.nsa.gov>; Mon, 17 Jun 2002 12:27:13 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA00465
	for <selinux@tycho.nsa.gov>; Mon, 17 Jun 2002 16:26:53 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id QAA00461
	for <selinux@tycho.nsa.gov>; Mon, 17 Jun 2002 16:26:51 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Shaun Savage <savages@savages.net>, selinux@tycho.nsa.gov
Subject: Re: Patent
Date: Mon, 17 Jun 2002 18:26:59 +0200
References: <3D0E668E.5080707@savages.net>
In-Reply-To: <3D0E668E.5080707@savages.net>
MIME-Version: 1.0
Message-Id: <20020617162700.5FD7114C9@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 18 Jun 2002 00:45, Shaun Savage wrote:
> There is one way to test SCC take on this patent is to have another
> company release a product that has SELinux at it kernel.   Then that
> would force SCC to file legal action or give up its rights for SELinux.

That would not give us any advantage.  SCC could win a legal case against 
such a company while having no bearing on the case of SE Linux.  If their 
patent was voided then it would change things, but this would be difficult 
for everyone and not an ideal solution.

I hope that the NSA lawyers arranged a suitable deal allowing everything that 
we want when they contracted Secure Computing.  An ideal soltion to this 
would result in us continuing SE Linux development under the GPL, SCC 
enforcing their patent rights against companies like Microsoft, and everyone 
being happy.

> The patent is still valid for outside of SELinux.  This means that an
> other company can't  create a OS that is secure using the patent.  The
> issue here is NOT the patent but the GPL code that contains the patent.
> ~  Because the SCC and the NSA released the code that contains the patent
> using the GPL license ONLY that code can  be used in other products,
> under the GPL license.   Th e patent is still valid and enforcable in
> all products that don't contain the SELinux code, but all products that
> contain the SELinux code must follow the GPL license.

Yes.  So we could port SE Linux to the Hurd without any issues!

> This means if a product is made that adds other "value" besides the
> SELinux any company can sell that product. But have to supply source to
> all of the SELinux GPLed code.

Yes.  Any of us can write proprietary programs to manage policy.conf files, 
to use smart-cards to determine roles at login, etc.

> The problem comes in with code that minipulates the patent configuration
> files.  Is the TE configuration files format covered under the patent or
> can external programs  generate the configuration files but not be
> released GPL?

I was under the impression that the file format wasn't the subject of the 
patent.  But then no-one has given us the details of the patent...

> NOTE***
> If SCC and NSA restrict he use of GPLed code that many people have
> contributed to then that code would have to be discarded, and a new
> clean room implimentation of the code would need to be created without
> the use of ANY GPL code.   Many people have helped development the
> existiong code and the determination of ownership would be impossible.

I already mentioned this, and the fact that if work is similar and it's 
written by people who know the original work then it's presumed to be a copy. 
If that happened then Stephen Smalley would be quite limited in what program 
.te files he can write after seeing all of mine.  ;)

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
