Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2F4fRb014941
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 10:04:41 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB2F4eqY027994
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 15:04:40 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id hB2F4Z0o027982 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 15:04:40 GMT
Date: Tue, 2 Dec 2003 15:04:25 +0000
From: Dale Amon <amon@vnl.com>
To: Chris Vanden Berghe <vbc@zurich.ibm.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: selinux-policy-default
Message-ID: <20031202150425.GV11972@vnl.com>
References: <3FCC831A.1070002@zurich.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FCC831A.1070002@zurich.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 02, 2003 at 01:18:34PM +0100, Chris Vanden Berghe wrote:
> I tried installing the new selinux version for kernel 2.6.0-test11 under
> Debian.  Started by installing libselinux1 from Russells newselinux
> archives, this worked just fine.  But when afterwards I tried installing
> selinux-policy-default, then I got the error message below:

Yeah, looks like the same problem I've got. It has to
do with a package install hook that doesn't seem to 
work under non-selinux systems. Won't guarantee that
is a correct statement as I've been busy on other
things and have spent time to properly dig into it.

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
