Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6M0IqHa017640
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2003 20:18:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6M0HlFB029264
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 00:17:47 GMT
Received: from mailrtr1.mailzone.edeltacom.com (mailrtr1.mailzone.edeltacom.com [216.248.176.137])
	by jazzswing.ncsc.mil  with ESMTP id h6M0HlGD029261
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 00:17:47 GMT
From: "Stephen Reese" <sreese@prcdigital.com>
To: selinux@tycho.nsa.gov
Subject: make quickinstall redhat9 problem
Date: Mon, 21 Jul 2003 20:18:25 -0400
Message-ID: <000001c34fe6$c761e5a0$6601a8c0@inspiron>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

make[1]: Entering directory `/home/installs/selinux/tools'
make[2]: Entering directory `/home/installs/selinux/tools/setools'
cd apol; make install
make[3]: Entering directory `/home/installs/selinux/tools/setools/apol'
gcc  -Wall -g -I/usr/include -DUSE_SORTING  -c apol_gui.c
apol_gui.c:14:17: tcl.h: No such file or directory
apol_gui.c:15:16: tk.h: No such file or directory
In file included from apol_gui.c:16:
../libapol/apol_tcl.h:14:16: tcl.h: No such file or directory
../libapol/apol_tcl.h:15:15: tk.h: No such file or directory
In file included from apol_gui.c:16:
../libapol/apol_tcl.h:22: parse error before '*' token
../libapol/apol_tcl.h:28: parse error before "clientData"
../libapol/apol_tcl.h:29: parse error before "clientData"
../libapol/apol_tcl.h:30: parse error before "clientData"
../libapol/apol_tcl.h:31: parse error before "clientData"
../libapol/apol_tcl.h:32: parse error before "clientData"
../libapol/apol_tcl.h:33: parse error before "clientData"
../libapol/apol_tcl.h:34: parse error before "clientData"
../libapol/apol_tcl.h:35: parse error before "clientData"
../libapol/apol_tcl.h:36: parse error before "clientData"
../libapol/apol_tcl.h:37: parse error before "clientData"
../libapol/apol_tcl.h:38: parse error before "clientData"
../libapol/apol_tcl.h:39: parse error before "clientData"
../libapol/apol_tcl.h:40: parse error before "clientData"
../libapol/apol_tcl.h:41: parse error before "clientData"
../libapol/apol_tcl.h:42: parse error before "clientData"
../libapol/apol_tcl.h:43: parse error before "clientData"
apol_gui.c:22: parse error before '*' token
apol_gui.c: In function `Tcl_AppInit':
apol_gui.c:26: warning: implicit declaration of function `Tcl_Init'
apol_gui.c:26: `interp' undeclared (first use in this function)
apol_gui.c:26: (Each undeclared identifier is reported only once
apol_gui.c:26: for each function it appears in.)
apol_gui.c:26: `TCL_ERROR' undeclared (first use in this function)
apol_gui.c:29: warning: implicit declaration of function `Tk_Init'
apol_gui.c:40: `TCL_OK' undeclared (first use in this function)
apol_gui.c:42: warning: implicit declaration of function
`Tcl_DeleteInterp'
apol_gui.c:43: warning: implicit declaration of function `Tcl_Exit'
apol_gui.c:52: warning: implicit declaration of function `Tcl_EvalFile'
apol_gui.c: In function `main':
apol_gui.c:93: `Tcl_Interp' undeclared (first use in this function)
apol_gui.c:93: `interp' undeclared (first use in this function)
apol_gui.c:110: warning: implicit declaration of function
`Tcl_CreateInterp'
apol_gui.c:111: warning: implicit declaration of function `Tk_MainEx'
make[3]: *** [apol_gui.o] Error 1
make[3]: Leaving directory `/home/installs/selinux/tools/setools/apol'
make[2]: *** [install-apol] Error 2
make[2]: Leaving directory `/home/installs/selinux/tools/setools'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/home/installs/selinux/tools'
make: *** [quickinstall] Error 2

I really am not sure what caused it to error?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
