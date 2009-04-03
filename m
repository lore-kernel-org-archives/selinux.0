Subject: Re: [PATCH 08/14] NFSv4: Add label recommended attribute and NFSv4
 flags
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: hch@infradead.org, viro@zeniv.linux.org.uk, casey@schaufler-ca.com,
        sds@tycho.nsa.gov, "Matthew N. Dodd" <matthew.dodd@sparta.com>,
        trond.myklebust@fys.uio.no, bfields@fieldses.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
In-Reply-To: <alpine.LRH.2.00.0904031921320.11240@tundra.namei.org>
References: <1227733394-1114-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <1227733394-1114-9-git-send-email-dpquigl@tycho.nsa.gov>
	 <alpine.LRH.2.00.0904031921320.11240@tundra.namei.org>
Content-Type: text/plain
Date: Fri, 03 Apr 2009 05:59:30 -0400
Message-Id: <1238752770.7541.58.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-04-03 at 19:31 +1100, James Morris wrote:
> On Wed, 26 Nov 2008, David P. Quigley wrote:
> 
> > diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> > index ea03667..144eacf 100644
> > --- a/include/linux/nfs4.h
> > +++ b/include/linux/nfs4.h
> > @@ -21,6 +21,7 @@
> >  #define NFS4_FHSIZE		128
> >  #define NFS4_MAXPATHLEN		PATH_MAX
> >  #define NFS4_MAXNAMLEN		NAME_MAX
> > +#define NFS4_MAXLABELLEN	4096
> 
> I can't recall if this has been discussed before, but why is the label 
> length limited to this value?
> 
> SELinux on-disk labels can be up to 64KB in size (XATTR_SIZE_MAX), and I'd 
> like to ensure that we don't end up with an unnecessary disk vs. network 
> label size incompatibility.
> 
> While it seems unlikely that SELinux (and other forms of MAC) security 
> labels would currently exceed 4K, we don't know how SELinux might be 
> extended in the future, and should avoid limiting label flexibility 
> beyond existing constraints.
> 
> 
> - James

We tried to change this to be dynamically allocated based on what was
coming off of the wire but we ran into a problem that it required us to
do allocations where they really shouldn't be done in the rpc/nfsv4
code. Trond suggested to make this static and that if someone really
needed more than a page for their label that something was horrifically
wrong. I'm tempted to agree with him on this but there are people trying
to send contexts with an MLS component with every other compartment set
which tend to be really large. 

Dave 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
