Subject: Re: setfiles segfault
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1112919608.2991.31.camel@chris.pebenito.net>
References: <1112919608.2991.31.camel@chris.pebenito.net>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 08:40:51 -0400
Message-Id: <1112964051.32127.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-04-07 at 20:20 -0400, Chris PeBenito wrote:
> On the current setfiles, if you do altroot, and you point it at an empty
> directory, it segfaults:
> 
> gorn setfiles # ./setfiles /etc/security/selinux/file_contexts -d -r /tmp/empty/ /tmp/empty/
> ./setfiles:  labeling files, pretending /tmp/empty is /
> ./setfiles:  labeling files under /tmp/empty/
> Segmentation fault
> gorn setfiles # touch /tmp/empty/foo
> gorn setfiles # ./setfiles /etc/security/selinux/file_contexts -d -r /tmp/empty/ /tmp/empty/
> ./setfiles:  labeling files, pretending /tmp/empty is /
> ./setfiles:  labeling files under /tmp/empty/
> ./setfiles:  /tmp/empty/foo matched by system_u:object_r:default_t
> matchpathcon_filespec_eval:  hash table stats: 1 elements, 1/65536 buckets used, longest chain length 1
> ./setfiles:  Done.
> 
> As evidenced above, the altroot directory does not match the root
> directory correctly.  Any trailing /'s are stripped by the time the path
> gets used in the match() call, which is correct.  But then if there is
> an altroot, the name pointer is advanced by the length of the root path
> string to strip off the altroot path, for matching.  This works in all
> cases, except for the root directory, which becomes an empty string
> since the path is the same as the altroot path.  Since the lstat() in
> the function uses the true path, it succeeds, but the
> matchpathcon_index() fails, leaving the hashtable empty (fl_head is
> null).  Then when we get back to main and do the
> matchpathcon_filespec_destroy(), the function tries to free a null
> pointer, causing the segfault.
> 
> The attached patch fixes this condition, by checking if the name is an
> empty string.  I initially considered concatenating on a / in this case,
> rather then the current implementation, but this won't work since all
> the strings are const.  It also removes buf from the function, as it
> seems redundant, since the one operation done to buf is also done to
> name, and buf is just a copy of name.  This patch is against sourceforge
> cvs.
> 
>  setfiles.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)

Thanks, merged into policycoreutils 1.23.4.  I also modified
matchpathcon_filespec_destroy in libselinux 1.23.6 to check for a null
fl_head on entry.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
