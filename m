Subject: Re: Bug in restorecon for symlinks in root dir
From: Erich Schubert <erich@debian.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <1156433253.8506.175.camel@moss-spartans.epoch.ncsc.mil>
References: <1156205841.22905.33.camel@wintermute.xmldesign.de>
	 <1156346855.8506.62.camel@moss-spartans.epoch.ncsc.mil>
	 <1156354840.2883.4.camel@wintermute.xmldesign.de>
	 <1156433253.8506.175.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 24 Aug 2006 21:03:06 +0200
Message-Id: <1156446186.13088.45.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen,
> restorecon /etc//shadow or //lib64/libc.so.6 appear to work correctly,
> but restorecon //lib64 would end up with default_t even with this patch.

Ah, yes. That is another corner case. Has anyone tried what realname()
does if the filename always contains that trailing slash? For the root
directory it won't strip it, but what for e.g. /dev/?
I.e. if we wouldn't transform
/some/path/filename  to  /some/path\0filename
then call realname on the first part, but actually copy the path
including the last / to a temporary variable, then calling realpath() on
that?

Or maybe just use this fragment:
--- restorecon.c        2006-08-24 20:57:56.000000000 +0200
+++ restorecon.c        2006-08-24 21:01:44.000000000 +0200
@@ -197,8 +197,11 @@
                        return 1;
                }
                p += len;
-               *p = '/';
-               p++;
+               /* ensure trailing slash of directory name */
+               if (len == 0 || *(p-1) != '/') {
+                       *p = '/';
+                       p++;
+               }
                strcpy(p, file_sep);
                filename = path;
        } else {

The len==0 part should never be needed.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
 The early bird gets the worm, but the second mouse gets the cheese.  //\
  Wie kann ich wissen, was ich denke, bevor ich höre, was ich sage.   V_/_



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
