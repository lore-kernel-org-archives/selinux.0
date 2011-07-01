Subject: Re: context of files not adapted to new directory when moved (was:
 htpasswd file outside of standard Apache location)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1309388512.13175.35.camel@mattotaupa>
References: <1309366657.4648.40.camel@mattotaupa>
	 <1309367740.3643.12.camel@localhost.localdomain>
	 <1309388512.13175.35.camel@mattotaupa>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Jul 2011 09:46:21 -0400
Message-ID: <1309527981.31276.21.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-06-30 at 01:01 +0200, Paul Menzel wrote:
> That solved my problem. The reason seems to be that I had that file
> first in my home directory and then used
> 
>         sudo mv ~/bar.tar.gz /srv/www/…
> 
> to move it to the Web site directory. `mv` seems to preserve the old
> SELinux contexts and I have to relabel it afterward. Is there a way to
> make the relabel step obsolete?

The semantics of mv are that it preserves the attributes of the original
file.  In the case where the source and destination are within the same
filesystem, mv uses rename(2) and thus the file (inode) doesn't change
at all, so you wouldn't expect any of the attributes to change.

If you had instead used cp, then the attributes would not have been
preserved by default (unless you used the appropriate options), and the
new file that was created would have been labeled in accordance with the
parent directory.

Some versions of install are instrumented to explicitly look up the
SELinux context from the file_contexts configuration and set the label
on the newly installed file accordingly.  Package managers like rpm and
dpkg are likewise instrumented.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
