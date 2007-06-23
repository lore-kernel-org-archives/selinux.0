Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5N07v5N005005
	for <selinux@tycho.nsa.gov>; Fri, 22 Jun 2007 20:07:57 -0400
Received: from mail8.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5N07tU7011305
	for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2007 00:07:55 GMT
Date: Fri, 22 Jun 2007 20:07:52 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, Karl MacMillan <kmacmill@redhat.com>,
        James Carter <jwcart2@epoch.ncsc.mil>,
        Chris Vance <Christopher.Vance@sparta.com>,
        "Matthew N. Dodd" <Matthew.Dodd@sparta.com>, nfsv4@linux-nfs.org,
        Trond Myklebust <trond.myklebust@fys.uio.no>, neilb@suse.de,
        rwatson@freebsd.org
Subject: Re: [RFC] Security Enhanced NFS (SENFS) Requirements - draft 05
In-Reply-To: <200706221845.21148.paul.moore@hp.com>
Message-ID: <Line.LNX.4.64.0706221957410.8933@localhost.localdomain>
References: <Line.LNX.4.64.0706201635280.25279@localhost.localdomain>
 <200706221845.21148.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 22 Jun 2007, Paul Moore wrote:

> On Wednesday, June 20 2007 4:49:45 pm James Morris wrote:
> > Attached is a draft requirements document for the integration of SELinux
> > and NFSv4 (SENFS).  Also available at:
> >
> > http://namei.org/selinux/nfs/senfs-requirements-draft-05.txt
> >
> > This has been through a few internal iterations from the SELinux side, and
> > we hope to now obtain feedback from a wider audience, particularly Linux
> > NFS developers.
> >
> > The goals at this stage are to ensure we have capture all of the
> > requirements correctly, and that we're on the right track in general.
> >
> > Low-level implementation details are not considered in this document, and
> > are intended to be outlined in a subsequent functional specification, once
> > the requirements have been nailed down.
> >
> > Please reply with any feedback.
> >
> > The intention is to get SENFS on the IETF standards track, so any
> > assistance in that area would also be appreciated.
> 
> Please understand the following is a bit of a nit, but I thought it might be a 
> good idea to make this point now in an effort to make broader acceptance a 
> bit easier ...
> 
> I realize the current motivation for this work is to enable SELinux, but 
> considering section 3.1, "Community Acceptance", I wonder if the language in 
> the document could be more implementation agnostic.  I'm not a NFS expert, 
> but in reading the requirements I did not see much that was specific to 
> SELinux.  Most of the requirements involved the careful binding of security 
> labels to file objects and the honoring of those labels in both the security 
> enforcement mechanisms of the NFS client and server.  Granted there is 
> language regarding per-domain authentication/configuration as well as SELinux 
> DOIs but in reality I think the per-domain auth/config could be abstracted 
> out to per-label auth/config and the concept of differing DOIs is not 
> exclusive to SELinux.  In fact I think that support of multiple DOIs is what 
> could make this a very flexible mechanism, as we could abstract the NFS 
> security label out to things other than SELinux contexts.
> 
> I believe that moving the requirement language from "SELinux NFS" to "labeled 
> NFS" should eventually result in a cleaner design by forcing the 
> implementation to treat the security label as an atomic attribute (a desire I 
> often hear voiced about the SELinux context outside of the security server) 
> as well as expanding the relevance of the standard to OS implementations that 
> support labels but not SELinux style Domain Type Enforcement (i.e. 
> conventional MLS systems, or other security models not yet envisioned).  
> Granted, a general labeled NFS implementation would not be a magic bullet to 
> solving interoperability, but it would at least provide a common mechanism 
> for communication upon which DOI based translations could be built.

Ok, so what we could have is a generic Labled NFS specification and then 
develop an SELinux-specific profile.

One concern would be that after adding a generic abstraction layer, that 
it may still remain too SELinux-specific and not quite fit the needs of 
another scheme down the track.

Aside from that, I would not have a problem with the idea.

I've added Robert Watson to the cc list as he may have some useful 
feedback on this in relation to the requirements of Trusted BSD (as may 
Chris Vance).


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
