Subject: Re: New init system hitting a distro near you.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1276892527.22449.152.camel@moss-pluto.epoch.ncsc.mil>
References: <4C1BCA54.20005@redhat.com>
	 <1276890327.22449.135.camel@moss-pluto.epoch.ncsc.mil>
	 <4C1BD072.10700@redhat.com>
	 <1276892527.22449.152.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 Jun 2010 16:31:45 -0400
Message-ID: <1276893105.22449.159.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-06-18 at 16:22 -0400, Stephen Smalley wrote:
> On Fri, 2010-06-18 at 16:00 -0400, Daniel J Walsh wrote:
> > On 06/18/2010 03:45 PM, Stephen Smalley wrote:
> > > On Fri, 2010-06-18 at 15:34 -0400, Daniel J Walsh wrote:
> > >> http://0pointer.de/blog/projects/systemd.html
> > >>
> > >> This has interesting ramifications for SELinux.  I have a working
> > >> version of this in Fedora 14, but we need to add rules like
> > >>
> > >> allow sshd_t init_t:tcp_socket { getopt ioctl getattr setopt };
> > >>
> > >> Since systemd will be doing the listening and passing the socket to sshd.
> > >>
> > >> Could we have risks of sshd_t grabbing the tcp_socket connected to
> > >> httpd_t?
> > >>
> > >> In this scenario we are no longer protecting against the name_bind, and
> > >> are forced to put more trust into init_t.
> > >
> > > Can we get systemd to use setsockcreatecon() to assign the right label
> > > to the socket?
> > >
> > 
> > Probably but how does it figure out the context?
> 
> The sockets would normally be labeled with the context of the individual
> daemon process.  So we would want to compute the context in which the
> daemon process will run and then use that for the socket.  Which we can
> do via security_compute_create().  Sample code attached.  Compile with:
> gcc -lselinux -o setsockcon setsockcon.c
> 
> Example run (in permissive):
> $ runcon system_u:system_r:init_t:s0 ./setsockcon /usr/sbin/sshd
> /usr/sbin/sshd system_u:system_r:sshd_t:s0

So the concept here is that systemd must already know the path to the
daemon executable as part of its config, so it can call the
setsockconfrompath() function on that path prior to calling socket() to
create the socket.  You can have the function bail immediately if
(is_selinux_enabled() < 1), and perhaps ignore errors from it if
(security_getenforce() < 1).

We'll need something similar for Unix domain sockets to ensure that the
file gets labeled properly, but using security_compute_create() on the
daemon context, the parent directory context, and
string_to_security_class("sock_file") to determine the right context and
using setfscreatecon() before calling bind().  A bit messy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
