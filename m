Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iANGpeIi012741
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 11:51:40 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iANGpcFP023715
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 16:51:43 GMT
Received: from lkcl.net (unknown [212.44.25.89])
	by open.hands.com (Postfix) with ESMTP id 2251CC182
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 16:51:16 +0000 (GMT)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CWe3L-0001hO-QP
	for selinux@tycho.nsa.gov; Tue, 23 Nov 2004 17:02:07 +0000
Date: Tue, 23 Nov 2004 17:02:07 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: http://sf.net/projects/xen
Message-ID: <20041123170207.GA6250@lkcl.net>
References: <20041120204020.GB26761@lkcl.net> <20041122103142.GA4400@rns-nis.co.yu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041122103142.GA4400@rns-nis.co.yu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 22, 2004 at 11:31:42AM +0100, Milan P. Stanic wrote:
> On Sat, Nov 20, 2004 at 08:40:20PM +0000, Luke Kenneth Casson Leighton wrote:
> > vmware, _and_ who also don't want the slowness or features of UML,
> 
> When I backported SELinux from Debian/unstable to woody, I did that
> using UML only. I didn't had any problem with UML, only with my own
> slowness :-)
 
 :)

 this page demonstrates it best:

 http://www.cl.cam.ac.uk/Research/SRG/netos/xen/performance.html

 also, UML, unless it is patched (yes someone has provided
 such patches), provides the host running the UML linux apps
 with direct access to their kernel memory - for debugging
 purposes, obviously.

 i'm evaluating xen as a means to run applications like mozilla
 in an isolated selinux machine (!) also to suspend them down
 to disk, and use xen to start an entire virtual machine up
 when a user needs to run the application (!)

 my only concern is how to stop absolutely anyone from running
 a xen guest OS: management of xen is done on port 8000.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
