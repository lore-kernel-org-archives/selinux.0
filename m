Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1KAuXZ029744
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 15:10:57 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1KAuVW006484
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 20:10:56 GMT
Date: Mon, 1 Nov 2004 15:10:41 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Stephen Smalley <sds@epoch.ncsc.mil>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>
Subject: Re: dynamic context transitions
In-Reply-To: <418662EE.5090001@trustedcs.com>
Message-ID: <Xine.LNX.4.44.0411011508210.5409-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 1 Nov 2004, Darrel Goeddel wrote:

> James,
>      I am hoping that this response will also address your question of 
> applicability outside of the MLS policy.

> I have looked back on the threads involving smbd and famd and it does indeed 
> seem that dynamic transitions may help to bring those applications to a 
> "SELinux-aware" state.

Is there any reason why smbd can't exec a simple helper application in the 
required context which only does what needs to be done?



- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
