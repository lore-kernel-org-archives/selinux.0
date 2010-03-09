Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o291EAaB026891
	for <selinux@tycho.nsa.gov>; Mon, 8 Mar 2010 20:14:10 -0500
Received: from tyo201.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o291EX2m015010
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2010 01:14:34 GMT
Message-ID: <4B959E3F.2030700@ak.jp.nec.com>
Date: Tue, 09 Mar 2010 10:02:55 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Roys <joshua.roys@gtri.gatech.edu>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] mod_selinux: setcon earlier
References: <4B917BCF.7060200@gtri.gatech.edu> <4B949C72.4040104@ak.jp.nec.com> <4B956AA9.4040004@gtri.gatech.edu>
In-Reply-To: <4B956AA9.4040004@gtri.gatech.edu>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(2010/03/09 6:22), Joshua Roys wrote:
> On 03/08/2010 01:42 AM, KaiGai Kohei wrote:
>>> The current code ends up calling setcon after sockets have been opened,
> ...
>>> noticed issues with labeled networking having the setcon() called after
>>> the listening sockets are opened.
>>
>> Hmm. The purpose of selinuxServerDomain allows to drop unnecessary
>> categories on the starting up time, although mod_selinux.pp set it
>> to translate into 's0 - mcs_systemhigh'. So, the listener sockets
>> also should be created in the configured domain.
>> It seems to me what you pointed out is fair enough.
>>
>> However, I cannot agree to change security context of the server
>> which it parses the configuration file, because we can call setcon()
>> in the open_logs hook earlier than listener sockets are created using
>> APR_HOOK_FIRST, not APR_HOOK_MIDDLE.
>>
>> Thanks,
>>
> 
> Hello,
> 
> Do you mean instead of mod_selinux hooking post_config, it would now
> hook open_logs?  If so, I think you would have to use something like:
> (APR_HOOK_REALLY_FIRST-1), because prefork.c hooks open_logs using
> REALLY_FIRST...

Yes, not only prefork, all the supported MPM engine does it in this manner.
As long as we are in apache/httpd-2.2.x series, this hack will be needed.

In the upcoming apache/httpd-2.4.x series, it allows to implement MPM
engine with actually loadable module, so we will be able to avoid this
kind of hacks with multi processing behavior suitable for selinux...

Thanks,
-- 
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
