Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAB9J5Lp027877
	for <selinux@tycho.nsa.gov>; Sun, 11 Nov 2012 04:19:05 -0500
Date: Sun, 11 Nov 2012 10:18:27 +0100
From: Guillem Jover <guillem@debian.org>
To: selinux@tycho.nsa.gov
Cc: selinux-devel@lists.alioth.debian.org, debian-dpkg@lists.debian.org
Subject: Re: Possible issues with dpkg SELinux support
Message-ID: <20121111091826.GA1808@gaara.hadrons.org>
References: <20121108082623.GA5059@gaara.hadrons.org>
 <CAB9W1A3cVVSj-PbM73c+vePHt7fVGf8117OXmTrDPf0K0vyYGg@mail.gmail.com>
 <20121110031932.GA6217@gaara.hadrons.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121110031932.GA6217@gaara.hadrons.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2012-11-10 at 04:19:32 +0100, Guillem Jover wrote:
> Is the "<<none>>" check needed at all? This has bothered me for a
> while, and it's not clear if calling lsetfilecon_raw() with that would
> DTRT, or if selabel_lookup_raw() would never return that to start with.

Oh, rechecking now selabel_file(5) it seems like selabel_lookup_raw()
might never return "<<none>>", so I've preventively removed locally
that check now.

thanks,
guillem

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
