Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAUIf1OH028750
	for <selinux@tycho.nsa.gov>; Mon, 30 Nov 2009 13:41:01 -0500
Received: from mailhub128.itcs.purdue.edu (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nAUIhDkc028277
	for <selinux@tycho.nsa.gov>; Mon, 30 Nov 2009 18:43:13 GMT
Message-ID: <4B1411B5.5050406@cs.purdue.edu>
Date: Mon, 30 Nov 2009 13:40:53 -0500
From: Jacques Thomas <jthomas@cs.purdue.edu>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: SE Linux <selinux@tycho.nsa.gov>, method@manicmethod.com
Subject: Re: Type boundaries: questions on the semantics / is the enforcement
 correct ?
References: <4AF71B05.8030707@cs.purdue.edu> <4B035FA4.6080605@ak.jp.nec.com> <4B056D3D.2050303@cs.purdue.edu>
In-Reply-To: <4B056D3D.2050303@cs.purdue.edu>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jacques Thomas wrote:
> KaiGai Kohei wrote:
>   
>
<snip>
</snip>
>> I also think we have one other a rough option.
>> It simply applies type boundaries on only sources to restrict its privileges,
>> and it does not apply any restrictions on target types.
>>   
>>     
>
> Unless there is a clear use for bounds on targets, I would favor this
> option. (The "rough" one :-) )
> I see mostly room for confusion with the bounds on target types, because
> of the contravariance issue.
>   

I can write and submit a patch along these lines. The patch is
straightforward: I just have to remove the "dead" code.

However, could someone please indicate me how I am supposed to test the
patch ? In other words, is there a standardized testing procedure that I
am unaware of ?

Thank you,
Jacques

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
