Subject: Re: [PATCH 4/4] SELinux: allow userspace to read policy back out
 of the kernel
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1276527447.8863.25.camel@moss-pluto.epoch.ncsc.mil>
References: <20100611163705.18445.78022.stgit@paris.rdu.redhat.com>
	 <20100611163723.18445.39397.stgit@paris.rdu.redhat.com>
	 <1276527447.8863.25.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 14 Jun 2010 11:24:01 -0400
Message-ID: <1276529041.2749.14.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-06-14 at 10:57 -0400, Stephen Smalley wrote:
> On Fri, 2010-06-11 at 12:37 -0400, Eric Paris wrote:
> > There is interest in being able to see what the actual policy is that was
> > loaded into the kernel.  The patch creates a new selinuxfs file
> > /selinux/policy which can be read by userspace.  The actual policy that is
> > loaded into the kernel will be written back out to userspace.
> 
> How do you expect this to be used?  As with /selinux/load, we can't use
> coreutils utilities to manipulate it unfortunately.  Nor can we do
> things like checkpolicy -b /selinux/policy since it doesn't support
> mmap.

I used my own program to pull it out to a file and poke it after it was
out.  I can certainly take a look at generating the policy on open()
which would allow us to support ppos easily (and maybe mmap, but I've
never written an mmap handler)

#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#define BUFLEN  (10 * 1024 * 1024)

int main(int argc, char *argv[])
{
	char *buf;
	ssize_t len;
	int polfd;
	int outfd;
	int ret;

	polfd = open("/selinux/policy", O_RDONLY);
	if (polfd < 0)
		return 1;

	outfd = open("policy.from.kern", O_RDWR|O_CREAT, S_IRUSR|S_IWUSR);
	if (outfd < 0)
		return 2;

	ret = ftruncate(outfd, BUFLEN);
	if (ret) {
		perror("ftruncate");
		return 3;
	}

	buf =  mmap(NULL, BUFLEN, PROT_WRITE, MAP_SHARED, outfd, 0);
	if (buf == MAP_FAILED) {
		perror("mmap");
		return 4;
	}

	ret = read(polfd, buf, BUFLEN);
	if (ret < 0) {
		perror("write");
		return 5;
	}

	len = ret;

	msync(buf, len, MS_SYNC);

	ftruncate(outfd, len);

	return 0;
}



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
