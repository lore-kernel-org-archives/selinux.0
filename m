Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBEE1fe6030352
 for <selinux@tycho.nsa.gov>; Wed, 14 Dec 2016 09:01:41 -0500
From: David Laight <David.Laight@aculab.com>
To: "'Richard Haines'" <richard_c_haines@btinternet.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>
Subject: RE: [RFC PATCH 1/1] kernel: Add SELinux SCTP protocol support
Date: Wed, 14 Dec 2016 14:01:35 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB023F752@AcuExch.aculab.com>
References: <20161214133959.3078-1-richard_c_haines@btinternet.com>
In-Reply-To: <20161214133959.3078-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Richard Haines
> Sent: 14 December 2016 13:40
> Add SELinux support for the SCTP protocol. The SELinux-sctp.txt document
> describes how the patch has been implemented with an example policy and
> tests using lkstcp-tools.
...
> +SCTP_SOCKOPT_BINDX_ADD - Allows additional bind addresses to be
> +                         associated after (optionally) calling bind(2)
> +                         if given the "bind_add" permission.

Does restricting bindx make any sense at all?
The only addresses than can be specified are those of local interfaces.
If bindx isn't called then the default is to include the addresses of
all local interfaces.
So bindx only actually removes local addresses, it doesn't add them.

	David
