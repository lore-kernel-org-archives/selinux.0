Subject: Re: [PATCH] Fixed & updated SELinux support patch for coreutils
	5.2.1
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1103804036.27286.11.camel@localhost.localdomain>
References: <1103804036.27286.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1104155614.15615.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 27 Dec 2004 08:53:34 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-12-23 at 07:13, Lorenzo Hernández García-Hierro wrote:
> Hi,
> 
> After trying to apply the SELinux support coreutils patch, it didn't
> applied at all against GNU's coreutils-5.2.1.
> 
> I have fixed and updated the patch which applies without any problem
> against 5.2.1 from gnu.org, also adds a little PACKAGE_STRING change
> which explicitly says it has SELinux support to avoid any confusion.
> 
> The rest of things remain untouched and clean.

I'd recommend pulling the latest SELinux userspace patches from the
Fedora Core CVS tree, see http://cvs.fedora.redhat.com/core.shtml.  The
SELinux patch there is against coreutils 5.2.1, but with other patches
also applied, which might explain why you had rejects.  Red Hat took
over maintaining the SELinux userspace patches back in early 2003 when
Dan Walsh ported them to the 2.6 SELinux API and started expanding them
to more programs.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
