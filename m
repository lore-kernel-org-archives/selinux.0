Subject: Re: Bug in restorecon for symlinks in root dir
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Erich Schubert <erich@debian.org>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <1156205841.22905.33.camel@wintermute.xmldesign.de>
References: <1156205841.22905.33.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 11:27:35 -0400
Message-Id: <1156346855.8506.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-22 at 02:17 +0200, Erich Schubert wrote:
> Hi,
> restorecon has a bug for symlinks in the root directory, such
> as /vmlinuz
> or the /lib64 -> /lib symlink found on all debian amd64 systems.
> 
> The bug arises in the way the containing directories "realname" is found
> for symlinks. Basically, the directory name is split by overwriting the
> last / character with a \0 char; then calling realname(3) on the first
> component, then joining them again.
> For obvious reasons, this doesn't work for filenames such as /lib64; but
> it only affects symlinks (thats why "restorecon /etc" works fine).
> The easiest workaround is to use "restorecon //lib64"
> 
> Attached is a patch to fix this bug. It's untested yet, but I guess
> you'll review it anyway. And it's a very easy thing, it's got to
> work. ;-)

I don't think that this is quite what we want either.  As patched, we do
get the same behavior as we would with an unpatched workaround of
using //lib64, which also isn't what we want:
# restorecon -nv /lib64
restorecon reset //lib64 context user_u:object_r:root_t:s0->system_u:object_r:default_t:s0
versus the expected result of:
restorecon reset /lib64 context user_u:object_r:root_t:s0->system_u:object_r:lib_t:s0

The following seems to work, although it is a bit strange.  Possibly the
entire approach there needs to be reworked.

Index: policycoreutils/restorecon/restorecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/restorecon/restorecon.c,v
retrieving revision 1.40
diff -u -p -r1.40 restorecon.c
--- policycoreutils/restorecon/restorecon.c	29 Jun 2006 18:21:14 -0000	1.40
+++ policycoreutils/restorecon/restorecon.c	23 Aug 2006 14:59:00 -0000
@@ -178,7 +178,10 @@ int restore(const char *filename)
 			return 1;
 		}
 		file_sep = strrchr(tmp_path, '/');
-		if (file_sep) {
+		if (file_sep == tmp_path) {
+			file_sep++;
+			p = strcpy(path, "");
+		} else if (file_sep) {
 			*file_sep = 0;
 			file_sep++;
 			p = realpath(tmp_path, path);



-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
