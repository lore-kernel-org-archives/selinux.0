Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7DGM5wC013243
	for <selinux@tycho.nsa.gov>; Wed, 13 Aug 2008 12:22:05 -0400
Received: from g4t0017.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7DGM4aC023962
	for <selinux@tycho.nsa.gov>; Wed, 13 Aug 2008 16:22:05 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [ANNOUNCE][RFC] sVirt: Integrating SELinux and Linux-based virtualization
Date: Wed, 13 Aug 2008 12:21:44 -0400
Cc: Russell Coker <russell@coker.com.au>,
        Casey Schaufler <casey@schaufler-ca.com>, libvir-list@redhat.com,
        selinux@tycho.nsa.gov
References: <alpine.LRH.1.10.0808111201430.4083@tundra.namei.org> <200808121557.50355.russell@coker.com.au> <alpine.LRH.1.10.0808121906120.13656@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0808121906120.13656@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808131221.44201.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 12 August 2008 5:57:19 am James Morris wrote:
> On Tue, 12 Aug 2008, Russell Coker wrote:
> > One thing that should be noted is the labelled network benefits. 
> > If you had several groups of virtual servers running at different
> > levels and wanted to prevent information leaks then having SE Linux
> > contexts and labelled networking could make things a little easier.
> >
> > I have had some real challenges in managing firewall rules for Xen
> > servers. My general practice is to try and make sure that there is
> > no real need for firewalls between hosts on the same hardware (not
> > that I want it this way - it's what technical and management issues
> > force me to).
> >
> > So for example if I have an ISP Xen server running virtual machines
> > for a number of organisations I make sure that they are either all
> > within a similar trust boundary (IE affiliated groups) or all
> > mutually untrusting (IE other IP addresses in the same net-block
> > are treated the same as random hosts on the net).
>
> Thanks for the insights -- we expect to address the virtual
> networking aspect in some way.

I think we could do some pretty cool things here with the new, well 
2.6.25 new, network ingress/egress controls and restricting VM 
instances to specific interfaces and/or networks.  However, we would 
need to settle the basic VM label management issues first.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
