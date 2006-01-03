Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k03FucXf019896
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 10:56:38 -0500 (EST)
Received: from web51507.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k03FuUah001497
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 15:56:30 GMT
Message-ID: <20060103155531.9154.qmail@web51507.mail.yahoo.com>
Date: Tue, 3 Jan 2006 07:55:31 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: setfiles and restorecon performance patch
To: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>,
   Daniel Walsh <dwalsh@redhat.com>, "Stephen C. Tweedie" <sct@redhat.com>
In-Reply-To: <200601031959.34132.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Just a couple comments:

>@@ -143,7 +141,7 @@ int restore(char *filename) {
>     if (verbose>1)
>       fprintf(stderr,"Warning! %s refers to a symbolic link, not
> following last component.\n", filename);
>     char *p = NULL, *file_sep;
>-    char *tmp_path = strdup(filename);
>+    char *tmp_path = strdupa(filename);
>     if (!tmp_path) {
>       fprintf(stderr,"strdup on %s failed:  %s\n", >filename,strerror(errno));

Do you need to check for NULL on strdupa calls? If so, the error message needs to
have the function updated, too. Otherwise this can be deleted.


>@@ -155,14 +153,16 @@ int restore(char *filename) {
>       file_sep++;
>       p = realpath(tmp_path, path);
>     }
>-    if (!p || strlen(path) + strlen(file_sep) + 1 > PATH_MAX) {
>+    size_t len = strlen(p);
>+    if (!p || len + strlen(file_sep) + 2 > PATH_MAX) {

What if realpath returned NULL? strlen is using a NULL pointer and then p is
checked in the second line to see if its NULL.

-Steve


		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
