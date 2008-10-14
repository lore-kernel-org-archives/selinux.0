Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9EEm6CA027764
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2008 10:48:06 -0400
Subject: Re: [Labeled-nfs] [RFC v3] Security Label Support for NFSv4
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "Matthew N. Dodd" <Matthew.Dodd@sparta.com>,
        James Morris <jmorris@namei.org>, labeled-nfs@linux-nfs.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, viro@zeniv.linux.org.uk,
        selinux@tycho.nsa.gov
In-Reply-To: <1223990448.8907.1.camel@localhost>
References: <1222707986-26606-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <alpine.LRH.1.10.0810141014580.26030@tundra.namei.org>
	 <48F400DD.50905@sparta.com>  <1223990448.8907.1.camel@localhost>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 10:28:44 -0400
Message-Id: <1223994524.3791.57.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-10-14 at 09:20 -0400, Trond Myklebust wrote:
> On Mon, 2008-10-13 at 22:15 -0400, Matthew N. Dodd wrote:
> > James Morris wrote:
> > > On Mon, 29 Sep 2008, David P. Quigley wrote:
> > > 
> > >> 	* New security flavor (auth_seclabel) to transport process label to
> > >> 	  server. This is a derivative of auth_unix so it does not support
> > >> 	  kerberos which has its own issues that need to be dealt with.
> > > 
> > > This is a problem, as discussed last year:
> > > 
> > > http://linux-nfs.org/pipermail/labeled-nfs/2007-November/000110.html
> > > 
> > > We can't require the use of a new auth flavor which is incompatible with 
> > > auth_gss.
> > 
> > auth_seclabel demonstrates the flavor independent changes required for 
> > any RPC layer process label transport.  A GSS solution is currently 
> > under discussion.
> 
> Right, but I'm not particularly interested in merging "demonstration"
> code that might end up requiring permanent support. I'd very much like
> to see all of this get further through the IETF process before we talk
> about merging into mainline.
> 
> Cheers
>   Trond

Hello,
    Nico seems to have come up with a reasonable solution for this
problem we just need to sit down and draw up a document for it.
Apparently he already created a mechanism in rpcsec_gss for allowing you
to bind the rpc session to more than just the normal credentials. Once
we finalize this and get it into a draft we will work on implementing it
in the rpcsec_gss auth flavor.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
