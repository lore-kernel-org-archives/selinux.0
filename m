Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k961kA5h010206
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 21:46:10 -0400
Received: from mail3.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k961ivqJ003909
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 01:44:57 GMT
Date: Thu, 5 Oct 2006 21:46:06 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] NetLabel: use SECINITSID_UNLABELED for a base SID
In-Reply-To: <20061005223704.067757000@hp.com>
Message-ID: <Pine.LNX.4.64.0610052145030.29449@d.namei>
References: <20061005222823.387569000@hp.com> <20061005223704.067757000@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 5 Oct 2006, paul.moore@hp.com wrote:

> This patch changes NetLabel to use SECINITSID_UNLABLELED as it's source of
> SELinux type information when generating a NetLabel context.

Applied.


Git:
git://git.infradead.org/~jmorris/selinux-2.6.git

Web:
http://git.infradead.org/?p=users/jmorris/selinux-2.6.git;a=summary




-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
