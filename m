Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA18203
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 19:38:42 -0400 (EDT)
From: Roland.Jones@nokia.com
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA22104
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 23:37:17 GMT
Received: from mgw-dax1.ext.nokia.com (mgw-dax1.ext.nokia.com [63.78.179.216])
        by jazzband.ncsc.mil  with ESMTP id XAA22100 for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 23:37:16 GMT
Received: from davir01nok.americas.nokia.com (davir01nok.americas.nokia.com [172.18.242.84])
	by mgw-dax1.ext.nokia.com (Switch-2.2.1/Switch-2.2.0) with ESMTP id g54Ncwf00382
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 18:38:58 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: SELinux Dumb Questions
Date: Tue, 4 Jun 2002 16:37:06 -0700
Message-ID: <59A36C4D2F9E7243BEB522274F72C30319370D@mvebe001.NOE.Nokia.com>
To: <russell@coker.com.au>, <jw@centraltexasit.com>, <selinux@tycho.nsa.gov>
Cc: <tom_haigh@securecomputing.com>, <admissions@internet.edu.nf>,
        <carsten.grohmann@dr-baldeweg.de>, <linux-security-module@wirex.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell,

Your comments and clarifications are most enlightening and reflect my under standing of SELinux's use as open source code. I find this issue of private licensing confusing since I thought the whole idea was to get this technology into the community. The NSA's SELinux overview says the following at the end of the page:

		Security-enhanced Linux is being released under the same terms and conditions as the original 			sources. The release includes documentation and source code for both the system and some 			system utilities that were modified to make use of the new features. Participation with comments, 			constructive criticism, and/or improvements is welcome. 

It doesn't seem to me that NSA's intention was to restrict the deployment of this technology when they released SELinux. Any NSA types out there?


Roland


-----Original Message-----
From: ext Russell Coker [mailto:russell@coker.com.au]
Sent: Tuesday, June 04, 2002 3:00 PM
To: jw@centraltexasit.com; selinux@tycho.nsa.gov
Cc: Haigh, Tom; 'Admissions Office'; Carsten Grohmann;
linux-security-module@wirex.com
Subject: Re: SELinux Dumb Questions


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

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
