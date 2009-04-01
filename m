Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n31H5Afl015932
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 13:05:10 -0400
Received: from manicmethod.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n31H59U6014907
	for <selinux@tycho.nsa.gov>; Wed, 1 Apr 2009 17:05:09 GMT
Message-ID: <49D39EBF.3050802@manicmethod.com>
Date: Wed, 01 Apr 2009 13:05:03 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Andy Warner <warner@rubix.com>
CC: KaiGai Kohei <kaigai@kaigai.gr.jp>, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        cpebenito@tresys.com, selinux@tycho.nsa.gov, refpolicy@oss.tresys.com
Subject: Re: [RFC] Security policy reworks for SE-PostgreSQL
References: <49D1DA85.1030902@ak.jp.nec.com> <49D1EAE7.8050100@rubix.com> <49D21FD5.7020600@kaigai.gr.jp> <49D23288.2030807@rubix.com> <49D27E6C.5000106@kaigai.gr.jp> <49D27F77.4040906@rubix.com> <49D2812B.50504@manicmethod.com> <49D28656.1090504@rubix.com>
In-Reply-To: <49D28656.1090504@rubix.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Andy Warner wrote:
> 
> 
> Joshua Brindle wrote:
>>
>> SELinux doesn't have a built in mechanism, 
> 
> By built in mechanism I meant exactly what you describe below. Maybe it 
> wasn't the best choice of words. The SELinux policy (the MLS policy) 
> provides a mechanism for the policy writer to assign the ability to 
> violate B&L information flow. Thus, it would be redundant for the 
> db_database object to have  a permissions for something like "read-up", 
> etc. If I were to compare that with the Trusted Solaris type policy 
> mechanism, there was no such mechanism. Our DB would have to perform the 
> dominance check for an operation, then decide ourselves if the user had 
> sufficient authorizations to violate B&L. With the current SELinux MLS 
> policy, all of that is done with one access check. The mac override type 
> privilege you would see in TSol 8, etc would allow a process to perform 
> some operation while ignoring the mac policy. This does not help our DB 
> make a policy decision on a subject as they access a DBMS  object.

This is absolutely correct, we want to use policy to specify mls exceptions
rather than having the policy spread through several object managers, this makes
it possible to do an analysis on the policy and actually see the information
flow through all object managers.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
