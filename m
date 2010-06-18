Subject: Re: New init system hitting a distro near you.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4C1BCA54.20005@redhat.com>
References: <4C1BCA54.20005@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 Jun 2010 15:45:27 -0400
Message-ID: <1276890327.22449.135.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-06-18 at 15:34 -0400, Daniel J Walsh wrote:
> http://0pointer.de/blog/projects/systemd.html
> 
> This has interesting ramifications for SELinux.  I have a working 
> version of this in Fedora 14, but we need to add rules like
> 
> allow sshd_t init_t:tcp_socket { getopt ioctl getattr setopt };
> 
> Since systemd will be doing the listening and passing the socket to sshd.
> 
> Could we have risks of sshd_t grabbing the tcp_socket connected to 
> httpd_t?
> 
> In this scenario we are no longer protecting against the name_bind, and 
> are forced to put more trust into init_t.

Can we get systemd to use setsockcreatecon() to assign the right label
to the socket?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
