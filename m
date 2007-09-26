Subject: Re: puzzles about hidden_def and hidden_proto
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ken YANG <spng.yang@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <46FA361C.8080008@gmail.com>
References: <46FA361C.8080008@gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Wed, 26 Sep 2007 10:06:09 -0400
Message-Id: <1190815569.15779.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-26 at 18:36 +0800, Ken YANG wrote:
> hi all,
> 
> i have three puzzles about the macro "hidden_def"
> and "hidden_proto" in "libsepol/src/dso.h".

They came from Ulrich Drepper.
See:
http://people.redhat.com/drepper/dsohowto.pdf

They are to create and use private definitions of the symbols for calls
to them within the shared library to avoid relocations on them, as that
has a cost and is usually unnecessary (you typically don't need to
permit interposition on such calls).  You declare them with
hidden_proto() in a header file (see src/*_internal.h), include those
headers in the .c files that use those symbols, and put a hidden_def()
in the .c file after the definition.

> i copy the definitions of these two macros into
> a separate header file to test these two macros,
> and assembly them:
> 
> $ cat hidden_def.h
> 
> int extern_i=12345;
> #define hidden __attribute__ ((visibility("hidden")))
> #define hidden_proto(fct) __hidden_proto (fct, fct##_internal)
> #define __hidden_proto(fct, internal)   \
>         extern __typeof(fct) internal;  \
>         extern __typeof(fct) fct __asm (#internal) hidden;
> #define hidden_def(fct) \
>         asm (".globl " #fct "\n.set " #fct ", " #fct "_internal");
> 
> $ cat hidden_def.c
> 
> #include "hidden_def.h"
> int main()
> {
>         hidden_proto(extern_i);
> }
> 
> $ gcc -S hidden_def.c -o hidden_proto.s
> hidden_def.c: In function ‘main’:
> hidden_def.c:17: warning: asm declaration ignored due to conflict with
> previous rename
> 
> as a result, there aren't #APP(#NO_APP) section in ".s" file
> 
> Questions:
> 
> (1)
> i don't know why i got these assembly warning?
> 
> (2)
> i find in the gas manual:
> 
> .set SYMBOL, EXPRESSION
> 
> if SYMBOL are flagged as external, it remains flagged
> 
> how can "fct" be hidden, because it has been declared as globl.
> 
> (3)
> what is the difference between hidden_def and gcc hidden
> visibility attribute? why libsepol use both of them?
> 
> 
> i know these problems are not selinux-specific, but i have
> googled for a long time, i don't know where i can get guides
> about these kinds of problems. can anyone give me some hints?
> 
> 
> 
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
