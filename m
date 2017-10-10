Message-ID: <1507646155.30616.12.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov
Date: Tue, 10 Oct 2017 10:35:55 -0400
In-Reply-To: <alpine.LRH.2.21.1710091405130.23916@namei.org>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
 <20171002155825.28620-4-sds@tycho.nsa.gov>
 <alpine.LRH.2.21.1710091405130.23916@namei.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC 03/10] selinux: move the AVC into the selinux namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-10-09 at 14:10 +1100, James Morris wrote:
> On Mon, 2 Oct 2017, Stephen Smalley wrote:
> 
> > Move the access vector cache (AVC) into the selinux namespace
> > structure and pass it explicitly to all AVC functions.  The
> > AVC private state is encapsulated in a selinux_avc structure
> > that is allocated and freed by the AVC during selinux namespace
> > creation and destruction.
> > 
> > This is necessary to support multiple selinux namespaces since
> > the AVC caches state (e.g. SIDs, policy sequence number) that
> > is maintained and provided by the security server on a per-
> > namespace
> > basis.
> 
> What about per-namespace AVC stats?
> 
> At the moment, it seems that the stats for all AVCs are combined in
> the 
> existing percpu stats, which could be confusing for someone trying to
> tune 
> the host or a guest, as the hash stats & config are per-
> namespace.  Also, 
> a user likely wants to see only their own AVC stats generally.

Yes, we should likely split those too; something else to add to the
TODO list for this patch series.
