Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA19297
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2001 00:50:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id EAA00888
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2001 04:50:31 GMT
Received: from glaurung.green-gryphon.com ([63.161.160.94])
	by jazzswing.ncsc.mil  with ESMTP id EAA00884
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2001 04:50:30 GMT
To: selinux@tycho.nsa.gov
Subject: Rule Set Based Access Control (RSBAC)
From: Manoj Srivastava <manoj.srivastava@stdc.com>
Date: 01 Apr 2001 23:44:18 -0500
Message-ID: <873dbroqql.fsf@glaurung.green-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        I am beginning to evaluate SELinux for my company, and I ran
 across RSBAC (http://www.rsbac.de/index.htm) while still in the
 background research phase. Has anyone done a comparison of RSBAC? It
 sounds like it is in the same ballpark as SELinux, and seems to have
 some additional goodies like ACL's. 


	manoj

ps. From the web page above:
     ---------------------------------------------------------------------- 
What is RSBAC?                       

   RSBAC is a flexible, powerful and fast open source access control
   framework for current Linux kernels, which has been in stable
   production use for over a year (since version 1.0.9a).

   The standard package includes a range of access control models like
   MAC, RC, ACL (see below). Furthermore, the runtime registration
   facility (REG) makes it easy to implement your own access control
   model as a kernel module and get it registered at runtime.

   The RSBAC framework is based on the Generalized Framework for
   Access Control (GFAC) by Abrams and LaPadula. All security relevant
   system calls are extended by security enforcement code. This code
   calls the central decision component, which in turn calls all
   active decision modules and generates a combined decision. This
   decision is then enforced by the system call extensions.

   Decisions are based on the type of access (request type), the
   access target and on the values of attributes attached to the
   subject calling and to the target to be accessed. Additional
   independent attributes can be used by individual modules, e.g. the
   privacy module (PM). All attributes are stored in fully protected
   directories, one on each mounted device.  Thus changes to
   attributes require special system calls provided.
             
   As all types of access decisions are based on general decision
   requests, many different security policies can be implemented as a
   decision module.  Apart from the builtin models shown below, the
   optional Module Registration (REG) allows for registration of
   additional, individual decision modules at runtime.
----------------------------------------------------------------------

      
-- 
 In Corning, Iowa, it's a misdemeanor for a man to ask his wife to
 ride in any motor vehicle.
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024R/C7261095 print CB D9 F4 12 68 07 E4 05  CC 2D 27 12 1D F5 E8 6E
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
