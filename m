Subject: Re: [patch] allow users of tmp_domain to read /usr/tmp
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1105565245.4415.29.camel@nexus.verbum.private>
References: <1105565245.4415.29.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1105566103.23136.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 16:41:43 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 16:27, Colin Walters wrote:
> Hi,
> 
> On Fedora at least, /usr/tmp is a symlink to /var/tmp.  Users of
> tmp_domain get write access to tmp_t:dir, so I think it makes sense to
> automatically grant access to tmp_t:lnk_file as well, so that programs
> which refer to /usr/tmp work.  This should be safe since as discussed
> earlier no non-unconfined domain can create tmp_t:lnk_file.
> 
> This came up on the #fedora-selinux channel where a user was trying to
> get their CGI script to work.

Hmm...I had thought that we had agreed that /usr/tmp should be dropped
from types.fc and left in usr_t, then just allow read to usr_t:lnk_file
as a safer approach.  In fact, the current types.fc file only assigns
tmp_t if /usr/tmp is a directory (via the -d flag), and it is labeled
usr_t on my FC3 systems (strict).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
