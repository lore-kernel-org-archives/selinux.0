Subject: Re: Security issues with local filesystem caching
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Karl MacMillan <kmacmill@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <25910.1162311558@redhat.com>
References: <1161972628.1306.140.camel@moss-spartans.epoch.ncsc.mil>
	 <1161967078.1306.61.camel@moss-spartans.epoch.ncsc.mil>
	 <1161961415.1306.4.camel@moss-spartans.epoch.ncsc.mil>
	 <1161884706.16681.270.camel@moss-spartans.epoch.ncsc.mil>
	 <1161880487.16681.232.camel@moss-spartans.epoch.ncsc.mil>
	 <1161867101.16681.115.camel@moss-spartans.epoch.ncsc.mil>
	 <1161810725.16681.45.camel@moss-spartans.epoch.ncsc.mil>
	 <16969.1161771256@redhat.com> <8567.1161859255@redhat.com>
	 <22702.1161878644@redhat.com> <24017.1161882574@redhat.com>
	 <27450.1161960110@redhat.com> <5318.1161965576@redhat.com>
	 <7319.1161970091@redhat.com>   <25910.1162311558@redhat.com>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 11:51:24 -0500
Message-Id: <1162313484.32614.104.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-31 at 16:19 +0000, David Howells wrote:
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> > You'd have to introduce one for your new config, as there isn't yet a
> > common interface (also under discussion).  matchpathcon(3) is the
> > interface for obtaining the install-time file context to apply for a
> > given pathname.  In other cases, applications have been directly parsing
> > their own config files, but I think that will change (again, that other
> > thread).
> 
> Okay, what I've got for userspace so far is:
> 
> 	[seclabel.c]
> 	#include <stdlib.h>
> 	#include <stdio.h>
> 	#include <selinux/selinux.h>
> 
> 	int main(int argc, char *argv[])
> 	{
> 		security_context_t con;
> 		char *cachesecpath;
> 
> 		if (argc == 1) {
> 			fprintf(stderr, "Format: %s <dir>\n", argv[0]);
> 			exit(2);
> 		}
> 
> 		if (asprintf(&cachesecpath,
> 			     "%s/cachefiles_contexts",
> 			     selinux_contexts_path()
> 			     ) == -1
> 		    ) {
> 			perror("cachefilesd");
> 			return 1;
> 		}
> 
> 		printf("path: %s\n", cachesecpath);
> 
> 		if (matchpathcon_init(cachesecpath) < 0) {
> 			perror(cachesecpath);
> 			return 1;
> 		}
> 
> 		if (matchpathcon(argv[1], 0, &con) == -1) {
> 			perror(argv[1]);
> 			return 1;
> 		}
> 
> 		return 0;
> 	}
> 
> I've created a file of contexts:
> 
> 	[/etc/selinux/targeted/contexts/cachefiles_contexts]
> 	/var/fscache(/.*)?	-d	system_u:object_r:cachefiles_t:s0
> 
> Which the program above seems to read quite happily.  However, I run into a
> problem:
> 
> 	path: /etc/selinux/targeted/contexts/cachefiles_contexts
> 	file_contexts:  invalid context system_u:object_r:cachefiles_t:s0
> 	/var/fscache/: Invalid argument
> 
> I assume this is due to "cachefiles_t" not being defined, but I'm not sure how
> to do that.
> 
> Any advice?

You don't need your own config file if you are just going to use a file
contexts spec and matchpathcon(); we can just put it into file contexts
either by local definition (semanage) or policy module.

To define the type, you would need a policy module. Ultimately, this
would not only define this file type but also the domain and related
types for the daemon.  For experimentation purposes, you can create your
own policy module locally, and then submit it for policy inclusion when
you know it works.

- Install checkpolicy and selinux-policy-devel if you don't already have
them.
- Create a temporary working directory and cd into it.
- cp /usr/share/selinux/devel/Makefile .
- vi cachefiles.te
policy_module(cachefiles, 1.0)
type cachefiles_t;
file_types(cachefiles_t)
- vi cachefiles.fc
/var/fscache(/.*)?		system_u:object_r:cachefiles_t:s0
- make
- semodule -i cachefiles.pp

At this point, the type should be defined in the kernel, and
matchpathcon() should return the expected result.  /sbin/restorecon
-v /var/fscache should apply that context to the directory.

Instead of manually creating cachefiles.te and .fc, you could also try
running /usr/share/selinux/devel/policygentool to generate an initial
cachefilesd.te file; that is a script created by Dan as a starting point
for policy generation.  That would generate initial definitions for the
daemon's domain and types, and you could then add your type to it as
well.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
