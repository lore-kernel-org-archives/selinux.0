Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA13051
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2001 09:51:16 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA19886
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2001 14:49:52 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA19882
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2001 14:49:51 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id JAA25346
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2001 09:50:02 -0500 (EST)
Date: Mon, 8 Jan 2001 09:50:02 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: porting to 2.4?
In-Reply-To: <Pine.LNX.4.21.0101011054260.7964-100000@mail.thesportsregister.com>
Message-ID: <Pine.SOL.3.95.1010108093838.22464G-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Mon, 1 Jan 2001, Johnathon Day wrote:

> On a different note, will the SELinux project use its own IPSec
> implementation, or collaborate with FreeS/WAN? Also, will any encryption
> code be able to use the International Patches as plug-ins? (It would seem
> stupid if everyone on the planet plugged in their own 3DES patch into the
> kernel. We only need one copy of any algorithm, but at the moment, we have
> algorithms in mcrypt/mhash, the international patches, ENSkip, FreeS/WAN,
> and a partridge in a pear tree.)

The plan is to integrate an existing IPSEC implementation with
the network mandatory access controls in a similar fashion to
the work done in the Flask research prototype.  That work
is described briefly in Appendix A.2 of the paper "The Flask Security
Architecture:  System Support for Diverse Security Policies"
and at greater length in the master's thesis "Implementing
Mandatory Network Security in a Policy-Flexible System" on
the Flask web page.  

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
