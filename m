Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA26855
	for <selinux@tycho.nsa.gov>; Mon, 17 Jun 2002 14:46:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA10836
	for <selinux@tycho.nsa.gov>; Mon, 17 Jun 2002 18:46:34 GMT
Received: from scaup.mail.pas.earthlink.net (scaup.mail.pas.earthlink.net [207.217.120.49])
	by jazzswing.ncsc.mil  with ESMTP id SAA10832
	for <selinux@tycho.nsa.gov>; Mon, 17 Jun 2002 18:46:34 GMT
Received: from crtntx1-ar7-4-35-055-006.crtntx1.elnk.dsl.genuity.net ([4.35.55.6] helo=donkey)
	by scaup.mail.pas.earthlink.net with esmtp (Exim 3.33 #2)
	id 17K1WX-0007lQ-00
	for selinux@tycho.nsa.gov; Mon, 17 Jun 2002 11:46:45 -0700
From: "Ryan Bergauer" <privateryan@mindspring.com>
To: <selinux@tycho.nsa.gov>
Subject: RE: Patent
Date: Mon, 17 Jun 2002 13:46:45 -0500
Message-ID: <000201c2162f$548c4cb0$6501a8c0@donkey>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <20020617162700.5FD7114C9@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm currently working on creating what I affectionally call a
"half-distribution" utilizing SELinux. As it stands right now, I'm
taking base Red Hat 7.3, protecting everything in it from stack-smashing
attacks, encrypting home directories, etc. etc., and using SELinux as
the kernel. I wouldn't plan on selling this, but I'd want to offer it
for free distribution. But from what I've recently been reading, this
would be outlawed by the way the patent stands right now (or at least,
they'd take little ol' me to court on it.) Am I correct in assuming
this?

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Russell Coker
Sent: Monday, June 17, 2002 11:27 AM
To: Shaun Savage; selinux@tycho.nsa.gov
Subject: Re: Patent

On Tue, 18 Jun 2002 00:45, Shaun Savage wrote:
> There is one way to test SCC take on this patent is to have another
> company release a product that has SELinux at it kernel.   Then that
> would force SCC to file legal action or give up its rights for
SELinux.

That would not give us any advantage.  SCC could win a legal case
against 
such a company while having no bearing on the case of SE Linux.  If
their 
patent was voided then it would change things, but this would be
difficult 
for everyone and not an ideal solution.

I hope that the NSA lawyers arranged a suitable deal allowing everything
that 
we want when they contracted Secure Computing.  An ideal soltion to this

would result in us continuing SE Linux development under the GPL, SCC 
enforcing their patent rights against companies like Microsoft, and
everyone 
being happy.

> The patent is still valid for outside of SELinux.  This means that an
> other company can't  create a OS that is secure using the patent.  The
> issue here is NOT the patent but the GPL code that contains the
patent.
> ~  Because the SCC and the NSA released the code that contains the
patent
> using the GPL license ONLY that code can  be used in other products,
> under the GPL license.   Th e patent is still valid and enforcable in
> all products that don't contain the SELinux code, but all products
that
> contain the SELinux code must follow the GPL license.

Yes.  So we could port SE Linux to the Hurd without any issues!

> This means if a product is made that adds other "value" besides the
> SELinux any company can sell that product. But have to supply source
to
> all of the SELinux GPLed code.

Yes.  Any of us can write proprietary programs to manage policy.conf
files, 
to use smart-cards to determine roles at login, etc.

> The problem comes in with code that minipulates the patent
configuration
> files.  Is the TE configuration files format covered under the patent
or
> can external programs  generate the configuration files but not be
> released GPL?

I was under the impression that the file format wasn't the subject of
the 
patent.  But then no-one has given us the details of the patent...

> NOTE***
> If SCC and NSA restrict he use of GPLed code that many people have
> contributed to then that code would have to be discarded, and a new
> clean room implimentation of the code would need to be created without
> the use of ANY GPL code.   Many people have helped development the
> existiong code and the determination of ownership would be impossible.

I already mentioned this, and the fact that if work is similar and it's 
written by people who know the original work then it's presumed to be a
copy. 
If that happened then Stephen Smalley would be quite limited in what
program 
.te files he can write after seeing all of mine.  ;)

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
