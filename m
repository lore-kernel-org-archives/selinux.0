Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6SLpXFc007782
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 17:51:33 -0400
Received: from sccrmhc12.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6SLpTPi014578
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 21:51:29 GMT
From: andy.suchoski@comcast.net
To: <selinux@tycho.nsa.gov>
Subject: mls policy
Date: Fri, 28 Jul 2006 21:51:32 +0000
Message-Id: <072820062151.6083.44CA86E3000E25F0000017C3220702455307059C01080C9A9CD2970B020E@comcast.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello all,
I have been exploring SELinux and I am trying to figure out exactly what the mls 
policy is. I had initially thought that it was the strict policy with hierarchical labels added. I heard elsewhere that it was basically the targeted policy with hierarchical labels. But it seems to be something yet again different. 

I have installed selinux-policy-mls-2.3.2-1.fc5 as my policy. I installed the source RPM selinux-policy-2.3.2-1.fc5.src.rpm and made 2 policies from the source. One with TYPE 'targeted-mls' and the other with TYPE 'strict-mls' in the build.conf file. I felt that one of them should match the 'mls' policy installed directly from the rpm. I thought one way was to determine this was to check for the number of types defined in the policy with seinfo. I got the following results:
mls -               1497 types defined in the policy
targetedmls -  1775 types defined in the policy (from source)
strictmls -        2488 types defined in the policy (from source)

Once I saw that the number of types defined in the policy was closer with the targetedmls policy, I did some other analysis to try and account for the differences between them. I noticed that the mls (binary) policy had 47 types with the string 'secadm' in them, 49 types with the string 'sysadm' in the type and 47 with the string 'auditadm' in the type. All told the targetedmls policy had a total of 3 types containing the string 'sysadm' with no types containing 'secadm' or 'auditadm'. 

I'm puzzled. I thought if I got the source rpm, I should be able to simply create the same policy as the rpm binary distribution by specifying the TYPE in the build.conf file.

- Andy Suchoski

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
