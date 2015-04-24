Date: Fri, 24 Apr 2015 10:00:31 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH 1/2] security: lsm_audit: add ioctl specific auditing
In-Reply-To: <CAHC9VhTF9MrU2tgd+YLLRFFaRqy=OLw3WmrT7vHBW_xfuX7A=A@mail.gmail.com>
Message-ID: <alpine.LRH.2.11.1504241000160.13918@namei.org>
References: <1428616171-14767-1-git-send-email-jeffv@google.com>
 <CAHC9VhTF9MrU2tgd+YLLRFFaRqy=OLw3WmrT7vHBW_xfuX7A=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: James Morris <james.l.morris@oracle.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 23 Apr 2015, Paul Moore wrote:

> On Thu, Apr 9, 2015 at 5:49 PM, Jeff Vander Stoep <jeffv@google.com> wrote:
> > Add information about ioctl calls to the LSM audit data. Log the
> > file path and command number.
> >
> > Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> > ---
> >  include/linux/lsm_audit.h |  7 +++++++
> >  security/lsm_audit.c      | 15 +++++++++++++++
> >  2 files changed, 22 insertions(+)
> 
> While this isn't specific to a given LSM, at present it only makes
> sense with the associated SELinux patches.  James, unless you have any
> objections I would prefer if this went in via the SELinux tree.

Fine by me.


-- 
James Morris
<jmorris@namei.org>
