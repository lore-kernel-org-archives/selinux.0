From: David Howells <dhowells@redhat.com>
In-Reply-To: <1161972628.1306.140.camel@moss-spartans.epoch.ncsc.mil> 
References: <1161972628.1306.140.camel@moss-spartans.epoch.ncsc.mil>  <1161967078.1306.61.camel@moss-spartans.epoch.ncsc.mil> <1161961415.1306.4.camel@moss-spartans.epoch.ncsc.mil> <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil> <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil> <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil> <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <8567.1161859255@redhat.com> <22702.1161878644@redhat.com> <24017.1161882574@redhat.com> <27450.1161960110@redhat.com> <5318.1161965576@redhat.com> <7319.1161970091@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: David Howells <dhowells@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov, chrisw@sous-sol.org, jmorris@namei.org
Subject: Re: Security issues with local filesystem caching 
Date: Tue, 31 Oct 2006 16:19:18 +0000
Message-ID: <25910.1162311558@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> You'd have to introduce one for your new config, as there isn't yet a
> common interface (also under discussion).  matchpathcon(3) is the
> interface for obtaining the install-time file context to apply for a
> given pathname.  In other cases, applications have been directly parsing
> their own config files, but I think that will change (again, that other
> thread).

Okay, what I've got for userspace so far is:

	[seclabel.c]
	#include <stdlib.h>
	#include <stdio.h>
	#include <selinux/selinux.h>

	int main(int argc, char *argv[])
	{
		security_context_t con;
		char *cachesecpath;

		if (argc == 1) {
			fprintf(stderr, "Format: %s <dir>\n", argv[0]);
			exit(2);
		}

		if (asprintf(&cachesecpath,
			     "%s/cachefiles_contexts",
			     selinux_contexts_path()
			     ) == -1
		    ) {
			perror("cachefilesd");
			return 1;
		}

		printf("path: %s\n", cachesecpath);

		if (matchpathcon_init(cachesecpath) < 0) {
			perror(cachesecpath);
			return 1;
		}

		if (matchpathcon(argv[1], 0, &con) == -1) {
			perror(argv[1]);
			return 1;
		}

		return 0;
	}

I've created a file of contexts:

	[/etc/selinux/targeted/contexts/cachefiles_contexts]
	/var/fscache(/.*)?	-d	system_u:object_r:cachefiles_t:s0

Which the program above seems to read quite happily.  However, I run into a
problem:

	path: /etc/selinux/targeted/contexts/cachefiles_contexts
	file_contexts:  invalid context system_u:object_r:cachefiles_t:s0
	/var/fscache/: Invalid argument

I assume this is due to "cachefiles_t" not being defined, but I'm not sure how
to do that.

Any advice?

Thanks,
David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
