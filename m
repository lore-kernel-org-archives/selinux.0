Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p44DFIZ3025488
	for <selinux@tycho.nsa.gov>; Wed, 4 May 2011 09:15:18 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p44DFGgL011844
	for <selinux@tycho.nsa.gov>; Wed, 4 May 2011 13:15:17 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2560.1304511146@redhat.com>
References: <2560.1304511146@redhat.com> <20110428200218.GB9186@hallyn.com> <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
To: Serge Hallyn <serge.hallyn@canonical.com>
Cc: dhowells@redhat.com, eparis@redhat.com,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 0/9] Open loaders and interpreters with new creds during exec
Date: Wed, 04 May 2011 14:15:10 +0100
Message-ID: <17835.1304514910@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


David Howells <dhowells@redhat.com> wrote:

> So:

I reran these tests by hand.

>  (*) fstatfs02 and fstatfs02_64 failed in the unpatched kernel.

Works when I run the test manually under the unpatched kernel.  Looking back at
the saved stdout, I see:

fstatfs02    2  TFAIL  :  unexpected error - 38 : Function not implemented - expected 14

so it may have been run on a filesystem that doesn't support this, but I'm not
sure what.

>  (*) sched_getaffinity01

Works fine now with no modules loaded in the patched kernel.  Not sure what
the problem was.

> and proc01 failed in the patched kernel.

I remember now...  I killed this during the original run since it seemed to be
endlessly redoing:

read(10, "\0\0\0\0\0\0\0\6\0\0\0\0\0\0\0\6\0\0\0\0\0\0\0\6\0\0\0\0\0\0\0\6"..., 1024) = 1024

reading /proc/pid/task/tid/pagemap, but it can actually complete if left alone;
it just takes ages - it has one 64-bit entry per potential PTE[*] in a
process's VM space - and on a 64-bit machine that's a *lot* (~140 quadrillion
entries?).

>  (*) su01 failed in both kernels, but differently.

Ah, yes.  su01 failed in the original run with 126 because the "expect"
program wasn't installed.  I install the rpm as soon as I saw it.  I should've
restarted, I suppose.

Now it fails with exit 1 under both kernels because the su01_s1 expect script
reports:

	YOU NEED TO SET ENVIROMENT VARIABLE PASSWD. 

so that test is faulty.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
