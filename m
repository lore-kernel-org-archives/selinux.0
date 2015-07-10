Message-ID: <559FF186.7090008@tycho.nsa.gov>
Date: Fri, 10 Jul 2015 12:23:34 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Roberts, William C" <william.c.roberts@intel.com>,
 William Roberts <bill.c.roberts@gmail.com>
Subject: Re: executing off of a fusefs
References: <476DC76E7D1DF2438D32BFADF679FC560102C611@ORSMSX103.amr.corp.intel.com>	<559FBD3A.4090300@tycho.nsa.gov>
 <CAFftDdqP616u6UDZQAnd8AucCz=EXm0mY1Uhcwmp3x9rmWNBgg@mail.gmail.com>
 <476DC76E7D1DF2438D32BFADF679FC560102C7C5@ORSMSX103.amr.corp.intel.com>
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC560102C7C5@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Cc: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/10/2015 11:53 AM, Roberts, William C wrote:
> Also, I see the manpage for mount has rootcontext, does this provide the
> rootnode context so the xattr won’t be queried, or does it provide some
> transient
> label that is replaced at  mount with the xattr query?

rootcontext= is typically used to assign a specific context to the root
directory of e.g. tmpfs mounts, rather than having to first mount it and
then change the context to some value.

Using it wouldn't suppress the getxattr call by SELinux for a
fs_use_xattr filesystem, as SELinux always does that regardless just to
probe whether the filesystem supports security xattrs (if not, then it
will fail the mount).  It would however override any underlying xattr
value for the root directory.
