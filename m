From: David Howells <dhowells@redhat.com>
In-Reply-To: <1460644857-29218-1-git-send-email-prarit@redhat.com>
References: <1460644857-29218-1-git-send-email-prarit@redhat.com>
To: Prarit Bhargava <prarit@redhat.com>
Cc: dhowells@redhat.com, linux-security-module@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andrew Perepechko <anserper@ya.ru>,
 Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov,
 Eric Paris <eparis@redhat.com>, Paul Moore <pmoore@redhat.com>
Subject: Re: [PATCH] security/selinux: Change bool variable name to index.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 14 Apr 2016 15:51:24 +0100
Message-ID: <26000.1460645484@warthog.procyon.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Prarit Bhargava <prarit@redhat.com> wrote:

> security_get_bool_value(int bool) argument "bool" conflicts with in-kernel
> macros such as BUILD_BUG().  This patch changes this to index which isn't
> a type.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>

Acked-by: David Howells <dhowells@redhat.com>
