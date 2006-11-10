Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAAM1owM001916
	for <selinux@tycho.nsa.gov>; Fri, 10 Nov 2006 17:01:52 -0500
Received: from e3.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAAM0BA2011909
	for <selinux@tycho.nsa.gov>; Fri, 10 Nov 2006 22:00:12 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAAM1thk025897
	for <selinux@tycho.nsa.gov>; Fri, 10 Nov 2006 17:01:55 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kAAM1oCJ149382
	for <selinux@tycho.nsa.gov>; Fri, 10 Nov 2006 17:01:55 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kAAM1o1R018169
	for <selinux@tycho.nsa.gov>; Fri, 10 Nov 2006 17:01:50 -0500
Received: from [127.0.0.1] (pendarric.austin.ibm.com [9.41.46.130])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id kAAM1nPe018067
	for <selinux@tycho.nsa.gov>; Fri, 10 Nov 2006 17:01:50 -0500
Message-ID: <4554F6C5.2090308@us.ibm.com>
Date: Fri, 10 Nov 2006 16:01:41 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: broken interface: userdom_common_user_template
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So I am seeing a broken interface problem in policy package version 
selinux-policy-2.4.3-8.

The problem is as follows:

# make
Compiling strict abat module
/usr/bin/checkmodule:  loading policy configuration from tmp/abat.tmp
abat.te:49:ERROR 'unknown class context used in rule' at token ';' on 
line 82511:
#line 49
         allow abat_t self:context contains;
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
make: *** [tmp/abat.mod] Error 1

Line 49: userdom_admin_user_template(abat)

Tracking down the interface that actually has the problem yeilds: 
userdom_common_user_template

I don't know enough about the (apparently depricated or renamed) context 
class to fix this, but I imagine commenting it out isn;t the ideal solution.

Any advice while I await the new package?

Thanks,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
