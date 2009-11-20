Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAKK6R0O031918
	for <selinux@tycho.nsa.gov>; Fri, 20 Nov 2009 15:06:27 -0500
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nAKK5Nl2012187
	for <selinux@tycho.nsa.gov>; Fri, 20 Nov 2009 20:05:24 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	(authenticated bits=128)
	by ladon.golden-gryphon.com (8.14.3/8.14.3/Debian-5) with ESMTP id nAKJuqBD009103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Fri, 20 Nov 2009 13:56:53 -0600
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.3/8.14.3/Debian-9) with ESMTP id nAKJpbcw004320
	for <selinux@tycho.nsa.gov>; Fri, 20 Nov 2009 13:51:38 -0600
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Subject: Re: A question about genhomedircon
References: <87vdh5kp0s.fsf@anzu.internal.golden-gryphon.com>
Date: Fri, 20 Nov 2009 13:51:37 -0600
In-Reply-To: <87vdh5kp0s.fsf@anzu.internal.golden-gryphon.com> (Manoj
	Srivastava's message of "Fri, 20 Nov 2009 12:52:03 -0600")
Message-ID: <87fx89km9i.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
On Fri, Nov 20 2009, Manoj Srivastava wrote:

>         Looking at policycoreutils-2.0.77/scripts/genhomedircon, I see:
> #!/bin/sh
> /usr/sbin/semodule -Bn
>         Looking at the man page for semodule, it says:
>  -B, --build
>         force a rebuild of policy (also reloads unless -n is used)
>  -n,--noreload
>         do not reload policy after commit
>         Given that, it would seem that genhomedircon rebuilds, but does
>  not reload policy. I would expect genhomedircon to generate SELinux
>  file context configuration entries for user home directories, or
>  something.
>
>         What am I missing?

        I also note that there used to be a man page (see
 http://linux.die.net/man/8/genhomedircon  for the old contents) that
 also seems to have gone away.

        manoj
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
