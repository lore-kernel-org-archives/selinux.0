Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n87IVjMB007734
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 14:31:45 -0400
Received: from smtp106.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n87IX45W001482
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 18:33:04 GMT
Message-ID: <4AA55183.4020407@schaufler-ca.com>
Date: Mon, 07 Sep 2009 11:31:31 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: Oren Laadan <orenl@cs.columbia.edu>,
        Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC PATCH 2/2] cr: debug security_checkpoint_header and	security_may_restart
References: <20090903222824.GB27377@us.ibm.com> <20090903222853.GA27556@us.ibm.com> <4AA0A3AE.9040106@schaufler-ca.com> <20090904134611.GA11508@us.ibm.com>
In-Reply-To: <20090904134611.GA11508@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Serge E. Hallyn wrote:
> Quoting Casey Schaufler (casey@schaufler-ca.com):
>   
>> Serge E. Hallyn wrote:
>>     
>>> This patch, for debugging only, introduces a silly admin-controlled
>>> 'policy version' for smack.  By default the version is 1.  An
>>> admin (with CAP_MAC_ADMIN) can change it by echoing a new value
>>> into /smack/version.
>>>   
>>>       
>> The scheme you have suggested is just one step off of completely
>> acceptable for real. More detail below, but if you make the "version"
>> a string instead of a number I'm happy with it. In particular, a
>> string that would itself be a valid Smack label makes everything
>> really simple.
>>     
>
> Presumably at many sites the version will be a unique string not
> used as a label anywhere else.  That's ok?
>
>   
>> It would take me a few days, but if you're not in a real hurry or
>> you're lazier than I am (yeah, right) I could provide a patch that
>> does it. Or, if I haven't been completely incomprehensible, you
>> could do a revision.
>>     
>
> Heh, I'm in no hurry.  I'll mark this to do midway next week, if
> you haven't gotten around to it first.  Thanks!
>   


I hate to be a bother, but what tree are you basing these patches on?
Suspect that I missed a round of patches along the way, and can't apply
the ones I do have.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
