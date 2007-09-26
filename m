Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8QAepc6020466
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2007 06:40:51 -0400
Received: from rv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8QAeoRe004318
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2007 10:40:50 GMT
Received: by rv-out-0910.google.com with SMTP id k15so1902678rvb
        for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2007 03:40:49 -0700 (PDT)
Message-ID: <46FA361C.8080008@gmail.com>
Date: Wed, 26 Sep 2007 18:36:12 +0800
From: Ken YANG <spng.yang@gmail.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: puzzles about hidden_def and hidden_proto
Content-Type: text/plain; charset=GB18030
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


hi all,

i have three puzzles about the macro "hidden_def"
and "hidden_proto" in "libsepol/src/dso.h".

i copy the definitions of these two macros into
a separate header file to test these two macros,
and assembly them:

$ cat hidden_def.h

int extern_i=12345;
#define hidden __attribute__ ((visibility("hidden")))
#define hidden_proto(fct) __hidden_proto (fct, fct##_internal)
#define __hidden_proto(fct, internal)   \
        extern __typeof(fct) internal;  \
        extern __typeof(fct) fct __asm (#internal) hidden;
#define hidden_def(fct) \
        asm (".globl " #fct "\n.set " #fct ", " #fct "_internal");

$ cat hidden_def.c

#include "hidden_def.h"
int main()
{
        hidden_proto(extern_i);
}

$ gcc -S hidden_def.c -o hidden_proto.s
hidden_def.c: In function ¡®main¡¯:
hidden_def.c:17: warning: asm declaration ignored due to conflict with
previous rename

as a result, there aren't #APP(#NO_APP) section in ".s" file

Questions:

(1)
i don't know why i got these assembly warning?

(2)
i find in the gas manual:

.set SYMBOL, EXPRESSION

if SYMBOL are flagged as external, it remains flagged

how can "fct" be hidden, because it has been declared as globl.

(3)
what is the difference between hidden_def and gcc hidden
visibility attribute? why libsepol use both of them?


i know these problems are not selinux-specific, but i have
googled for a long time, i don't know where i can get guides
about these kinds of problems. can anyone give me some hints?






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
