Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6M2A8Ha017915
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2003 22:10:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6M2A7DW016470
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 02:10:07 GMT
Received: from mailrtr1.mailzone.edeltacom.com (mailrtr1.mailzone.edeltacom.com [216.248.176.137])
        by jazzband.ncsc.mil  with ESMTP id h6M2A7eN016467 for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 02:10:07 GMT
From: "Stephen Reese" <sreese@prcdigital.com>
To: selinux@tycho.nsa.gov
Cc: "'pipes'" <pipes@rapturesecurity.com>
Subject: RE: make quickinstall redhat9 problem
Date: Mon, 21 Jul 2003 22:09:49 -0400
Message-ID: <000101c34ff6$558b0870$6601a8c0@inspiron>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <20030722020704.78395.qmail@a.mx.rapturesecurity.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

installing tk and tcl was the trick thanks for the help now I get to
figure out where I went wrong with the kernel complile =)

VFS: cannot open root device "Label=/"

but thanks for the other heads up everyone and getting me through the
install

-----Original Message-----
From: pipes [mailto:pipes@rapturesecurity.com] 
Sent: Monday, July 21, 2003 10:07 PM
To: Stephen Reese
Cc: selinux@tycho.nsa.gov
Subject: Re: make quickinstall redhat9 problem


I couldn't get this to compile either. 

Using slackware 9 with tcl/* packages installed. 

Haven't taken much time to look into it though. 

P 

Stephen Reese writes: 

> make[1]: Entering directory `/home/installs/selinux/tools'
> make[2]: Entering directory `/home/installs/selinux/tools/setools'
> cd apol; make install
> make[3]: Entering directory 
> `/home/installs/selinux/tools/setools/apol'
> gcc  -Wall -g -I/usr/include -DUSE_SORTING  -c apol_gui.c
> apol_gui.c:14:17: tcl.h: No such file or directory
> apol_gui.c:15:16: tk.h: No such file or directory
> In file included from apol_gui.c:16:
> ../libapol/apol_tcl.h:14:16: tcl.h: No such file or directory
> ../libapol/apol_tcl.h:15:15: tk.h: No such file or directory
> In file included from apol_gui.c:16:
> ../libapol/apol_tcl.h:22: parse error before '*' token
> ../libapol/apol_tcl.h:28: parse error before "clientData"
> ../libapol/apol_tcl.h:29: parse error before "clientData"
> ../libapol/apol_tcl.h:30: parse error before "clientData"
> ../libapol/apol_tcl.h:31: parse error before "clientData"
> ../libapol/apol_tcl.h:32: parse error before "clientData"
> ../libapol/apol_tcl.h:33: parse error before "clientData"
> ../libapol/apol_tcl.h:34: parse error before "clientData"
> ../libapol/apol_tcl.h:35: parse error before "clientData"
> ../libapol/apol_tcl.h:36: parse error before "clientData"
> ../libapol/apol_tcl.h:37: parse error before "clientData"
> ../libapol/apol_tcl.h:38: parse error before "clientData"
> ../libapol/apol_tcl.h:39: parse error before "clientData"
> ../libapol/apol_tcl.h:40: parse error before "clientData"
> ../libapol/apol_tcl.h:41: parse error before "clientData"
> ../libapol/apol_tcl.h:42: parse error before "clientData"
> ../libapol/apol_tcl.h:43: parse error before "clientData"
> apol_gui.c:22: parse error before '*' token
> apol_gui.c: In function `Tcl_AppInit':
> apol_gui.c:26: warning: implicit declaration of function `Tcl_Init'
> apol_gui.c:26: `interp' undeclared (first use in this function)
> apol_gui.c:26: (Each undeclared identifier is reported only once
> apol_gui.c:26: for each function it appears in.)
> apol_gui.c:26: `TCL_ERROR' undeclared (first use in this function)
> apol_gui.c:29: warning: implicit declaration of function `Tk_Init'
> apol_gui.c:40: `TCL_OK' undeclared (first use in this function)
> apol_gui.c:42: warning: implicit declaration of function
> `Tcl_DeleteInterp'
> apol_gui.c:43: warning: implicit declaration of function `Tcl_Exit'
> apol_gui.c:52: warning: implicit declaration of function
`Tcl_EvalFile'
> apol_gui.c: In function `main':
> apol_gui.c:93: `Tcl_Interp' undeclared (first use in this function)
> apol_gui.c:93: `interp' undeclared (first use in this function)
> apol_gui.c:110: warning: implicit declaration of function
> `Tcl_CreateInterp'
> apol_gui.c:111: warning: implicit declaration of function `Tk_MainEx'
> make[3]: *** [apol_gui.o] Error 1
> make[3]: Leaving directory `/home/installs/selinux/tools/setools/apol'
> make[2]: *** [install-apol] Error 2
> make[2]: Leaving directory `/home/installs/selinux/tools/setools'
> make[1]: *** [install] Error 2
> make[1]: Leaving directory `/home/installs/selinux/tools'
> make: *** [quickinstall] Error 2 
> 
> I really am not sure what caused it to error?
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing 
> list. If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without 
> quotes as the message.
 


Pipes
Rapturesecurity.com 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
