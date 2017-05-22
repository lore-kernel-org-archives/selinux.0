Message-ID: <1495477989.24649.8.camel@tycho.nsa.gov>
Subject: Re: RHEL 7.3 : httpd : type=SELINUX_ERR
 op=security_bounded_transition seresult=denied
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Date: Mon, 22 May 2017 14:33:09 -0400
In-Reply-To: <20170522182350.GC12310@julius.enp8s0.d30>
References: <807706d8-8e4e-fef9-8b18-914b1d802ddb@gmail.com>
 <1495477109.24649.6.camel@tycho.nsa.gov>
 <20170522182350.GC12310@julius.enp8s0.d30>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-05-22 at 20:23 +0200, Dominick Grift wrote:
> On Mon, May 22, 2017 at 02:18:29PM -0400, Stephen Smalley wrote:
> > On Mon, 2017-05-22 at 09:29 -0700, Chris O'Neil wrote:
> > > Hi, running latest RHEL 7.3 ... struggling with an SELinux issue
> > > related
> > > to Apache httpd that I just can't figure out.  I have always been
> > > able
> > > to tune policy or alter a boolean, this one has me stumped!
> > > 
> > > What I am trying to do: I am trying to deploy a simple, 3 line
> > > CGI
> > > script in /var/www/cgi-bin/.  Runs fine with enforcement disabled
> > > (see
> > > output below).  My custom policy for Apache (see below) comes
> > > from my
> > > EL6 environment.
> > > 
> > > The normal setroubleshooting tools don't help, as there is only a
> > > single
> > > line in audit.log (of type=SELINUX_ERR)
> > > 
> > > This is not happening on latest RHEL 6.9 ...
> > > 
> > > Might be related to systemd?  I don't see any "NoNewPrivileges"
> > > directives inside /etc/systemd/ though ... weird!
> > 
> > Is the filesystem mounted nosuid?
> 
> If selinux also uses that message for that scenario then i find that
> confusing since the message, to me, implies that the issue can be
> find by adding a type bounds, but i don't think that would work for
> nosuid mounted slices

NNP and nosuid are handled in the same way.  That said, I'm not sure I
follow the error here, since a default transition on exec should not
cause a failure in this case; we should just fall back to running in
the caller's domain (whether NNP or nosuid).  We only fail hard if the
caller explicitly requested a domain transition.
