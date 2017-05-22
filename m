Message-ID: <1495478730.24649.10.camel@tycho.nsa.gov>
Subject: Re: RHEL 7.3 : httpd : type=SELINUX_ERR
 op=security_bounded_transition seresult=denied
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Chris O'Neil" <anzavalley@gmail.com>, selinux@tycho.nsa.gov
Date: Mon, 22 May 2017 14:45:30 -0400
In-Reply-To: <CAAung+a72_qvAaFz+XCiFDvatZR4TwKcWDWYttW4Tzf1qT_n9g@mail.gmail.com>
References: <807706d8-8e4e-fef9-8b18-914b1d802ddb@gmail.com>
 <1495477109.24649.6.camel@tycho.nsa.gov>
 <20170522182350.GC12310@julius.enp8s0.d30>
 <CAAung+a72_qvAaFz+XCiFDvatZR4TwKcWDWYttW4Tzf1qT_n9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-05-22 at 11:32 -0700, Chris O'Neil wrote:
> On Mon, May 22, 2017 at 11:23 AM, Dominick Grift <dac.override@gmail.
> com> wrote:
> > On Mon, May 22, 2017 at 02:18:29PM -0400, Stephen Smalley wrote:
> > > On Mon, 2017-05-22 at 09:29 -0700, Chris O'Neil wrote:
> > > > Hi, running latest RHEL 7.3 ... struggling with an SELinux
> > > > issue
> > > > related
> > > > to Apache httpd that I just can't figure out.  I have always
> > > > been
> > > > able
> > > > to tune policy or alter a boolean, this one has me stumped!
> > > > 
> > > > What I am trying to do: I am trying to deploy a simple, 3 line
> > > > CGI
> > > > script in /var/www/cgi-bin/.  Runs fine with enforcement
> > > > disabled
> > > > (see
> > > > output below).  My custom policy for Apache (see below) comes
> > > > from my
> > > > EL6 environment.
> > > > 
> > > > The normal setroubleshooting tools don't help, as there is only
> > > > a
> > > > single
> > > > line in audit.log (of type=SELINUX_ERR)
> > > > 
> > > > This is not happening on latest RHEL 6.9 ...
> > > > 
> > > > Might be related to systemd?  I don't see any "NoNewPrivileges"
> > > > directives inside /etc/systemd/ though ... weird!
> > > 
> > > Is the filesystem mounted nosuid?
> > 
> > If selinux also uses that message for that scenario then i find
> > that confusing since the message, to me, implies that the issue can
> > be find by adding a type bounds, but i don't think that would work
> > for nosuid mounted slices
> 
> Stephen ... /var/www/ was mounted with the "nosuid" option.  I forgot
> about that ... if I remember correctly, when "nosuid" is set on a
> mounted FS, SELinux trans will fail under this condition.  This bit
> me
> before, years ago... and I forgot about it.

I'm still puzzled though, because the transition shouldn't fail
altogether; it should just fall back to staying in httpd_t instead of
httpd_sys_script_t.  You'd get the log message but then it would just
proceed under the old domain.

> Everything is working as expected now.  If I want to mitigate some
> risk, and still use "nosuid" for /var/www/ ....  I'll need to split
> /var/www/cgi-bin away from /var/www/ ...

The other alternative would be to use typebounds, but that likely
wouldn't be straightforward.

> 
> Thank you both for your time and help
> -chris
