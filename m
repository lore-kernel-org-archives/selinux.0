Message-ID: <1456504306.3481.42.camel@redhat.com>
Subject: Re: Strange AVC with latest rawhide kernel.
From: Daniel J Walsh <dwalsh@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov, Eric Paris
 <eparis@redhat.com>
Date: Fri, 26 Feb 2016 11:31:46 -0500
In-Reply-To: <CAHC9VhQwrmbH7UONJET6XOwfqJvn46fe9WXgkFOP-JDd4ss1uw@mail.gmail.com>
References: <1456423369.3702.42.camel@redhat.com>
 <56CF4574.3030709@tycho.nsa.gov> <1456426779.3702.52.camel@redhat.com>
 <56CF523A.7000503@tycho.nsa.gov> <1456429021.31341.34.camel@redhat.com>
 <56CF5A54.7020600@tycho.nsa.gov> <1456432101.3702.67.camel@redhat.com>
 <56CF6A08.6010305@tycho.nsa.gov> <1456491264.3481.2.camel@redhat.com>
 <CAHC9VhQwrmbH7UONJET6XOwfqJvn46fe9WXgkFOP-JDd4ss1uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2016-02-26 at 10:46 -0500, Paul Moore wrote:
> On Fri, Feb 26, 2016 at 7:54 AM, Daniel J Walsh <dwalsh@redhat.com>
> wrote:
> > 
> > On Thu, 2016-02-25 at 15:54 -0500, Stephen Smalley wrote:
> > > 
> > > On 02/25/2016 03:28 PM, Daniel J Walsh wrote:
> > > > 
> > > > Currently typebounds only allows one instance.
> > > It is a hierarchy, where each child has a single parent.  So you
> > > can
> > > define hierarchies like:
> > > typebounds unconfined_t docker_t;
> > > typebounds docker_t svirt_lxc_net_t;
> > > and then they can both transition because they are both
> > > ancestors.
> > Awesome idea.
> Would that resolve all your problems Dan with Docker, runc, etc.?
> > 
> > From our discussions the other day I thought you needed the ability
> > to
> transition to svirt_lxc_net_t from domains other than unconfined_t
> and
> docker_t ... or was I misunderstanding you?
> 


Well the two ways we transition to svirt_sandbox_file_t is from runc
which will usually from either docker_t or from unconfined_t.  And from
docker.

We just need to label runc as docker_exec_t so that if you run it from
a systemd unit file the correct transitions will happen.
