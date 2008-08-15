Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7F8n7JH020361
	for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2008 04:49:08 -0400
Received: from tyo202.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7F8n5pN013078
	for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2008 08:49:06 GMT
Message-ID: <48A542E4.60109@ak.jp.nec.com>
Date: Fri, 15 Aug 2008 17:48:36 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: cpebenito@tresys.com
CC: Chris PeBenito <pebenito@gentoo.org>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov, DGoeddel@TrustedCS.com,
        vyekkirala@TrustedCS.com
Subject: Re: [PATCH] Communication between domains under labeled networks
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>	 <1203428116.13618.77.camel@gorn> <47BB7B6A.1090207@ak.jp.nec.com>	 <200802192237.22546.paul.moore@hp.com>  <47BBB69C.2050007@ak.jp.nec.com>	 <1203955972.32061.55.camel@gorn> <47C3738A.3010007@ak.jp.nec.com>	 <4860BA1B.5030302@ak.jp.nec.com>  <4861DED0.9050407@ak.jp.nec.com>	 <1216388484.21191.139.camel@gorn>  <4885BB42.4060603@ak.jp.nec.com> <1216959017.5022.42.camel@defiant.pebenito.net>
In-Reply-To: <1216959017.5022.42.camel@defiant.pebenito.net>
Content-Type: multipart/mixed;
 boundary="------------000703070307050303000303"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000703070307050303000303
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Chris PeBenito wrote:
> On Tue, 2008-07-22 at 19:49 +0900, KaiGai Kohei wrote:
>> Christopher J. PeBenito wrote:
>>> On Wed, 2008-06-25 at 14:59 +0900, KaiGai Kohei wrote:
>>>> Hi,
>>>>
>>>> The attached patch allows user domains to communicate with daemon
>>>> domain, and some other domains (Apache and CGI script) to communicate
>>>> with RDBMS (PostgreSQL and MySQL) using xxxx_tcp_connect() interface.
>>>>
>>>> This approach enables to cover most of relationship needed.
>>>> All we have to do is to describe the rest of relationship like
>>>> ones between CGI script and RDBMS, daemons and name server,
>>>> anything and samba server, ....
>>>>
>>>> At least, we cannot get labeled networks available unless adding
>>>> policies to communicate between proper domains.
>>>> I think it is necessary to make a decision to describe the policies.
> 
>> The attached patch is a revised version.
>> Please review it again.
>>
>> And I also noticed that ipsec_match_default_spd() should be invoked with
>> server's domain as postgresql_t doing.
>> (e.g: communication between staff_t and sshd_t)
>> I think it also should be allowed for whole of daemon attribute.
>> What is your opinion? The version.3 patch also contains this fix.
> 
> I merged everything except for the default spd part.  I don't know if
> its been suggested before, but I'm considering putting that match rule
> into corenet_*_recvfrom_unlabeled().

I'm sorry for neglecting this topic.

Can I understand your suggestion was like the patch I attached with
this message? If so, I don't oppose to anything, but we need to put
a short description why ipsec_match_default_spd() is deployed on
corenet_*_recvfrom_unlabeled() to avoid future confusion.
                   ^^^^^^^^^
Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------000703070307050303000303
Content-Type: text/x-patch;
 name="refpolicy-widespread-ipsec_match_default_spd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-widespread-ipsec_match_default_spd.patch"

Index: refpolicy/policy/modules/kernel/corenetwork.if.in
===================================================================
--- refpolicy/policy/modules/kernel/corenetwork.if.in	(revision 2781)
+++ refpolicy/policy/modules/kernel/corenetwork.if.in	(working copy)
@@ -1759,6 +1759,10 @@
 	# but for right now we need to keep this in place so as not to break
 	# older systems
 	kernel_sendrecv_unlabeled_association($1)
+
+	optional_policy(`
+		ipsec_match_default_spd($1)
+	')
 ')
 
 ########################################
@@ -1870,6 +1874,10 @@
 	# but for right now we need to keep this in place so as not to break
 	# older systems
 	kernel_sendrecv_unlabeled_association($1)
+
+	optional_policy(`
+		ipsec_match_default_spd($1)
+	')
 ')
 
 ########################################
@@ -1981,6 +1989,10 @@
 	# but for right now we need to keep this in place so as not to break
 	# older systems
 	kernel_sendrecv_unlabeled_association($1)
+
+	optional_policy(`
+		ipsec_match_default_spd($1)
+	')
 ')
 
 ########################################

--------------000703070307050303000303--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
