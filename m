Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9D46Esd004598
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2008 00:06:14 -0400
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9D46E9J008978
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2008 04:06:14 GMT
Date: Mon, 13 Oct 2008 15:05:52 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Joshua Brindle <method@manicmethod.com>
cc: Steve Grubb <sgrubb@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: Capabilities audit field
In-Reply-To: <48F285B2.90008@manicmethod.com>
Message-ID: <alpine.LRH.1.10.0810131501420.17131@tundra.namei.org>
References: <200810120907.07511.sgrubb@redhat.com> <48F285B2.90008@manicmethod.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 12 Oct 2008, Joshua Brindle wrote:

> Steve Grubb wrote:
> > Hi,
> > 
> > I recenetly found out that the kernel now allows more than 32 capabilities.
> > This means I need to update the audit code that inteprets this value given
> > from SE Linux. When I looked over the 2.6.27 kernel code, I found that SE
> > Linux has not updated the capabilities code. Its still being kept as a
> > simple integer in avc.h, but everywhere else I look in the kernel has moved
> > to kernel_cap_t, which is an array. Are patches for moving to kernel_cap_t
> > scheduled for 2.6.28? Are there security implications for not being able to
> > access or control capabilities > 32?
> >   
> 
> SELinux added an additional object class (capability2) so as to not extend the
> access vector.
> 
> The current object class looks like this:
> class capability2
> {
>        mac_override    # unused by SELinux
>        mac_admin       # unused by SELinux
> }
> 
> We can control them but they should never be hit on an SELinux system anyway
> (IIUC)

mac_admin is used to set and view deferred labels.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
