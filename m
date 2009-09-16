Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8GLFOP1014397
	for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2009 17:15:24 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8GLEhdl016326
	for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2009 21:14:43 GMT
Message-ID: <4AB1556A.6000603@manicmethod.com>
Date: Wed, 16 Sep 2009 17:15:22 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, 515710-forwarded@bugs.debian.org,
        Russell Coker <russell@coker.com.au>
Subject: Re: policycoreutils: The error message on forkpty() failure is not
 clear or useful.
References: <87ljlavbid.fsf@anzu.internal.golden-gryphon.com>
In-Reply-To: <87ljlavbid.fsf@anzu.internal.golden-gryphon.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Manoj Srivastava wrote:
> Hi,
>
>          This has been reported against the Debian BTS.
>
>          The current error message when forkpty() fails is not clear or
>   useful. (Arguably, the erro message in the child branch cold also be
>   improved)  The following patch makes indicate what went wrong.  Probably
>   something better than this could be devised, but this is still a lot
>   better than the current code.
>
> --- open_init_pty.c.bak 2009-02-16 21:47:28.000000000 +1100
> +++ open_init_pty.c     2009-02-16 21:48:06.000000000 +1100
> @@ -153,7 +153,7 @@
>          }
>
>          if (child_pid<  0) {
> -               perror("Fork:");
> +               perror("forkpty():");
>                  fflush(stdout);
>                  fflush(stderr);
>                  exit(EX_OSERR);
>
>          manoj
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=515710


Merged in policycoreutils 2.0.74

git formatted patches preferred, or at least a diff from the bottom of 
the tree.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
