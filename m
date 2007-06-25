From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC] Security Enhanced NFS (SENFS) Requirements - draft 05
Date: Mon, 25 Jun 2007 08:54:51 -0400
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, Karl MacMillan <kmacmill@redhat.com>,
        James Carter <jwcart2@epoch.ncsc.mil>,
        Chris Vance <Christopher.Vance@sparta.com>,
        "Matthew N. Dodd" <Matthew.Dodd@sparta.com>, nfsv4@linux-nfs.org,
        Trond Myklebust <trond.myklebust@fys.uio.no>, neilb@suse.de,
        rwatson@freebsd.org
References: <Line.LNX.4.64.0706201635280.25279@localhost.localdomain> <200706221845.21148.paul.moore@hp.com> <Line.LNX.4.64.0706221957410.8933@localhost.localdomain>
In-Reply-To: <Line.LNX.4.64.0706221957410.8933@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200706250854.52287.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 22 June 2007 8:07:52 pm James Morris wrote:
> On Fri, 22 Jun 2007, Paul Moore wrote:
> > On Wednesday, June 20 2007 4:49:45 pm James Morris wrote:
> > > Attached is a draft requirements document for the integration of
> > > SELinux and NFSv4 (SENFS).  Also available at:
> > >
> > > http://namei.org/selinux/nfs/senfs-requirements-draft-05.txt
> > >
> > > This has been through a few internal iterations from the SELinux side,
> > > and we hope to now obtain feedback from a wider audience, particularly
> > > Linux NFS developers.
> > >
> > > The goals at this stage are to ensure we have capture all of the
> > > requirements correctly, and that we're on the right track in general.
> > >
> > > Low-level implementation details are not considered in this document,
> > > and are intended to be outlined in a subsequent functional
> > > specification, once the requirements have been nailed down.
> > >
> > > Please reply with any feedback.
> > >
> > > The intention is to get SENFS on the IETF standards track, so any
> > > assistance in that area would also be appreciated.
> >
> > Please understand the following is a bit of a nit, but I thought it might
> > be a good idea to make this point now in an effort to make broader
> > acceptance a bit easier ...
> >
> > I realize the current motivation for this work is to enable SELinux, but
> > considering section 3.1, "Community Acceptance", I wonder if the language
> > in the document could be more implementation agnostic.  I'm not a NFS
> > expert, but in reading the requirements I did not see much that was
> > specific to SELinux.  Most of the requirements involved the careful
> > binding of security labels to file objects and the honoring of those
> > labels in both the security enforcement mechanisms of the NFS client and
> > server.  Granted there is language regarding per-domain
> > authentication/configuration as well as SELinux DOIs but in reality I
> > think the per-domain auth/config could be abstracted out to per-label
> > auth/config and the concept of differing DOIs is not exclusive to
> > SELinux.  In fact I think that support of multiple DOIs is what could
> > make this a very flexible mechanism, as we could abstract the NFS
> > security label out to things other than SELinux contexts.
> >
> > I believe that moving the requirement language from "SELinux NFS" to
> > "labeled NFS" should eventually result in a cleaner design by forcing the
> > implementation to treat the security label as an atomic attribute (a
> > desire I often hear voiced about the SELinux context outside of the
> > security server) as well as expanding the relevance of the standard to OS
> > implementations that support labels but not SELinux style Domain Type
> > Enforcement (i.e. conventional MLS systems, or other security models not
> > yet envisioned). Granted, a general labeled NFS implementation would not
> > be a magic bullet to solving interoperability, but it would at least
> > provide a common mechanism for communication upon which DOI based
> > translations could be built.
>
> Ok, so what we could have is a generic Labled NFS specification and then
> develop an SELinux-specific profile.
>
> One concern would be that after adding a generic abstraction layer, that
> it may still remain too SELinux-specific and not quite fit the needs of
> another scheme down the track.
>
> Aside from that, I would not have a problem with the idea.

Great, I think it's a good goal to shoot for at this stage.  I agree that it 
may be a bit foolish to try and predict the needs of some random, future 
security model; my point was that a generic label based approach has more of 
a chance than a strictly SELinux approach.  I think a common NFS framework 
shared amongst different known labeled OS implementations/designs is a more 
realistic goal.

I'll be curious to see what others have to say during the review process.

Thanks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
