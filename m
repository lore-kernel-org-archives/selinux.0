Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1ENesQk005964
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2007 18:40:54 -0500
Received: from e32.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1ENg7EY011771
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2007 23:42:07 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l1ENfXDt007087
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2007 18:41:33 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l1ENg7F9515912
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2007 16:42:07 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l1ENg631018037
	for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2007 16:42:07 -0700
Subject: ssh/xinetd/getpeercon???
From: Joy Latten <latten@austin.ibm.com>
To: vyekkirala@TrustedCS.com, redhat-lspp@redhat.com
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 14 Feb 2007 17:26:41 -0600
Message-Id: <1171495601.2603.488.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have been playing with the ssh-mls which gets called through xinetd
when labeled networking is in use and am confused about what I am
seeing. :-)

My assumption is that when using this feature, the resulting ssh
connection will have single mls level, which is the effective level of
the issuer. 

For example, if I am
uid=500(ealuser) gid=500(ealuser) groups=10(wheel),500(ealuser)
context=staff_u:staff_r:staff_t:s3-s9

When I issue ssh -p 222 -l <user> <host>, I expect to see "s3" as my new
mls level in the new ssh connection when I do an "id".

With CIPSO, this happens.
With labeled ipsec, I get "s3-s9".

Debugging xinetd, I noticed that when using CIPSO, getpeercon() returns 
"system_u:object_r:unlabeled_t:s3".

When using labeled ipsec, getpeercon() returns
"root:sysadm_r:sysadm_ssh_t:s3-s9".

I always wondered if getpeercon() would someday lift its head and bite,
I just wish it had not been on Valentine's Day. :-)
I am concerned about the mls label being returned.

So, my question is, how is this suppose to work?
Does CIPSO, when given an mls range, like s3-s9, only pass
the effective level through in ip options? If so, is this 
what labeled ipsec should be doing? Should we be setting only the 
effective level in the SA? If so, that could potentially create 
even more SAs. Or should xinetd, when given a range, should only
set the effective level for the new process? I kinda like this 
solution best, that is, xinetd setting single effective level. But
I don't know if that is correct resolution? 

Regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
