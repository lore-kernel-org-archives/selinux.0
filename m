Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Dale Amon <amon@vnl.com>
Subject: Re: Policy
Date: Thu, 4 Apr 2002 00:57:11 +0200
Cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        "'Howard Holm'" <hdholm@epoch.ncsc.mil>, SeLinux@tycho.nsa.gov,
        sds@tislabs.com, pal@tycho.nsa.gov
References: <72222DC86846D411ABD300A0C9EB08A10152432C@csoc-mail-box.csoconline.com> <20020403210620.2CCD23CE93@lyta.coker.com.au> <20020403223006.GH29265@vnl.com>
In-Reply-To: <20020403223006.GH29265@vnl.com>
MIME-Version: 1.0
Message-Id: <20020403225712.34F1F3EFF7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 4 Apr 2002 00:30, Dale Amon wrote:
> > The FHS is there to get away from quirks of distributions.  The locations
> > I suggested comply with the FHS.
>
> This is what I was running up against around Christmas when I was trying
> to get the build process to work with a supplied build root.
>
> The build process should put everything into the FHS defined locations
> by default but allow a build to a specified root, ie /usr/local.

I agree.  But a default of /usr/local and an easy option to use FHS locations 
would also be OK.

All we need is a few changes to #include directives and makefiles to achieve 
this, and preferrably a ./configure script too (I'd be happy to write it).

> I want debian packages to load into / directories and things I download
> and build manually (that are not under the package manager) to go into
> /usr/local
>
> So I'd want Russ's selinux debian to go to the above locations, but I'd
> prefer a tarball from NSA to build be default into /usr/local/

Yep, that's fine.  A Slackware-style "make install" should default to 
/usr/local.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
