Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k03KN7Xf024276
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 15:23:07 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k03KN5ah009868
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 20:23:05 GMT
Message-ID: <43BADD13.30603@tresys.com>
Date: Tue, 03 Jan 2006 15:22:43 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Steve G <linux_4ever@yahoo.com>, Ulrich Drepper <drepper@redhat.com>,
   SE-Linux <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>,
   "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: setfiles and restorecon performance patch
References: <20060103155531.9154.qmail@web51507.mail.yahoo.com> <200601040608.56218.russell@coker.com.au>
In-Reply-To: <200601040608.56218.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Wednesday 04 January 2006 02:55, Steve G <linux_4ever@yahoo.com> wrote:
> 
>>>@@ -143,7 +141,7 @@ int restore(char *filename) {
>>>    if (verbose>1)
>>>      fprintf(stderr,"Warning! %s refers to a symbolic link, not
>>>following last component.\n", filename);
>>>    char *p = NULL, *file_sep;
>>>-    char *tmp_path = strdup(filename);
>>>+    char *tmp_path = strdupa(filename);
>>>    if (!tmp_path) {
>>>      fprintf(stderr,"strdup on %s failed:  %s\n",
>>>
>>>>filename,strerror(errno));
>>
>>Do you need to check for NULL on strdupa calls? If so, the error message
>>needs to have the function updated, too. Otherwise this can be deleted.
> 
> 
> Not sure.  The alloca() man page says that the failure result is undefined but 
> the strdupa() man page says nothing (implies that it's the same as strdup()).
> 
> Ulrich?
> 
> 
>>>@@ -155,14 +153,16 @@ int restore(char *filename) {
>>>      file_sep++;
>>>      p = realpath(tmp_path, path);
>>>    }
>>>-    if (!p || strlen(path) + strlen(file_sep) + 1 > PATH_MAX) {
>>>+    size_t len = strlen(p);
>>>+    if (!p || len + strlen(file_sep) + 2 > PATH_MAX) {
>>
>>What if realpath returned NULL? strlen is using a NULL pointer and then p
>>is checked in the second line to see if its NULL.
> 
> 
> Fixed that, attached a new patch.

strdupa man page says it's a GNU extension, does this work on BSD? We 
should not be making non-portable changes to libraries as SEBSD has the 
potential to catch up and start using these new libraries.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
