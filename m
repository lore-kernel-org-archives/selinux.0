Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAQAF0Rb018663
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 05:15:00 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAQAExqY027542
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 10:14:59 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id hAQAEw0o027539 for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 10:14:59 GMT
Date: Wed, 26 Nov 2003 10:14:47 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: Still no authentication from new debian packages
Message-ID: <20031126101447.GU2718@vnl.com>
References: <20031125140255.GI2718@vnl.com> <20031125205010.GA2174@rom.cip.informatik.uni-muenchen.de> <20031125231100.GQ2718@vnl.com> <200311261454.14965.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200311261454.14965.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 26, 2003 at 02:54:14PM +1100, Russell Coker wrote:
> On Wed, 26 Nov 2003 10:11, Dale Amon <amon@vnl.com> wrote:
> > > I also appended the line
> > >         session required pam_selinux.so
> > > to /etc/pam.d/{login,ssh}
> >
> > That is worth a look also. But I think Russell might
> 
> That is the right answer.  An updated login or ssh package is no longer 
> needed.

Well, I guess I could add a sed script to handle it for
me during the build. But then I'll forget about it, and
you'll fix it... and I'll break again and wonder what 
happened. :-)
 
> I have to automate this somehow, unfortunately Debian policy prohibits 
> interfering with the configuration files of another package.  Maybe I'll have 
> to do a diversion.

I don't know that this is true in general, inetd.conf
for example. Your addition looks like a single line
to be added/deleted with the install/purge of pam_selinux.so.
I should think you'd be okay there.

I often set some of my own house rules in pam so it 
would be annoying if the existing files went poof... far 
better to just edit with sed and make the minimal changes 
required. 

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
