Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA17751
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 18:12:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA29587
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 22:12:26 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA29583
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 22:12:24 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: JW <jw@centraltexasit.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Sorry, read this one: Re: SELinux Dumb Questions
Date: Wed, 5 Jun 2002 00:12:24 +0200
Cc: "Haigh, Tom" <tom_haigh@securecomputing.com>,
        "'Admissions Office'" <admissions@internet.edu.nf>,
        Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>
References: <E17FMB5-0006Or-00@swan.prod.itd.earthlink.net>
In-Reply-To: <E17FMB5-0006Or-00@swan.prod.itd.earthlink.net>
MIME-Version: 1.0
Message-Id: <20020604221224.C10D7748E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 4 Jun 2002 23:49, JW wrote:
> Sorry about that last empty message, I accidently hit ^[ENTER] when I meant
> hit shift...

You had written enough to clarify the issue (I don't know how I missed Tom's 
message the first time).

> IANAL, but it is my understanding that you cannot restrict the use or
> distribution of GPLd Free Software. It simply does not work that way, no
> exceptions, no excuses. Once code is GPLd it is free for all to use. You
> can change the license on future versions of the code, but you cannot go
> back and restrict GPL's code "after the fact"

Yes.  Unless of course they claim that they didn't GPL it, or that the GPL 
only covers the code not the patent.

> 2. It will need to be removed from Debian's tree -- at least moved to
> non-free, yet as I said before, if Secure Computing is correct, SE-Linux is
> not legal to use with GPL'd software anyway (at least the way I see it).

Stuff that.  I'm not putting this much work into non-free stuff!  If the 
license gets changed to anything other than the GPL then I'll immediately 
cease work and file critical bug reports against ftp.debian.org asking for 
the packages to be removed.  If Secure Computing want me to work on material 
that's patented by them then they'll have to pay me at my usual consulting 
rates, plus back-pay for the last 6 months.

> You'd better bet that GNU and other people who's code is being modified to
> work with SE-Linux will have ten purple cows on anyone who mixes non-free
> code with their GPLd code.

The code can be still released as patches, but the problems of having them 
becoming obsolete and not matching the version your OS uses will remain.

Basically I think that SE Linux is as good as dead for anything other than 
research use if this patent gets enforced.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
