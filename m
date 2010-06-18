Subject: Re: New init system hitting a distro near you.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4C1BD072.10700@redhat.com>
References: <4C1BCA54.20005@redhat.com>
	 <1276890327.22449.135.camel@moss-pluto.epoch.ncsc.mil>
	 <4C1BD072.10700@redhat.com>
Content-Type: multipart/mixed; boundary="=-7W7rxDeUu5wwePVDW2JO"
Date: Fri, 18 Jun 2010 16:22:07 -0400
Message-ID: <1276892527.22449.152.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-7W7rxDeUu5wwePVDW2JO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2010-06-18 at 16:00 -0400, Daniel J Walsh wrote:
> On 06/18/2010 03:45 PM, Stephen Smalley wrote:
> > On Fri, 2010-06-18 at 15:34 -0400, Daniel J Walsh wrote:
> >> http://0pointer.de/blog/projects/systemd.html
> >>
> >> This has interesting ramifications for SELinux.  I have a working
> >> version of this in Fedora 14, but we need to add rules like
> >>
> >> allow sshd_t init_t:tcp_socket { getopt ioctl getattr setopt };
> >>
> >> Since systemd will be doing the listening and passing the socket to sshd.
> >>
> >> Could we have risks of sshd_t grabbing the tcp_socket connected to
> >> httpd_t?
> >>
> >> In this scenario we are no longer protecting against the name_bind, and
> >> are forced to put more trust into init_t.
> >
> > Can we get systemd to use setsockcreatecon() to assign the right label
> > to the socket?
> >
> 
> Probably but how does it figure out the context?

The sockets would normally be labeled with the context of the individual
daemon process.  So we would want to compute the context in which the
daemon process will run and then use that for the socket.  Which we can
do via security_compute_create().  Sample code attached.  Compile with:
gcc -lselinux -o setsockcon setsockcon.c

Example run (in permissive):
$ runcon system_u:system_r:init_t:s0 ./setsockcon /usr/sbin/sshd
/usr/sbin/sshd system_u:system_r:sshd_t:s0

-- 
Stephen Smalley
National Security Agency

--=-7W7rxDeUu5wwePVDW2JO
Content-Disposition: attachment; filename="setsockcon.c"
Content-Type: text/x-csrc; name="setsockcon.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

#include <selinux/selinux.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int setsockconfrompath(const char *path)
{
	security_context_t mycon = NULL, fcon = NULL, newcon = NULL;
	security_class_t sclass;
	int rc = 0;

	rc = getcon(&mycon);
	if (rc < 0)
		goto out;
	rc = getfilecon(path, &fcon);
	if (rc < 0)
		goto out;
	sclass = string_to_security_class("process");
	rc = security_compute_create(mycon, fcon, sclass, &newcon);
	if (rc < 0)
		goto out;
	rc = setsockcreatecon(newcon);
	if (rc < 0)
		goto out;
	printf("%s %s\n", path, newcon);
out:
	freecon(mycon);
	freecon(fcon);
	freecon(newcon);
	return rc;
}

int main(int argc, char **argv) 
{
	int i;
	for (i = 1; i < argc; i++) 
		if (setsockconfrompath(argv[i]) < 0) {
			perror(argv[i]);
			exit(1);
		}
	exit(0);
}

--=-7W7rxDeUu5wwePVDW2JO--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
