Subject: Re: mdadm policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: antoine <antoine@nagafix.co.uk>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1119569243.9390.77.camel@localhost>
References: <1119569243.9390.77.camel@localhost>
Content-Type: text/plain
Date: Fri, 24 Jun 2005 07:29:26 -0400
Message-Id: <1119612566.12865.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-24 at 00:27 +0100, antoine wrote:
> I was looking for a policy for mdadm, I know there is one in Fedora, but
> I use gentoo and I couldn't download it without getting the whole rpm,
> so I ended up writing one (attached) - it is also a good learning
> exercise. Shouldn't it be in serefpolicy.sourceforge.net?

The reference policy being developed by Tresys Technology is still in
early development, and doesn't yet include an equivalent to everything
from the upstream example policy.  But you can grab individual files
from the upstream example policy from the selinux sourceforge CVS tree,
e.g.:
http://cvs.sourceforge.net/viewcvs.py/selinux/nsa/selinux-usr/policy/domains/program/unused/mdadm.te?rev=1.14&view=log
http://cvs.sourceforge.net/viewcvs.py/selinux/nsa/selinux-usr/policy/file_contexts/program/mdadm.fc?rev=1.3&view=log

Also, there is a public Fedora CVS tree (but that likely doesn't help
too much, as you would still need to extract the files from the tarball,
since the Fedora CVS tree is organized for packaging rather than
upstream development, i.e. an upstream tarball + patches + spec file).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
