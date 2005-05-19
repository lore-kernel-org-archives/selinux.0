Subject: Re: Latest Diff
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>, Jim Carter <jwcart2@epoch.ncsc.mil>
In-Reply-To: <428CE032.8040501@redhat.com>
References: <428CE032.8040501@redhat.com>
Content-Type: text/plain
Date: Thu, 19 May 2005 17:36:06 -0400
Message-Id: <1116538566.16297.35.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Added From Ivan:
>         mount_point attribute to indicate files/directories that can be 
> mounted on.

...okay

>         read_fonts

This is work in progress, but it's probably fine as merged by Dan Walsh.
IMHO it should have been in fontconfig_macros.te (but read below why
that shouldn't be merged yet). The purpose of the macro is to
centralize font handling, and later add per user fonts - that
part is missing now, as you can see the second argument is not handled.

Corrections:

In base:
+# Read mime types
+read_fonts($1_t, $1)
+
comment is incorrect.

In rhgb:
-# for fonts
-allow rhgb_t usr_t:{ file lnk_file } { getattr read };
-
Potential for damage here, as read_fonts macro is not equivalent.
Needs to be tested.

>         fontconfig

This is work in progress - Dan has merged only part of the patch
that I was fixing/about to send, and there's some problems with that.
Please revert the fontconfig_macros.te, fontconfig.te and fonconfig.fc,
(and the change to base_user since it won't work as intended yet). 
The font cache needs to be created with the proper type by
libfontconfig. More handling is needed for $HOME_DIR/.fonts.conf.
Comments are also somewhat incorrect. 

In java:
-# Do not audit read/getattr of .fonts-cache-1
-dontaudit $1_javaplugin_t $1_home_t:file { read getattr };

Please restore if fontconfig is dropped.

>         getattr patches
>         gift patches

This will work...

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
