Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4NKZT5h007187
	for <selinux@tycho.nsa.gov>; Wed, 23 May 2012 16:35:29 -0400
Received: by werj55 with SMTP id j55so5745214wer.12
        for <selinux@tycho.nsa.gov>; Wed, 23 May 2012 13:35:27 -0700 (PDT)
Date: Wed, 23 May 2012 22:35:19 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Re: Trying to support Python 3 but fails on libsemanage
Message-ID: <20120523203519.GA13394@siphos.be>
References: <20120516091736.GA10721@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20120516091736.GA10721@siphos.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 16, 2012 at 11:17:36AM +0200, Sven Vermeulen wrote:
> I'm trying to get Python 3 support up and going with the SELinux userspace
> utilities. I'm hitting a compatibility issue that I'm not able to work out
> further.
> 
> This is the following "test case":
> 	semanage fcontext -a -t swapfile_t /swapfile
> 	semanage fcontext -d -t swapfile_t /swapfile
> 
> With Python 2.7, this works as it should be. With Python 3.2 however, I get
> the following error while trying to delete the entry:
> 
> /usr/sbin/semanage: File context for /swapfile is not defined

I've not been able to debug this much further, but this is as far as I got
today...

(1.) semanage (the python script) calls the python seobject class, more
     specifically the seobject.fcontextRecords class
(2.) in seobject.fcontextRecords, deleting a file context goes to the
     __delete function
(3.) in __delete, semanage_fcontext_key_create(self.sh, target,
     file_type[fstype]) is called, which returns rc (return code) and k (the
     key used to interact with libsemanage)

     self.sh is a handle used to keep track of the "transaction", target is
     the string of the file context to delete (like "/swapfile"),
     file_type[fstype] here is for specific types of contexts

(4.) semanage_fcontext_key_create() goes to the _semanage.so shared library
     (through semanage.py which imports _semanage), which is created from the
     libsemanage code through swig

(5.) The semanage_fcontext_key_create() function is defined in
     src/fcontext_record.c. It allocates memory, puts in the information
     (like expression = "/swapfile") and returns the address of this memory
     location as key

So far I can follow how things go. Since the Python script uses the
_semanage.so as library, it can (or should) use the memory address without
problems (no forks or so involved, so the memory address should remain
correct, right?)

However, what happens next is a bit too unclear to me. 

(6.) In seobject.py, the function "semanage_fcontext_exists_local" is
     called. The name obviously tells me we're going to see if the file
     definition is mentioned in the file_contexts.local so that it can be
     removed. It uses the key as a reference to seek this information.
(7.) semanage_fcontext_exists_local is defined in src/fcontexts_local.c, but
     this contains the following:

        dbase_config_t *dconfig = semanage_fcontext_dbase_local(handle);
        return dbase_exists(handle, dconfig, key, response);

     What is semanage_fcontext_dbase_local(handle)'s job? Is this to define
     the target database to work with (in our case, for file contexts)?
(8.) dbase_exists() is defined in src/databqse.c. It calls the following:

        dconfig->dtable->exists(handle, dconfig->dbase, key, response)

     I assume the function "exists" depends on the dtable, which comes from
     dconfig, and which - in our case - will refer to
     semanage_fcontext_compare (in src/fcontext_record.c)

Now here's where the fun part comes in.

In both semanage_fcontext_key_create() and semanage_fcontext_compare() I
have added some debugging statements, namely:

fprintf(stderr, "DEBUG - create: key is %u, expr is \"%s\"\n", key, key->expr);
and
fprintf(stderr, "DEBUG - compare: key is %u, expr is \"%s\"\n", key, key->expr);


When I run the mentioned use case with Python 2.7, I get the following
(expected) output:

DEBUG - create: key is 3216874400, expr is "/swapfile"
DEBUG - compare: key is 3216874400, expr is "/swapfile"
DEBUG - compare: key is 3216874400, expr is "/swapfile"

after which it gets deleted (the two compare-debug lines are because the
file_contexts.local has two entries, and the second one matches).

With Python 3.2, it becomes the following:

DEBUG - create: key is 973543696, expr is "/swapfile"
DEBUG - compare: key is 973543696, expr is ""�0^\"
DEBUG - compare: key is 973543696, expr is ""�0^\"
...


Somewhere between creating the key and checking its content, the content of
the memory is changed (or the target of the pointer pointing to the
expression). Since the key itself (address) is unchanged, this is done
somewhere in the libsemanage code, right?

But if it is, and the code doesn't seem to have any #if PY_MAJOR_VERSION ...  #endif
constructs in it, what can then cause Python 2.7 to behave differently here?
Is it the swig'ed result that differs from Python 2.7 and Python 3.2? If so,
is there any way this can be debugged easily?

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
