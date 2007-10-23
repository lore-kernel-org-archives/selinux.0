Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9NC2XLf021161
	for <selinux@tycho.nsa.gov>; Tue, 23 Oct 2007 08:02:33 -0400
Received: from mercury.gatech.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9NC2WLH006699
	for <selinux@tycho.nsa.gov>; Tue, 23 Oct 2007 12:02:32 GMT
Subject: Re: MLS in the DoD
From: rob myers <rob.myers@gtri.gatech.edu>
To: Huntress Gary B NPRI <HuntressGB@Npt.NUWC.Navy.Mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <7F93C0D0C6D8454B9B05720F713A09F10FD1F4E0@npri54exc14.npt.nuwc.navy.mil>
References: 
	 <7F93C0D0C6D8454B9B05720F713A09F10FD1F4E0@npri54exc14.npt.nuwc.navy.mil>
Content-Type: text/plain
Date: Tue, 23 Oct 2007 08:02:31 -0400
Message-Id: <1193140951.18349.86.camel@rxm-581b.stl.gtri.gatech.edu>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-10-22 at 12:05 -0400, Huntress Gary B NPRI wrote:
> Hi Everyone,
> 
> I have some, but not a lot, of experience with SELinux.  I've recently
> learned about the MLS aspect and this interests me a lot.   I manage a
> number of small projects that have both an unclassified and a
> classified component.   As I understand the capabilities of MLS, in
> theory I could merge these functions onto a single hardware platform
> at a significant total cost savings.  I could also, in theory,
> implement my own "assurance guard" at a potential savings of over
> $50K.   
> 
> There is a lot for me to learn and a lot of the issues are not
> technical but administrative.  That is, it's not what I "can" do, it's
> what I "may" do.   I'd like to hear from anyone in the DoD that has
> successfully implemented an approved/accredited MLS workstation,
> particularly if it is on a network.   Right now I cannot see how I
> could ever convince my IA folks to let me run a system with a NIPRNET
> eth0 and a SIPRNET eth1.

I doubt you could convince them, either.  According to wikipedia,
"NIPRNet is, by design, a parallel airgapped analogue to the
SIPRNET" [1].  Furthermore, RHEL5 has been evaluated against the LSPP
which assumes [2] that any peers "are assumed to be under the same
management control and operate under the same security policy
constraints" as the TOE.  Meanwhile, CLIP [3] is only shooting for PL4.

Good luck, and please send along any success stories.

rob.

[1] http://en.wikipedia.org/wiki/NIPRNET
[2] LSPP 3.3.4 A.PEER 
[3] http://oss.tresys.com/projects/clip


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
