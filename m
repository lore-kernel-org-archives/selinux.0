Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA17691
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 18:00:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA17454
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 21:58:42 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id VAA17450 for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 21:58:41 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: jw@centraltexasit.com, selinux@tycho.nsa.gov
Subject: Re: SELinux Dumb Questions
Date: Tue, 4 Jun 2002 23:59:46 +0200
Cc: "Haigh, Tom" <tom_haigh@securecomputing.com>,
        "'Admissions Office'" <admissions@internet.edu.nf>,
        Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>,
        linux-security-module@wirex.com
References: <200205281111.39926.jw@centraltexasit.com> <20020603153940.937033C34@lyta.coker.com.au> <E17FLsN-00072J-00@pintail.mail.pas.earthlink.net>
In-Reply-To: <E17FLsN-00072J-00@pintail.mail.pas.earthlink.net>
MIME-Version: 1.0
Message-Id: <20020604215946.DA32A748C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 4 Jun 2002 23:30, JW wrote:
> > On Mon, 3 Jun 2002 16:50, Admissions Office wrote:
> > > Folks this may seem like a dumb question given the Open Source and
> > > postings on the site. Its just that we want to be sure....
> > >
> > > Is there any reason why a Colo company cannot offer SELinux as a
> > > standard product offering they would install on clients servers?
> >
> > As Mark stated there are no license or legal issues preventing such use.
>
> On Monday 03 June 2002 04:13 pm, Haigh, Tom wrote:
> > SELinux includes Type Enforcement technology developed and patented by
> > the Secure Computing Corporation, who still holds rights to all
> > commercial use of the technology.  Before a colo company, or anyone else
> > uses the technology commercially, it will be necessary to negotiate a
> > license with Secure Computing.  If anyone wants to do so, I can help get
> > the ball rolling with our Legal and BD folks.

Let's look at the following URL:
http://www.securecomputing.com/archive/press/2000/nsa_faq_secure_linux.html

> Question 6: Will SCC use its patent on Type Enforcement TM to restrict use,
> future development, derivative work, or release of the source code of the
> system? 
>
> There will be no restrictions on the use of TE by the Linux open source
> community. We believe that leveraging the resources of the Linux community
> is the best way to develop robust security for Linux.

That seems like a clear statement that we can do what we like with it!

But Tom, if your company does want to go ahead with this patent plan then 
please do the following:

1)  Change that misleading web page.

2)  Let me know so I can remove all SE Linux code from Debian, remove it from 
my client's machines, and start work on a competing product.

3)  Make formal statements as to limitations of distribution etc, also 
clarify to what extent you want SE Linux code removed from the world.  Should 
I get the upstream maintainer of stat to remove the SE Linux code too?  Also 
you'll have to get it removed from LSM which is under the GPL, and you had 
better hope that the problems with building as a module are fixed quickly - 
you can't ship code that links with the kernel unless it's under the GPL.

PS  When does the patent expire?  If it's due to expire in 1 year or less we 
can just wait until it's gone...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
