Message-ID: <40A5014A.9060400@snu.edu>
Date: Fri, 14 May 2004 12:26:34 -0500
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: SELinux <SELinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>,
   Eamon Walsh <ewalsh@epoch.ncsc.mil>
Subject: Re: X policy classes
References: <40A464EB.5030008@snu.edu> <1084536340.17741.15.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1084536340.17741.15.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Fri, 2004-05-14 at 02:19, Joshua Brindle wrote:
>  
>
>>We noticed today that the SE-X policy classes have been merged into the 
>>sf.net cvs policy. Is there an ETA on when those will be merged into the 
>>kernel headers?
>>    
>>
>
>Mea culpa.  I planned on waiting until we had an actual update that
>affected the kernel code, e.g. the new netlink classes and permissions
>under development by James Morris.  Also, there is a planned overhaul
>for the kernel access vectors at some point to prune obsolete
>permissions, possibly re-organize the remaining permissions more
>sensibly, and deal with known gaps (e.g. we actually do need an execute
>permission for packet sockets to deal with mmap'd packet sockets).  The
>kernel doesn't need the definitions for the SE-X classes and
>permissions, although it is true that the classes do affect any
>subsequently defined classes (so this will affect James' netlink
>classes; they'll need to be shifted unless we are willing to perturb the
>values of the X classes).
>
>  
>
>>Another idea might be to add the pax class to the standard access_vector 
>>  file but I'm not sure how receptive that would be since afaik we are 
>>the only ones using it.
>>    
>>
>
>We should likely go ahead and merge your pax class and access vector
>definition to avoid future changes to its value, as a running SELinux
>kernel won't accept a policy reload that changes an existing class value
>(since existing code may be using the definition).  Send a current patch
>for policy/flask/*.
>
>  
>
This should be against the latest cvs, thanks for merging this

--- access_vectors.orig 2004-05-13 20:15:15.214145728 -0500
+++ access_vectors      2004-05-13 12:37:39.315076824 -0500
@@ -357,6 +357,20 @@
 }
 
 #
+# Define the access vector interpretation for controlling
+# PaX flags
+#
+class pax
+{
+        pageexec        # Paging based non-executable pages
+        emutramp        # Emulate trampolines
+        mprotect        # Restrict mprotect()
+        randmmap        # Randomize mmap() base
+        randexec        # Randomize ET_EXEC base
+        segmexec        # Segmentation based non-executable pages
+}
+
+#
 # SE-X Windows stuff
 #
 class drawable
--- security_classes.orig       2004-05-13 20:15:19.898433608 -0500
+++ security_classes    2004-05-13 12:37:47.489834072 -0500
@@ -47,6 +47,9 @@
 # passwd/chfn/chsh
 class passwd
 
+# pax flags
+class pax
+
 # SE-X Windows stuff
 class drawable
 class window

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
