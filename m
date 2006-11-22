Message-ID: <4564A20F.5070007@redhat.com>
Date: Wed, 22 Nov 2006 14:16:31 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: More  small fixes to policycoreutils
References: <6FE441CD9F0C0C479F2D88F959B015885C79BC@exchange.columbia.tresys.com>	 <455CE2F3.3070200@mentalrootkit.com> <455DA4E8.5050600@redhat.com>	 <4561E1A3.8070306@mentalrootkit.com> <4561E7B2.9030205@redhat.com>	 <4561F3EA.8020603@tresys.com>  <456224F2.6010707@redhat.com> <1164117199.13758.88.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1164117199.13758.88.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2006-11-20 at 16:58 -0500, Daniel J Walsh wrote:
>   
>>> What is pam_tally and what does the call to pam_acct_mgmt do, and how 
>>> does it affect run_init?
>>>
>>>       
>> I believe pam_tally increments a counter for failed logins in 
>> pam_authenticate and decrements it when it gets to pam_account 
>> management.  If it never gets there, the counter continues to increment.
>>     
>
> I thought I saw that pam_tally was being moved from the generic system
> auth config to specific program configs, and was thus no longer an issue
> for run_init.  No?
>
>   
That might be, but after talking to Nalin, he heavily recommends that we 
use pam_acct_mgmt with a pam_permit.  He says that is the recommended 
way, and would admins to add customizations on when and how you can run 
the command.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
