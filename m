Date: Wed, 3 Apr 2002 23:30:06 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        "'Howard Holm'" <hdholm@epoch.ncsc.mil>, SeLinux@tycho.nsa.gov,
        sds@tislabs.com, pal@tycho.nsa.gov
Subject: Re: Policy
Message-ID: <20020403223006.GH29265@vnl.com>
References: <72222DC86846D411ABD300A0C9EB08A10152432C@csoc-mail-box.csoconline.com> <20020403210620.2CCD23CE93@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020403210620.2CCD23CE93@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 03, 2002 at 11:06:19PM +0200, Russell Coker wrote:
> On Wed, 3 Apr 2002 22:43, Westerman, Mark wrote:
> > On Wednesday, April 03, 2002 2:12 PM, Russell wrote:
> > > How about the following for distributions other than Slackware:
> > > /usr/bin
> > > /usr/sbin
> > > /usr/include/selinux
> > > /usr/lib
> > > /usr/share/man
> > > /etc/policy
> >
> > The reason I was putting every thing under /usr/local/selinux
> > was to get away from any distributions quirks. I really
> 
> The FHS is there to get away from quirks of distributions.  The locations I 
> suggested comply with the FHS.

This is what I was running up against around Christmas when I was trying
to get the build process to work with a supplied build root.

The build process should put everything into the FHS defined locations
by default but allow a build to a specified root, ie /usr/local.

I want debian packages to load into / directories and things I download
and build manually (that are not under the package manager) to go into
/usr/local

So I'd want Russ's selinux debian to go to the above locations, but I'd
prefer a tarball from NSA to build be default into /usr/local/




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
