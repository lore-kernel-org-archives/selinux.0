Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9LFnTxH014308
	for <selinux@tycho.nsa.gov>; Mon, 21 Oct 2013 11:49:31 -0400
References: <52617C02.4060500@tycho.nsa.gov> <1382199839.82880.YahooMailNeo@web87903.mail.ir2.yahoo.com> <52652DE1.4020504@tresys.com>
Message-ID: <1382370565.32009.YahooMailNeo@web87905.mail.ir2.yahoo.com>
Date: Mon, 21 Oct 2013 16:49:25 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
Subject: Request for a new CIL statement
To: Steve Lawrence <slawrence@tresys.com>,
        James Carter <jwcart2@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <52652DE1.4020504@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As CIL now seems to be under serious development, could I put forward a 
request for a new statement that would build variable length configuration
file entries. This would allow policy writers to build all required
configuration files to support the 'policy'. It would also allow the
parameters used to be validated by the build process. 

Currently CIL generates the file_contexts entries using the 'filecon'
statement, this method is okay for this application, however there are
files that require entries with a variable number of parameters (examples:
setrans.conf and seapp_contexts).

What I've been trying to achieve (and failing) is to generate entries like
these example seapp_contexts entries:
   isSystemServer=true domain=system_server.process
   user=_app seinfo=netclient domain=netclient_app.process type=netclient_app.log_file level=s0:c1020.c1023

A possible statement format could be:
(configfileentry filename "test string with %s for %s param" (type param1) (type param2) ...)       

Examples:
(configfileentry seapp_contexts "isSystemServer=true domain=%s" (type system_server.process))

(configfileentry seapp_contexts "user=_app seinfo=netclient domain=%s type=%s level=%s"
    (type netclient_app.process)
    (type netclient_app.log_file)
    (level s0:c1020.c1023))

The final process would be to assemble all entries for each configuration
filename and create the file (I'm not sure about sorting order but could be
left to the process that uses the config file).

I've been reworking the call/macro code to achieve this but I seem to be
allergic to compiler code for some reason.

If it does seem a worthwhile idea I'm happy to continue but will probably
require a few pointers.

Richard


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
