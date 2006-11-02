Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA2Gp62F000805
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 11:51:06 -0500
Received: from e35.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA2GoDKL027219
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 16:50:16 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA2Gp2rP017051
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 11:51:02 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kA2Gp273337350
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 09:51:02 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kA2Go1pk018833
	for <selinux@tycho.nsa.gov>; Thu, 2 Nov 2006 09:50:01 -0700
Message-ID: <454A21B3.7040005@us.ibm.com>
Date: Thu, 02 Nov 2006 10:49:55 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: MLS + MCS?
References: <454A134D.5060902@us.ibm.com> <1162485313.18181.9.camel@sgc>
In-Reply-To: <1162485313.18181.9.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Thu, 2006-11-02 at 09:48 -0600, Michael C Thompson wrote:
>> While writing some policy, I came across a situation that was causing 
>> the policy I was writing to be constructed in an invalid fashion. What 
>> was happening was this:
>>
>> Using an old Makefile, my $(TYPE) was being generated as 
>> 'strict-mls-mcs', which was causing the support template 'gen_context' 
>> to get completely confused.
>>
>> The macro is defined thusly:
> [cut]
>> I'm wondering, how does this make sense? I'm unclear as to how having 
>> both mls_sensitivity and [mcs_catergories] defined in this way has meaning.
>>
>> Because of having both '-mls' and '-mcs' in my $(TYPE), the invalid 
>> policy I was compiling ended up looking like this:
>> user:role:type:$2:s0:$3
>>
>> It would seem to me that MLS and MCS are mutually exclusive, at least in 
>> this macro.
> 
> Yes, they are mutually exclusive.  Sounds like the Makefile that redhat
> has is making a mistake on setting TYPE; it has to figure out more than
> the upstream refpolicy Makefiles need to because of the
> redhat /usr/share/selinux/*/devel setup.

I have since switched to the last Makefile redhat provides and that 
resolves the problem I was having.

is there a better way to express the gen_context macro, or is this 
another case of m4 limitations? (I am not familiar with m4 at all btw)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
