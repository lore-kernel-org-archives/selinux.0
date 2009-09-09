Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n89EqjVP029190
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 10:52:45 -0400
Received: from smtp103.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n89Eq5Vo003602
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 14:52:05 GMT
Message-ID: <4AA7C138.6000205@schaufler-ca.com>
Date: Wed, 09 Sep 2009 07:52:40 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: Oren Laadan <orenl@cs.columbia.edu>,
        Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC PATCH 2/2] cr: debug security_checkpoint_header and	security_may_restart
References: <20090903222824.GB27377@us.ibm.com> <20090903222853.GA27556@us.ibm.com> <4AA0A3AE.9040106@schaufler-ca.com> <20090904134611.GA11508@us.ibm.com> <4AA55183.4020407@schaufler-ca.com> <20090908041221.GB25161@us.ibm.com> <4AA73278.4030301@schaufler-ca.com> <20090909143542.GA23322@us.ibm.com>
In-Reply-To: <20090909143542.GA23322@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Serge E. Hallyn wrote:
> Quoting Casey Schaufler (casey@schaufler-ca.com):
>   
>> Serge E. Hallyn wrote:
>>     
>>> Quoting Casey Schaufler (casey@schaufler-ca.com):
>>> Sorry, the c/r tree is at:
>>>
>>> git://git.ncl.cs.columbia.edu/pub/git/linux-cr.git
>>>   
>>>       
>> The four patches from 08/28 (2-5) and the two from 09/03
>> are not happy applying to this tree. Am I missing a patch?
>>
>>     
>
> There was this patch which was 1/5
> 	https://lists.linux-foundation.org/pipermail/containers/2009-August/020212.html
>
> But there have also been some changes since that posting to the
> git tree.  You could rewind the git tree to the state it was in
> on aug 28, but I'll need to forward-port my patches anyway, so
> let me do that this afternoon and resend the patchset.
>
>   

I figured it was something like that. Thank you.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
