Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3AD03Ii028694
 for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2014 09:00:03 -0400
References: <1396968778-19260-1-git-send-email-richard_c_haines@btinternet.com>
 <5344373A.1090908@tresys.com>
Message-ID: <1397134801.90683.YahooMailNeo@web87906.mail.ir2.yahoo.com>
Date: Thu, 10 Apr 2014 14:00:01 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH 0/4] APOL Enhancements to support additional policy
 features
To: Steve Lawrence <slawrence@tresys.com>
In-Reply-To: <5344373A.1090908@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: "setools-bugs@tresys.com" <setools-bugs@tresys.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Most of the libapol/libqpol changes are based on the current structure for adding new statements etc.
Likewise for the tcl/tk. The only two areas I had problems were:

1) libsefs/src/new_ftw.c - This area caused the apol and indexcon to hang when broken links found.
   I could not understand why the code was there so just did a kludge:
-#if ! _LIBC && ! LSTAT_FOLLOWS_SLASHED_SYMLINK
+/* If this is used on Linux (Fedora) when a sym link or file is broken,
+   the file context function will hang forever:
+       #if ! _LIBC && ! LSTAT_FOLLOWS_SLASHED_SYMLINK
+   Therefore changed to this so uses Linux lstat function. */
+#if _LIBC && ! LSTAT_FOLLOWS_SLASHED_SYMLINK

2) When coding the iter functions in libqpol (e.g. qpol_policy_get_default_object_iter)
   I could not see how this worked so I just used the base object count
  (e.g. number of classes - as these held the default object_items), and then counted
  each default_object in top.tcl to arrive at the actual number of default_objects. I did the
  same for userbounds etc.

Richard




----- Original Message -----
From: Steve Lawrence <slawrence@tresys.com>
To: Richard Haines <richard_c_haines@btinternet.com>; selinux@tycho.nsa.gov; setools-bugs@tresys.com
Cc: 
Sent: Tuesday, 8 April 2014, 18:51
Subject: Re: [PATCH 0/4] APOL Enhancements to support additional policy features

On 04/08/2014 10:52 AM, Richard Haines wrote:
> These four patches will update setools-3.3.8.tar.bz2 available from
> http://oss.tresys.com/projects/setools/wiki/download
> 

Thanks for the patchset! We would love to have apol updated to support
the latest toolchain better. Just a heads up though, this is a pretty
sizable patchset with some pieces I'm not too familiar with (i.e. tcl),
and I'll be on vacation next week, so it might take 2-3 weeks before we
can fully review this and merged it into setools.

Thanks!
- Steve
