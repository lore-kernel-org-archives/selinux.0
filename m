Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4HGhsRb025411
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 12:43:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4HGhpAR022626
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 16:43:51 GMT
Received: from carbon.btinternet.com (carbon.btinternet.com [194.73.73.92])
        by jazzband.ncsc.mil  with ESMTP id i4HGhoHn022618 for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 16:43:51 GMT
Received: from [81.130.181.235] (helo=lkcl.net)
	by carbon.btinternet.com with esmtp (Exim 3.22 #25)
	id 1BPlDH-0004bC-00
	for selinux@tycho.nsa.gov; Mon, 17 May 2004 17:43:39 +0100
Received: from highfield ([192.168.0.223]:33642 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.24 #1)
	id 1BPlG1-0006ni-Gj
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 16:46:29 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BP8Xe-0007cq-Qx
	for selinux@tycho.nsa.gov; Sat, 15 May 2004 23:26:06 +0000
Date: Sat, 15 May 2004 23:26:06 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: selinux@tycho.nsa.gov
Subject: suggestion to help transition to selinux: dynamic loading of libselinux
Message-ID: <20040515232606.GA9378@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

dear nsa et al,

love selinux principle.  it's _got_ to be made easier.

idea: make all the modifications to e.g. coreutils, login etc.
compile with the header files but not necessarily _need_
libselinux at run-time.

way to do that is the same way that libdvdcss is loaded by
libdvdread: dynamically [there are plenty of other programs
that use the same technique].

the suggestion is based on the premise that if you have a
non-selinux kernel, and no libselinux installed, the programs
(pam, coreutils, login etc.) will attempt to dynamically load
libselinux (with dlopen), find it missing, _won't care_
and will adapt and proceed knowing that there's no security
enhancements - i.e. as if they had never been patched to
deal with selinux in the first place;

whilst if they _do_ detect that libselinux is available, an
init function is called which returns a pointer to a vector
table of all the functions needed, which are then used;

and i presume that if such programs are compromised, and someone
attempts to _stop_ libselinux from being loaded, well then
those programs will not be capable of making domain transitions
etc. and they will be useless [am i right?]


the technique of having one function available from a dynamic
library, which returns a table of all functions available in
the library, and which is accessed via dlsym is very common,
i am sure you have heard of it:

/* change all functions listed in this vector table from
   extern to static: they are made accessible _only_ through
   the vector table, instead
 */

static libselinux_vector_table fns =
{
    is_selinux_enabled,
	freecon,
	freeconary,
	getcon,
	getpidcon,
	getprevcon,
	getexeccon,
	....
	....
	fsetfilecon
}


extern libselinux_vector_table *libselinux_init_fn(void);


then you do this, in every program that requires access to
libselinux functions:

void *handle = dlopen("/usr/lib/libselinux.so", blah);
void *(void) fn = dlsym(handle, "libselinux_init_fn");

libselinux_vector_table *sel = (libselinux_vector_table*)(*fn)();

then, for example, in the patch to coreutils,
http://selinux.lemuria.org/newselinux/coreutils/coreutils.diff

in coreutils-5.0.91/src/copy.c line 1444 approx, instead of
++#ifdef WITH_SELINUX
++	if (x->preserve_security_context) 
++	  setfscreatecon(NULL);
++#endif

you have:

if (sel != NULL && x->preserve_security_context)
	sel->setfscreatecon(NULL);


yes, correct: no #ifdef WITH_SELINUX :)


i.e. you must compile always with the header files, but you must NOT
require the library libselinux to be present in order for the program
to actually work.

this is a standard programming technique, i am sure that someone could
provide better examples of how it is deployed.

the advantage of deploying it is that at present there is
completely justifiable resistance upstream in accepting
patches to the core functionality of linux useability that
makes it impossible to use the core utilities for a non-selinux
environment (!), and this suggestion makes the reason for that
resistance go away.


i hope that you will consider adapting libselinux for use in this
manner, because the sooner the dual-maintenance of the "alternate"
versions of the core utils disappears, the better.

sincerely,

l.

p.s. please ask me for clarifications if needed or even for
patches rather than go "uhn?  weirdo, weird language, can't
even touch a shift key, don't talk to him".  i _want_ selinux
to be adapted mainstream by debian, quickly, so talk to me.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
