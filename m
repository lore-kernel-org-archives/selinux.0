Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0ONZvfD004146
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2012 18:35:57 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id q0ONZtum015391
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2012 23:35:56 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: russell@coker.com.au
Subject: Re: auditd patches from Debian
Date: Tue, 24 Jan 2012 18:35:42 -0500
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <201201241802.33340.russell@coker.com.au>
In-Reply-To: <201201241802.33340.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201201241835.42394.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Russell,

Thanks for the patch. Linux-audit would be a more appropriate mail list for this 
kind of patch.

On Tuesday, January 24, 2012 02:02:33 AM Russell Coker wrote:
> add_missing_headers.diff makes libaudit.c include a couple of extra system
> headers to avoid a build failure.  I can't imagine this causing a problem
> on the platforms where such an inclusion isn't needed so it should go
> upstream.

Applied

> fix-spelling.diff fixes some small spelling errors and should go in.

Applied
 
> manpage-dash.diff escapes some hyphens in man pages, another trivial patch.

Applied

> mode.diff makes the check for mode 750 a warning.  Presumably whoever
> wanted such checks in the first place will not want that patch.  The patch
> is a little ugly too.

Not applied. I did relax the permission checks a little. But what's in svn is as 
far as I go. :)

Thanks,
-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
