Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4T8VHrT013671
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 04:31:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4T8SlTg025023
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 08:28:48 GMT
Received: from smtp804.mail.ukl.yahoo.com (smtp804.mail.ukl.yahoo.com [217.12.12.141])
	by jazzswing.ncsc.mil  with SMTP id i4T8SlPE025020
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 08:28:47 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 29 May 2004 08:31:10 -0000
Date: Sat, 29 May 2004 08:28:31 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <jbrindle@snu.edu>
Cc: "Dr. Eugene D. Myers" <edm@tycho.ncsc.mil>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: XP as a base for NetTop
Message-ID: <20040529082831.GB13736@lkcl.net>
References: <BCDBA110.10B6A%edm@tycho.ncsc.mil> <40B67F41.6020309@snu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40B67F41.6020309@snu.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 27, 2004 at 06:52:33PM -0500, Joshua Brindle wrote:
> >In NetTop, each virtual machine is assigned a specific type (for example,
> >vm1_d) and the files that contain the virtual disks are assigned a 
> >different
> >type (for example, vm1_t).  Each virtual machine type vmX_d (where X is an
> >arbitrary number) can only access files (virtual disks) of type vmX_t.
> >
> >The restriction means that each virtual machine can only access only its
> >virtual disks.
> 
> on the slide entitled seperation it says that ACL's are used to protect 
> the disk files so that rogue apps in a vm can't affect other vm's, 
> additionally each vm's disk file is encrypted so that only the 'level' 
> user can access it.
 
  ha, you had me there for a minute: i seriously thought you were
  saying that microsoft recommended installing linux to baby-sit
  their flagship OS.

> Obviously both of these things can be done with (SE)Linux but it appears 
>  they thought about this already.

 it would seem to me that SE/Linux would be a better choice of OS
 to achieve this goal.

 1) linux code can be audited without dependence on a single vendor
    for their cooperation (or otherwise)

 2) at the choice of the user [, developer or admin] the code and
    applications can be cut away to an absolute minimum at runtime:
	a linux "thin client" to run VMware
 
 3) additional vetting of the behaviour of each vm session can be done
    including network access.

	it would be a bit painful to do such vetting without any cooperation
	from the VMware sessions, but definitely doable...

	... but it might be possible to... write a program that runs
	"other" programs and communicates with the host OS, and that
	program asks the SE/Linux system to perform domain transitions.

    [without such a program, it'd be necessary to run one VMware
	 session per application - or per "purpose".]


 just a thought.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
