Message-ID: <1456491264.3481.2.camel@redhat.com>
Subject: Re: Strange AVC with latest rawhide kernel.
From: Daniel J Walsh <dwalsh@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
 pmoore@redhat.com, mgrepl@redhat.com
Cc: selinux@tycho.nsa.gov
Date: Fri, 26 Feb 2016 07:54:24 -0500
In-Reply-To: <56CF6A08.6010305@tycho.nsa.gov>
References: <1456423369.3702.42.camel@redhat.com>
 <56CF4574.3030709@tycho.nsa.gov> <1456426779.3702.52.camel@redhat.com>
 <56CF523A.7000503@tycho.nsa.gov> <1456429021.31341.34.camel@redhat.com>
 <56CF5A54.7020600@tycho.nsa.gov> <1456432101.3702.67.camel@redhat.com>
 <56CF6A08.6010305@tycho.nsa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2016-02-25 at 15:54 -0500, Stephen Smalley wrote:
> On 02/25/2016 03:28 PM, Daniel J Walsh wrote:
> > 
> > On Thu, 2016-02-25 at 14:47 -0500, Stephen Smalley wrote:
> > > 
> > > On 02/25/2016 02:37 PM, Eric Paris wrote:
> > > > 
> > > > 
> > > > You added a type bounds right before this broke...  Does the
> > > > parent
> > > > type have entrypoint? If not, maybe that's where it got
> > > > stripped...
> > > That would match the behavior he described (although he should
> > > get
> > > an
> > > audit message of the form op=security_compute_av reason=bounds..
> > > in
> > > audit.log or dmesg in that case).  The kernel automatically
> > > reduces
> > > permissions as required by typebounds.  The corresponding logic
> > > never
> > > made its way into the libsepol compute_av code, so audit2why
> > > wouldn't
> > > know about it, and sesearch merely searches for TE rules; it
> > > doesn't
> > > do
> > > anything about typebounds.  We should probably update libsepol
> > > compute_av (for that, and eventually for xperms).
> > > 
> > That would make sense, and then when I blew it away everything
> > works
> > again.
> > 
> > So if I do a typebounds on docker_t svirt_lxc_net_t, I have to make
> > sure docker_t can use svirt_sandbox_file_t as an entrypoint?
> As currently defined/implemented, yes - a bounded type cannot be
> allowed 
> anything that is not allowed to its parent.  If you had 
> neverallow/hierarchy checking enabled in your policy build (e.g. 
> expand-check=1 or manual semodule_expand test), then it would have 
> triggered at link time.  Otherwise the kernel prunes it for you.
> 
> > 
> > 
> > BTW we have a problem with type bounds, which only allows one.  We
> > would like to be able to say
> > 
> > typebounds unconfined_t svirt_lxc_net_t;
> > typebounds docker_t svirt_lxc_net_t;
> > 
> > This would allow runc and docker to transition to svirt_lxc_net_t,
> > if
> > the user specified prctl(NO_NEW_PRIVS)
> > 
> > Currently typebounds only allows one instance.
> It is a hierarchy, where each child has a single parent.  So you can 
> define hierarchies like:
> typebounds unconfined_t docker_t;
> typebounds docker_t svirt_lxc_net_t;
> and then they can both transition because they are both ancestors.
> 
> 

Awesome idea.
