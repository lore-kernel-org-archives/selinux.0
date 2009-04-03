Subject: Re: [PATCH 08/14] NFSv4: Add label recommended attribute and NFSv4
 flags
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: casey@schaufler-ca.com, sds@tycho.nsa.gov,
        "Matthew N. Dodd" <matthew.dodd@sparta.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org
In-Reply-To: <alpine.LRH.2.00.0904032239330.16607@tundra.namei.org>
References: <1227733394-1114-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <1227733394-1114-9-git-send-email-dpquigl@tycho.nsa.gov>
	 <alpine.LRH.2.00.0904031921320.11240@tundra.namei.org>
	 <1238752770.7541.58.camel@moss-terrapins.epoch.ncsc.mil>
	 <alpine.LRH.2.00.0904032239330.16607@tundra.namei.org>
Content-Type: text/plain
Date: Fri, 03 Apr 2009 08:23:44 -0400
Message-Id: <1238761424.7541.68.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-04-03 at 22:43 +1100, James Morris wrote:
> On Fri, 3 Apr 2009, David P. Quigley wrote:
> 
> > We tried to change this to be dynamically allocated based on what was
> > coming off of the wire but we ran into a problem that it required us to
> > do allocations where they really shouldn't be done in the rpc/nfsv4
> > code. Trond suggested to make this static and that if someone really
> > needed more than a page for their label that something was horrifically
> > wrong. I'm tempted to agree with him on this but there are people trying
> > to send contexts with an MLS component with every other compartment set
> > which tend to be really large. 
> 
> Well, future labels might include cryptographic information, for example.
> 

<removing people from the CC who probably don't care about this>

Could you expand on why this might be needed or what applications would
use this? It's unclear to me what sort of crypto information would be in
a context. I know the ecryptfs guys were trying to make crypto decisions
based on SELinux context in some cases but I never heard of wanting to
put that kind of information into the context.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
