From: David Howells <dhowells@redhat.com>
In-Reply-To: <545B73DE.6090101@tycho.nsa.gov>
References: <545B73DE.6090101@tycho.nsa.gov> <545A51CB.6070107@tycho.nsa.gov>
 <20141105154217.2555.578.stgit@warthog.procyon.org.uk>
 <20141105154307.2555.9847.stgit@warthog.procyon.org.uk>
 <11463.1415275413@warthog.procyon.org.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 5/7] SELinux: Handle opening of a unioned file
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 06 Nov 2014 13:34:28 +0000
Message-ID: <787.1415280868@warthog.procyon.org.uk>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Not sure what filesystems you have in mind for the unionmount scenario.

Currently any filesystem that can be used for a unionmount top layer has to be
modified to provide certain things (DT_WHITEOUT and DT_FALLTHRU directory
entry creation) - and the way this is done precludes a number of filesystems
from being used (it modifies the on-disk format).

Whiteout creation is being provided by some filesystems for overlayfs - but in
a different way to unionmount (0,0 chardevs rather than DT_WHITEOUT dirents).

David
