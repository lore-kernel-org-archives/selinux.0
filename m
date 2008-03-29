Message-ID: <47ED987C.8000008@manicmethod.com>
Date: Fri, 28 Mar 2008 21:16:44 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Stephen Smalley <sds@tycho.nsa.gov>, jwcart2@epoch.ncsc.mil,
        SE-Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: Debian SE Linux status
References: <200803281106.47699.russell@coker.com.au> <1206711402.29088.21.camel@moss-lions.epoch.ncsc.mil> <1206712290.3302.455.camel@moss-spartans.epoch.ncsc.mil> <200803291200.00643.russell@coker.com.au>
In-Reply-To: <200803291200.00643.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Saturday 29 March 2008 00:51, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>   
>>> Isn't that an argument for keeping non-MLS support? ;)
>>>       
>> I don't believe that it actually does significantly increase policy
>> build time (or if it does, that would be a bug).  Possibly Russell just
>> means that building both MLS and non-MLS takes longer, or that the mls
>> modules.conf includes more modules, or something along those lines?
>>     
>
> Yes.  Currently I have it building three policy packages, strict, targeted, 
> and mls.  This takes 50% longer than just strict and targeted.  But if we go 
> to a single policy for strict/targeted and a policy for mls then we would 
> have the same build times as before

Strict and targeted don't mean anything anymore. If you want targeted 
behavior you insert the unconfined module into the standard policy.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
