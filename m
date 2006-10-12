Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9CFH80r030553
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 11:17:08 -0400
Received: from e31.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9CFGRPm015884
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 15:16:28 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9CFH3h9006688
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 11:17:03 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k9CFH2Z9340242
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 09:17:02 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k9CFH1CL017112
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 09:17:02 -0600
Message-ID: <452E5C66.1060201@us.ibm.com>
Date: Thu, 12 Oct 2006 10:16:54 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Klaus Weidner <klaus@atsec.com>
CC: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com
Subject: Re: MLS enforcing PTYs, sshd, and newrole
References: <20061012073338.GG28525@w-m-p.com> <200610122025.15043.russell@coker.com.au> <20061012144819.GF28520@w-m-p.com>
In-Reply-To: <20061012144819.GF28520@w-m-p.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Klaus Weidner wrote:
> Of course, people deploying a system that's based on the LSPP
> configuration can choose to deviate from the evaluated configuration
> based on their own risk assessment. This could include restoring general
> access to "newrole" if they don't consider the PTY exploit to be a
> concern.

And if you want polyinstation, then an suid newrole needs to be available :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
