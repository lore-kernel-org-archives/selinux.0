Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i14G0jRb012742
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 11:01:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i14G0E1I021193
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 16:00:15 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i14Fxpbs021117 for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 15:59:51 GMT
Subject: Re: [PATCH] (2/3) SELinux context mount support - NFS
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Christoph Hellwig <hch@infradead.org>
Cc: James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
   Alexander Viro <aviro@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
   selinux@tycho.nsa.gov, Chris Wright <chrisw@osdl.org>,
   trond.myklebust@fys.uio.no
In-Reply-To: <20040204154608.A19702@infradead.org>
References: <Xine.LNX.4.44.0402040931480.4796@thoron.boston.redhat.com>
	 <Xine.LNX.4.44.0402040949010.4796-100000@thoron.boston.redhat.com>
	 <20040204154608.A19702@infradead.org>
Content-Type: text/plain
Message-Id: <1075910184.3525.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 04 Feb 2004 10:56:24 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-02-04 at 10:46, Christoph Hellwig wrote:
> On Wed, Feb 04, 2004 at 10:31:51AM -0500, James Morris wrote:
> > This patch modifies the kernel's NFS mount data structure to include 
> > SELinux context mount data.  It allows NFS fileystems to be labeled on a 
> > per-mountpoint basis, and should not affect existing versions of 
> > userspace mount.
> 
> Wouldn't it better to integrate the NFS xattr code that SGI released under
> the GPL  (it's IRIX, not linux code unfortunately)

That won't help with the case where the NFS server doesn't support the
protocol extensions for xattr or where the NFS client doesn't want to
trust contexts provided by the server.  There is work in progress to add
support for passing process and file contexts on NFS requests/replies,
but that won't eliminate the need for this functionality for unmodified
or untrusted NFS servers.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
