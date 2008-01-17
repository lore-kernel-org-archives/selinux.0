Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0HJNZr2007474
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 14:23:35 -0500
Received: from g1t0029.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0HJNXsv001193
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 19:23:34 GMT
From: Paul Moore <paul.moore@hp.com>
To: Joshua Brindle <method@manicmethod.com>
Subject: Re: [PATCH] REFPOL: Add "rogue" Fedora packet class permissions
Date: Thu, 17 Jan 2008 14:23:26 -0500
Cc: selinux@tycho.nsa.gov
References: <20080117172246.341834342@hp.com> <478FA8C3.40600@manicmethod.com>
In-Reply-To: <478FA8C3.40600@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801171423.26498.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 17 January 2008 2:13:07 pm Joshua Brindle wrote:
> Paul Moore wrote:
> > At some point in the Fedora 6 timeframe the "flow_in" and
> > "flow_out" permissions were added to the "packet" class, most
> > likely as part of the ill-fated secid-reconciliation effort. 
> > Despite the fact that these permissions are not currently used they
> > should be included in the Reference Policy as they are now a
> > permanent fixture in Fedora and it is crucial that the FLASK
> > defines be kept in sync.
> >
> > This patch needs to be applied before any other patches that affect
> > the "packet" class, otherwise the resulting policy may not load.
>
> Hrm, they are last in the class definitions so until new perms are
> added to that class it is fairly irrelevant. The policy upgrade to
> remove them would only require a reboot to get rid of them so adding
> them to upstream refpolicy doesn't seem necessary at all.
>
> This also points out how much of a bad idea it is to add object
> class/perm definitions into distro policies before they are in
> refpolicy, I hope that this will be avoided in the future.
>
> I'm not sure what Chris feels about this but I'm opposed to adding
> definitions to the policy like this.

It turns out it's not quite as irrelevant as you think.  The labeled 
networking work targeted for 2.6.25 adds two new permissions to the 
packet class, "forward_in" and "forward_out", (see patch on January 
10th, "Add forwarding permissions to the packet object class") which 
conflict with the existing permissions in Fedora.  Failure to add these 
permissions to the upstream reference policy will result in Fedora 
forever having to patch both the policy and the kernel to get a 
bootable system.  It also makes life much more difficult for people 
experimenting with SELinux on Fedora based systems.

I understand this isn't a patch anyone is going to be excited about (I 
know I'm not) but it is necessary if we hope to move forward.

For clarity, here is what the packet class _should_ look like with both 
the Fedora "flow" permissions and the new "forward" permissions:

	class packet
	{
        	send
	        recv
        	relabelto
	        flow_in         # not currently in use
        	flow_out        # not currently in use
	        forward_in
        	forward_out
	}

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
