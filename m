Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9U2fhXZ013692
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 22:41:43 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9U2eMMd014803
	for <selinux@tycho.nsa.gov>; Sat, 30 Oct 2004 02:40:24 GMT
Date: Fri, 29 Oct 2004 22:41:37 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Stephen Smalley <sds@epoch.ncsc.mil>, Chad Hanson <chanson@TrustedCS.com>
Subject: Re: dynamic context transitions
In-Reply-To: <4182959B.4080503@trustedcs.com>
Message-ID: <Xine.LNX.4.44.0410292235470.24581-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 29 Oct 2004, Darrel Goeddel wrote:

> 	A goal of SELinux and trusted application programming is to
> create smaller programs which can be secured and audited. However, there
> are and will continue to be applications which don't fall into this
> framework. For these applications, a privilege bracketing approach
> provides a more granular security framework than what currently exists
> from SELinux today at process level.

Are these applications useful outside MLS?  (In fact, can you give some 
examples?).

It really seems odd to fundamentally change the security model to cater 
for poorly designed applications.

What about limiting this change to MLS enabled systems only?


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
