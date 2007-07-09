To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: getfilecon return code
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 09 Jul 2007 14:07:30 -0400
In-Reply-To: <1183999553.12430.94.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <ogtmyy5lacd.fsf@oolong.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I hadn't carefully read the manual page for getfilecon until now, but
I notice it states that a positive number is returned indicating the
number of bytes malloc'd for the context, and -1 is returned
indicating failure and that errno is set.  I would have guessed from
the description that zero is never an allowed return value.  In fact,
I wrote code that freecon'd a context whenever the return value was
not -1.

In the example below, when checking out a file in /proc/sys, zero is
returned and the result is a NULL context, something that need not be
free'd.  To me, failure to allocate a context feels like a failure
condition.

Perhaps the best strategy is to assume success when the context produced
in non-null, and not worry about the return code.

  security_context_t con = NULL;
  int rc = getfilecon(MP, &con);
  if (!con) /* Handle failure here */        
  else /* do something and then freecon(con) */

Is the following expression always true?

  (con != NULL) == (rc > 0)

John

[ramsdell@goo selinux]$ make
cc     mygetfilecon.c  /home/ramsdell/src/libselinux-2.0.8/src/libselinux.a -o mygetfilecon
[ramsdell@goo selinux]$ ./mygetfilecon
getfilecon("/proc/sys/kernel/pid_max", &con) = 0
con = NULL
[ramsdell@goo selinux]$ cat mygetfilecon.c
#include <stdio.h>
#include <selinux/selinux.h>

#define MP "/proc/sys/kernel/pid_max"

int
main(int argc, char **argv)
{
  security_context_t con;
  int rc = getfilecon(MP, &con);
  printf("getfilecon(\"%s\", &con) = %d\n", MP, rc);
  if (rc < 0)
    perror("getfilecon");
  else if (con)
    printf("con = \"%s\"\n", con);
  else
    printf("con = NULL\n", con);
  return 0;
}
[ramsdell@goo selinux]$ 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
