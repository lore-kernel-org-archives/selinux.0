Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9U8tNXZ015399
	for <selinux@tycho.nsa.gov>; Sat, 30 Oct 2004 04:55:24 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9U8tHgF013672
	for <selinux@tycho.nsa.gov>; Sat, 30 Oct 2004 08:55:17 GMT
Date: Sat, 30 Oct 2004 10:06:03 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Stephen Smalley <sds@epoch.ncsc.mil>, Chad Hanson <chanson@TrustedCS.com>
Subject: Re: dynamic context transitions
Message-ID: <20041030090603.GK8897@lkcl.net>
References: <4182959B.4080503@trustedcs.com> <20041029211809.GJ8897@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041029211809.GJ8897@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Oct 29, 2004 at 10:18:09PM +0100, Luke Kenneth Casson Leighton wrote:
> On Fri, Oct 29, 2004 at 02:10:19PM -0500, Darrel Goeddel wrote:
> 
> >       The motivator behind this proposal is to provide a mechanism for a
> > trusted application (one written to leverage the security policy) to be
> > able to remove unnecessary privileges when they are no longer needed, as
> > well as temporarily raise the privilege level to perform certain
> > operations and then return to a less privileged level.  
> 
>  in principle i like it: in practice i believe it to be seriously
>  fraught unless tightly controlled.
> 
>  how can you guarantee the circumstances under which security
>  "escalation" is done?

 okay.

 the bit that i don't like is the possibility of a process giving itself
 an uncontrolled amount of access rights.

 what guarantees can you offer that a process can only escalate to a
 specific alternative set of access rights?

 e.g. is your proposal a bit like the file_contexts "alternate"
 keyword idea, where the policy contains a different context that
 the process can flip to?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
