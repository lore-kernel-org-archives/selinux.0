Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4QGiGrW029964
	for <selinux@tycho.nsa.gov>; Sat, 26 May 2012 12:44:21 -0400
Received: by wibhm14 with SMTP id hm14so357276wib.12
        for <selinux@tycho.nsa.gov>; Sat, 26 May 2012 09:44:19 -0700 (PDT)
Date: Sat, 26 May 2012 18:44:05 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Re: Trying to support Python 3 but fails on libsemanage
Message-ID: <20120526164404.GA16921@siphos.be>
References: <20120516091736.GA10721@siphos.be>
 <20120523203519.GA13394@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20120523203519.GA13394@siphos.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 23, 2012 at 10:35:19PM +0200, Sven Vermeulen wrote:
> > This is the following "test case":
> > 	semanage fcontext -a -t swapfile_t /swapfile
> > 	semanage fcontext -d -t swapfile_t /swapfile
> > 
> > With Python 2.7, this works as it should be. With Python 3.2 however, I get
> > the following error while trying to delete the entry:
> > 
> > /usr/sbin/semanage: File context for /swapfile is not defined
> 
[...]
> (5.) The semanage_fcontext_key_create() function is defined in
>      src/fcontext_record.c. It allocates memory, puts in the information
>      (like expression = "/swapfile") and returns the address of this memory
>      location as key
[...]
> Somewhere between creating the key and checking its content, the content of
> the memory is changed (or the target of the pointer pointing to the
> expression). Since the key itself (address) is unchanged, this is done
> somewhere in the libsemanage code, right?
> 
> But if it is, and the code doesn't seem to have any #if PY_MAJOR_VERSION ...  #endif
> constructs in it, what can then cause Python 2.7 to behave differently here?
> Is it the swig'ed result that differs from Python 2.7 and Python 3.2? If so,
> is there any way this can be debugged easily?

David Malcolm gave me a good hint at what to look for.

The key that is created contains a link towards a regular expression (in the
above use case, that expression would be "/swapfile") which is passed on
from the Python code towards the shared library (through
semanage_fcontext_key_create). I think that, in Python 2.7, the memory
allocation for this expression is either not freed at the same time as with
Python 3.2, or it is freed but not reused (in which case the stale
information is still there).

If I apply the following patch to libsemanage, the use case works for both
Python 2.7 and Python 3.2.

Wkr,
	Sven Vermeulen

diff -ur libsemanage-2.1.6.orig/src/fcontext_record.c libsemanage-2.1.6/src/fcontext_record.c
--- libsemanage-2.1.6.orig/src/fcontext_record.c	2012-05-22 21:50:23.416071391 +0200
+++ libsemanage-2.1.6/src/fcontext_record.c	2012-05-26 09:08:22.125114161 +0200
@@ -45,7 +45,11 @@
 		    "create file context key");
 		return STATUS_ERR;
 	}
-	tmp_key->expr = expr;
+	tmp_key->expr = strdup(expr);
+	if (!tmp_key->expr) {
+		ERR(handle, "out of memory, could not create file context key.");
+		return STATUS_ERR;
+	}
 	tmp_key->type = type;
 
 	*key_ptr = tmp_key;
@@ -74,6 +79,7 @@
 
 void semanage_fcontext_key_free(semanage_fcontext_key_t * key)
 {
+	free(key->expr);
 	free(key);
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
