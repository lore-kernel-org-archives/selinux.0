Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2ChxRb013676
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 07:43:59 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB2ChwqY021706
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 12:43:58 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id hB2Chw0o021703 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 12:43:58 GMT
Date: Tue, 2 Dec 2003 12:43:39 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: nagray@bruzenak.com, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: What causes this??
Message-ID: <20031202124339.GT11972@vnl.com>
References: <1070340338.12612.2.camel@hawaii> <200312021549.34383.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200312021549.34383.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Tue, 2 Dec 2003 15:45, Nick <nagray@bruzenak.com> wrote:
> I just rebuilt a system and when I try to change roles I get this
>
>
> [root@hawaii SELinux]# newrole -r sysadm_r
> cannot find your entry in the passwd file.
> [root@hawaii SELinux]#

If this is a new install, then either you have to
add a line to pam.d/login for pam_selinux.so or
else you have to get Colin Walters login package.

The pam.d solution seems to be the preferred one
by other debian users here (although I'm currently
using the other way).

It's a problem because debian standards don't
seem to allow any way to handle this step other
than by manual incantations.

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
