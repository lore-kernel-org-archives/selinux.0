Message-ID: <47E8D604.5010000@manicmethod.com>
Date: Tue, 25 Mar 2008 06:37:56 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Caleb Case <ccase@tresys.com>
Subject: Re: [RFC][PATCH] user_transition support for libsepol/checkpolicy
References: <47E7E7A5.6090603@manicmethod.com> <1206389718.3302.107.camel@moss-spartans.epoch.ncsc.mil> <200803251525.19624.russell@coker.com.au>
In-Reply-To: <200803251525.19624.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Tuesday 25 March 2008 07:15, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>   
>> I'm not sure why anyone needs to add users to policy via semanage users
>> given the base set of generic users and the ability to map Linux users
>> to them via seusers aka semanage login.
>>     
>
> Roles?
>
> Also I like to be able to run "ls -Z" to see the SE Linux identity of the 
> person who created the file.
>   

Roles on objects will be my next patch after this one goes through. It 
will be necessary to implement the rbac separation in the policy that 
we've been talking about.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
