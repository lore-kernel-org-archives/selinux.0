Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBDKhBIi007255
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 15:43:11 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBDKfTUx021282
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2004 20:41:29 GMT
Message-ID: <41BDFF4C.1080109@tresys.com>
Date: Mon, 13 Dec 2004 15:45:00 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, selinux-dev@tresys.com
Subject: ANN: SELinux Policy Server Project
References: <20041210162047.HHLP7908.mm-ismta4.bizmailsrvcs.net@FLM800>
In-Reply-To: <20041210162047.HHLP7908.mm-ismta4.bizmailsrvcs.net@FLM800>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We at Tresys have started a project to design and implement an SELinux
policy server. This project, which builds on the recently completed
policy module project, will create a policy server that implements fine
grained access controls on the SELinux policy itself, as well as
implementing an infrastructure for userspace object managers and
eventually infrastructure for network policy management. The initial
release and design document is on the Tresys webpage at
http://www.tresys.com/selinux/.

The current release implements a hierarchal structure in policies
allowing, for example, types to have subtypes with less than or equal
permissions but not more. This was mentioned before on the SELinux list,
an archive of the thread is located at
http://marc.theaimsgroup.com/?l=selinux&m=109908469725763&w=2.

An application in policycoreutils/policy-verifier will verify that the
policy is internally consistant with the hierarchy. It is a standalone
application meant to be run on a kernel policy. Instructions for running
this verification step when a module is installed are included.

The compiler included in this release understands and stores hierarchal
symbols. This compiler is experimental, however. In order to gain
acceptance of this policy language change we have made a patch against
the existing policy compiler (included in this email). The patch allows
the '.' notation to be used for roles, types, object classes,
attributes, and aliases, which can then be verified with the
standalone verifier.

This project will be long term and experimental; therefore, we would
like to solicit community involvement, especially in the form of
feedback on the requirements, architecture, and design. A sourceforge
project for this has been created at
http://sourceforge.net/projects/sepolicy-server/ . We'll be keeping the
CVS repository there up to date with development and making regular
releases to the files area.


Joshua Brindle
Tresys Technology


diff -u -r1.6 policy_scan.l
--- checkpolicy/policy_scan.l   9 Aug 2004 18:12:29 -0000       1.6
+++ checkpolicy/policy_scan.l   10 Dec 2004 20:35:43 -0000
@@ -161,7 +161,7 @@
t2 |
T2                             { return(T2); }
"/"({letter}|{digit}|_|"."|"-"|"/")*   { return(PATH); }
-{letter}({letter}|{digit}|_)*  { return(IDENTIFIER); }
+{letter}({letter}|{digit}|_|".")*("*")?        { return(IDENTIFIER); }
{letter}({letter}|{digit}|_|"."|"-")*  { return(USER_IDENTIFIER); }
{digit}{digit}*                 { return(NUMBER); }
{hexval}{0,4}":"{hexval}{0,4}":"({hexval}|":"|".")*    {
return(IPV6_ADDR); }






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
