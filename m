Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6TJ0kgA002913
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 15:00:48 -0400 (EDT)
Received: from mail19-res-R.bigfish.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6TIslC2004950
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 18:54:47 GMT
Message-ID: <42EA7B30.8090207@unify.com>
Date: Fri, 29 Jul 2005 11:53:36 -0700
From: Ron Kuris <rk@unify.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: file context ordering
References: <1122578160.20983.14.camel@sgc.columbia.tresys.com>	 <42E946ED.2050705@unify.com> <1122660123.20983.58.camel@sgc>
In-Reply-To: <1122660123.20983.58.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:

| On Thu, 2005-07-28 at 13:58 -0700, Ron Kuris wrote:
|
|> Use M4 diversions ... [snip]
|
|
| Well this is definitely an interesting solution.  The problem is
| that it doesn't apply to the loadable policy modules, since the
| file contexts in a module don't have m4.  Preserving m4 into the
| modules, and having semodule run m4 to reconstruct file_contexts is
| probably a bad idea. Adding a weight to specs, which is what Steve
| suggested, would be more general than leveraging m4.
|
I guess I don't know enough about the loadable module plans.

So that means the loadable modules cannot use any of the m4 macros either?

Ron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC6nswVkC/44kdyuYRAuoyAKDGKVk6aOCtUZg5hOKY6NrEQ3U2YgCfQnUx
ugMfR4Bw5R7AHr1cUwm/4wM=
=Tqmz
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
