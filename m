From: David Howells <dhowells@redhat.com>
In-Reply-To: <5582DB99.70001@tycho.nsa.gov>
References: <5582DB99.70001@tycho.nsa.gov>
 <20150618133215.12722.70352.stgit@warthog.procyon.org.uk>
 <20150618133302.12722.14996.stgit@warthog.procyon.org.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 6/8] SELinux: Handle opening of a unioned file
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 18 Jun 2015 16:04:19 +0100
Message-ID: <17087.1434639859@warthog.procyon.org.uk>
Cc: miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, dhowells@redhat.com,
 linux-security-module@vger.kernel.org, viro@zeniv.linux.org.uk,
 Selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > +	/* We need to check that the union file is allowed to be opened as well
> > +	 * as checking that the lower file is allowed to be opened.
> 
> Hmm...so if I try to open a file for write access, then we are going to
> require that the process be allowed to write to both the union/overlay
> inode and to the lower inode?  That seems problematic for the containers
> use case where no write access will be granted to the lower files.

Actually, this comment should probably be deleted.  I am currently thinking
that access through the overlay fs should only be mediated by the label on the
overlay inode and should not involve the lower inode.

Possibly, then the lower file label should be reckoned against the label of
whoever created the *mount*.

David
