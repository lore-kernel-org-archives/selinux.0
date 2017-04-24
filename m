Message-ID: <1493049037.13274.20.camel@tycho.nsa.gov>
Subject: Re: [RFC PATCH 0/1] libselinux: Add support for
 selinux_check_access_flags
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Date: Mon, 24 Apr 2017 11:50:37 -0400
In-Reply-To: <1493046171.6574.1.camel@btinternet.com>
References: <20170424130919.5286-1-richard_c_haines@btinternet.com>
 <1493042781.13274.12.camel@tycho.nsa.gov>
 <1493046171.6574.1.camel@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-04-24 at 16:02 +0100, Richard Haines wrote:
> On Mon, 2017-04-24 at 10:06 -0400, Stephen Smalley wrote:
> > On Mon, 2017-04-24 at 14:09 +0100, Richard Haines wrote:
> > > Only wanted the avd flags to check whether the domain was
> > > permissive
> > > or not using an selinux_check_access() type call.
> > 
> > Why?  What's the intended user?
> 
> I was writing patches to update racoon and pluto to use
> selinux_check_access in place of avc_open etc. As these programs also
> log useful info I thought I would log the SELinux status (permissive
> mode etc. etc. for debugging). The only thing missing was if they
> were
> running in a permissive domain so I thought I would see if I could
> retrieve this as well. With this patch I can check if permission
> granted or not and also if permissive domain (provided of course the
> call returned the avd flags).
> 
> The other way I thought of was add another entry to selinuxfs and
> pass
> the context to kernel and get whether permissive domain or not.
> 
> Is there an easier way to detect a permissive domain without reading
> the policy ?

Why not just mirror what we did in the kernel and add permissive=0|1 to
the avc: denied messages? avc_audit() already has the necessary
information; you don't need to export it outside of the AVC.
