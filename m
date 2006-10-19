Message-ID: <45378681.3000106@redhat.com>
Date: Thu, 19 Oct 2006 10:06:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: casey@schaufler-ca.com, russell@coker.com.au, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com
Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>	 <45377BF0.6010403@redhat.com> <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-10-19 at 09:21 -0400, Daniel J Walsh wrote:
>   
>> So one proposed solution to this is to take away the newrole -l 
>> functionality all together and to add Sensitivity selection to the local 
>> login. 
>>
>> We can implement pam_selinux to ask for the sensitivity level
>>
>>
>> username: dwalsh
>> passwd: ********
>> Sensitivity: SystemLow
>>
>> If we then remove -l from newrole we are done?
>>     
>
> pam_selinux used to have support to let the user pick from the list of
> reachable contexts for the user.  So you could just restore that
> support.
>   
I don't think so.  This allowed you to select your TE role, not your 
Sensitivity.  The problem is selecting your sensivity.  Since there is 
an large number of sensitivities a user can log in as he will need to 
key it in.
> That doesn't address sshd though.  Or gdm.  sshd shouldn't be too
> difficult.  There were some externally developed gdm patches for selinux
> that enabled context selection long ago, but nothing recent
> (pre-Fedora).
>   
I though the sshd would happen automatically when you login via a secure 
channel.  IE If I connect at TopSecret, I get TopSecret.

I think gdm will require other features such that I launch terminals at 
different sensitivity levels???

I think we should separate the TE Context selection from the Sensitivity 
Selection, in order to satisfy the MLS problems.
> You don't need to remove -l from newrole; you can just constrain its use
> via DAC and via SELinux policy, as Klaus has previously suggested.
>
>   
So it will not work on ptys?  Or are you thinking a boolean? I think it 
will be strange for a user to have the app work differently depending on 
how they logged in, but I guess this is another short coming of MLS.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
