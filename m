Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAULeiRb003943
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 16:40:44 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAULehqY017734
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 21:40:43 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id hAULeg0o017731 for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 21:40:43 GMT
Date: Sun, 30 Nov 2003 21:40:41 +0000
From: Dale Amon <amon@vnl.com>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Still no authentication from new debian packages
Message-ID: <20031130214041.GH11972@vnl.com>
References: <20031125140255.GI2718@vnl.com> <20031125205010.GA2174@rom.cip.informatik.uni-muenchen.de> <20031125231100.GQ2718@vnl.com> <200311261454.14965.russell@coker.com.au> <87d6b9fza7.fsf@glaurung.green-gryphon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87d6b9fza7.fsf@glaurung.green-gryphon.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Nov 30, 2003 at 01:10:24PM -0600, Manoj Srivastava wrote:
> 	I am afraid that diversions of conffiles may also be frowned
>  upon.  The best solution I can think of is a NEWS.Debian files, and a
>  simple ed/sed/awk/perl utility that helps the sysadmin make these
>  changes. (Or create a sample /etc/pam.d/{login,ssh}.selinux set of
>  files, and ask the sysadmin to mv them over. Or something.

That's a pretty rotten solution IMHO. It won't affect
me personally all that much: I have my own meta-installation
system that unpacks debian and then just does to the
file system what ever I DWP... but for those poor newbies
out there, this kind of thing just raises the bar by yet
another notch.

We have to have a solution in which you install a basic
selinux system and It Just Works.

We all know it takes a great deal of expertise to fiddle
selinux. But I (and I think others here) do have hopes
that some way can be found to give much of its benefits
to people who are not 20 year unix heads.

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
