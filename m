Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h77ITpHa002030
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2003 14:29:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h77ISZFB013350
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2003 18:28:35 GMT
Received: from psi-exch1.plansys.com (ip228-232-151-216.host.talkingnets.net [216.151.232.228])
	by jazzswing.ncsc.mil  with ESMTP id h77ISZGD013346
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2003 18:28:35 GMT
Message-ID: <01d001c35d11$ca9deb00$6418a8c0@PSIMONT2>
From: "David Eaves" <deaves@plansys.com>
To: <selinux@tycho.nsa.gov>
Subject: Fw: [ISN] IBM earns Linux certification
Date: Thu, 7 Aug 2003 11:29:08 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As someone said yesterday, this has to do with assurance, not strength of
security as such (I'm paraphrasing).

Yes it's true the the door got a little wider for Linux. But first of all,
EAL2, and EAL3 are barely adequate for e-commerce in general, and not for a
level of threat posed to military systems in time of war, by a highly
capable adversary, with all the resources of a wealthy nation-state, and
willing to take extreme risks, as the CC conga-line dance goes. US military
C4I orgs will not be likely to find this useful, press agents
notwithstanding.

EAL4 is required even for relatively ordinary protection between information
enclaves. The CC system goes up to EAL7, which requires formal proofs of
linkage between security targets, protection profiles, and the design and
implementation of the products in question. The outlook even for SE-linux is
doubtful above EAL4, ever. And EAL2 is pretty much kids playing in a sandbox
by comparison, so IBM/Suse is no competitor with SE at this point.

More to the point though, CAPP, controlled access protection profile,
assures only what it says, controlled access. As long as it's never hooked
up to a network or has an IP stack running, assurances are reasonably strong
that nobody will be able to access it who is not supposed to. The Windows
product lines already have EAL4+ (what the plus means I don't know) versus
CAPP, which as a protection profile is next to worthless from my pov.
Solutions I need will have to address the MDSPP and MNISPP profiles, which
are much wider in scope and more difficult to assure.

Bottom line is that this is a lot of noise from IBM, cost a total of about
3/4 of a million, cheap marketing for them, half a mil for the cert lab, the
rest for schmoozing reporters, big noise and flashy lights. Good for Linux
vis a vis Windows, but it's pretty much irrelevent in real life, or to
people who work with SE-linux. And way overdue.

Dave Eaves
Principal Information Assurance Software Engineer
Planning Systems, Inc

----- Original Message ----- 
From: "Russell Coker" <russell@coker.com.au>
To: "SE Linux" <selinux@tycho.nsa.gov>
Sent: Thursday, August 07, 2003 8:54 AM
Subject: Fwd: [ISN] IBM earns Linux certification


>
>
> ----------  Forwarded Message  ----------
>
> Subject: [ISN] IBM earns Linux certification
> Date: Thu, 7 Aug 2003 17:34
> From: InfoSec News <isn@c4i.org>
> To: isn@attrition.org
>
> Forwarded from: William Knowles <wk@c4i.org>
>
> http://www.fcw.com/fcw/articles/2003/0804/web-linx-08-06-03.asp
>
> By Rutrell Yasin
> Aug. 6, 2003
>
> The door just got a little bit wider for Linux to be used by
> government agencies for mission-critical systems now that IBM Corp.
> has earned security certification for the open-source operating
> system.
>
> IBM and SuSE Inc. Linux have achieved Common Criteria security
> certification for SuSE Linux Enterprise Server 8 running on IBM
> eServer xSeries. The Common Criteria are internationally recognized
> standards used by the federal government and other organizations to
> assess the security of technology products.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
