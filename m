Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3LIrEVi032330
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 14:53:14 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p3LIrD9H016387
	for <selinux@tycho.nsa.gov>; Thu, 21 Apr 2011 18:53:13 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
References: <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, serge.hallyn@canonical.com, eparis@redhat.com,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/9] Open loaders and interpreters with new creds during exec
Date: Thu, 21 Apr 2011 19:53:06 +0100
Message-ID: <32148.1303411986@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David Howells <dhowells@redhat.com> wrote:

>  (1) Consider a SUID binary.  If the loader for that binary is executable by
>      the uid to which the binary changes its uid on execution, but not by the
>      uid of the caller, should execution succeed?
> 
>      For example, if, as root, I do this:
> 
> 	cp -v /bin/ls /tmp/ls
> 	perl -p -i -e s/ld-linux/ld-linuQ/ /tmp/ls
> 	cp -v /lib64/ld-linux-x86-64.so.2 /lib64/ld-linuQ-x86-64.so.2
> 	chmod -v 0700 /lib64/ld-linuQ-x86-64.so.2

I forgot to add to that:

	chmod u+s /tmp/ls

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
