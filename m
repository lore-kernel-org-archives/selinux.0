Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7JFxofe022130
	for <selinux@tycho.nsa.gov>; Sun, 19 Aug 2012 11:59:50 -0400
Message-Id: <201208191559.q7JFxK1G029013@vivaldi06.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2]: seobject.py must skip comments while reading external configuration files
Date: Sun, 19 Aug 2012 17:59:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>Hello.
>
>Apparently semanage does not work properly when the external configuration file "file_contexts.subs_dist" (from the policy) contains #-comments.
>
>The patch attached below aims to fix this: seobject.py must skip comments while reading the external configuration file "file_contexts.subs_dist".

I have created an improved version of the patch mentioned in the subject.

Fix fcontextRecords() in policycoreutils/semanage/seobject.py so
that semanage does not produce an error in fcontext mode when
the file_contexts.subs_dist file contains comments (prefixed by #).

Properly skip blank lines.

Treat both white space and tab as valid separators for the above
mentioned policy configuration file (v2). Minimum number of
changes (v2bis).

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
Reported-by: Sven Vermeulen <sven.vermeulen@siphos.be>
---
 policycoreutils/semanage/seobject.py |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- selinux-20072012/policycoreutils/semanage/seobject.py	2012-07-20 17:09:41.361112761 +0200
+++ selinux-20072012-policycoreutils-semanage-seobject_skip_comments-v2bis/policycoreutils/semanage/seobject.py	2012-08-19 19:33:18.822279742 +0200
@@ -1628,6 +1628,11 @@ class fcontextRecords(semanageRecords):
                 try:
                        fd = open(selinux.selinux_file_context_subs_path(), "r")
                        for i in fd.readlines():
+                              i = i.strip()
+                              if len(i) == 0:
+                                     continue
+                              if i.startswith("#"):
+                                     continue
                               target, substitute = i.split()
                               self.equiv[target] = substitute
                        fd.close()
@@ -1636,6 +1641,11 @@ class fcontextRecords(semanageRecords):
                 try:
                        fd = open(selinux.selinux_file_context_subs_dist_path(), "r")
                        for i in fd.readlines():
+                              i = i.strip()
+                              if len(i) == 0:
+                                     continue
+                              if i.startswith("#"):
+                                     continue
                               target, substitute = i.split()
                               self.equiv_dist[target] = substitute
                        fd.close()


>>On Tue, Aug 14, 2012 at 08:03:58AM -0400, Christopher J. PeBenito wrote:
>>> On 08/10/12 09:13, Guido Trentalancia wrote:
>>> > Add a comment at the top of the configuration file file_contexts.subs_dist
>>> > to clarify that it performs aliasing and not substitutions in the
>>> > strict sense of the word.
>>> > 
>>> > A name change might be considered too, if it proves to lead to further
>>> > confusion.
>>> > 
>>> > There might be pieces of documentation that could benefit from similar
>>> > considerations.
>>> > 
>>> > Also note that a specific manual page is missing.
>>> > 
>>> > Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
>>> > ---
>>> >  config/file_contexts.subs_dist |   10 ++++++++++
>>> >  1 file changed, 10 insertions(+)
>>> > 
>>> > diff -pruN refpolicy-08092012/config/file_contexts.subs_dist refpolicy-08092012-file_contexts.subs_dist-comment/config/file_contexts.subs_dist
>>> > --- refpolicy-08092012/config/file_contexts.subs_dist    2012-06-21 20:10:29.011803405 +0200
>>> > +++ refpolicy-08092012-file_contexts.subs_dist-comment/config/file_contexts.subs_dist 2012-08-10 17:01:36.045451839 +0200
>>> > @@ -1,3 +1,13 @@
>>> > +# This file can is used to configure base path aliases as in:
>>> > +#
>>> > +# /aliased_path /original_path_as_configured_in_file_contexts
>>> > +#
>>> > +# where original_path_as_configured_in_file_contexts is a base
>>> > +# path being used in the main file_contexts configuration file.
>>> > +#
>>> > +# It does not perform substitutions as done by sed(1), for
>>> > +# example, but aliasing.
>>> > +#
>>> >  /lib32 /lib
>>> >  /lib64 /lib
>>> >  /run /var/run
>>> 
>>> Merged.
>>
>>This seems to break policycoreutils:
>>
>># semanage fcontext -l
>>/usr/sbin/semanage: too many values to unpack (expected 2)
>>
>>Undoing the comment change fixes things again.
>
>All is needed is something like this for selinux-userspace (policycoreutils):
>
>Fix fcontextRecords() in policycoreutils/semanage/seobject.py so
>that semanage does not produce an error in fcontext mode when
>the file_contexts.subs_dist file contains comments (prefixed by #).
>
>Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
>Reported-by: Sven Vermeulen <sven.vermeulen@siphos.be>
> 
>---
> policycoreutils/semanage/seobject.py |   18 ++++++++++++++----
> 1 file changed, 14 insertions(+), 4 deletions(-)
>
>--- selinux-20072012/policycoreutils/semanage/seobject.py	2012-07-20 17:09:41.361112761 +0200
>+++ selinux-20072012-policycoreutils-semanage-seobject_skip_comments/policycoreutils/semanage/seobject.py	2012-08-18 17:11:10.038514334 +0200
>@@ -1627,16 +1627,26 @@ class fcontextRecords(semanageRecords):
>                 self.equal_ind = False
>                 try:
>                        fd = open(selinux.selinux_file_context_subs_path(), "r")
>-                       for i in fd.readlines():
>-                              target, substitute = i.split()
>+                       for i in fd.read().split("n"):
>+                              i = i.strip()
>+                              if len(i) == 0:
>+                                     continue
>+                              if i.startswith("#"):
>+                                     continue
>+                              target, substitute = i.split(" ")
>                               self.equiv[target] = substitute
>                        fd.close()
>                 except IOError:
>                        pass
>                 try:
>                        fd = open(selinux.selinux_file_context_subs_dist_path(), "r")
>-                       for i in fd.readlines():
>-                              target, substitute = i.split()
>+                       for i in fd.read().split("n"):
>+                              i = i.strip()
>+                              if len(i) == 0:
>+                                     continue
>+                              if i.startswith("#"):
>+                                     continue
>+                              target, substitute = i.split(" ")
>                               self.equiv_dist[target] = substitute
>                        fd.close()
>                 except IOError:

Regards,

Guido 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
