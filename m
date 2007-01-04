Message-ID: <459D7DA6.8010201@redhat.com>
Date: Thu, 04 Jan 2007 17:20:22 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: casey@schaufler-ca.com
CC: Stephen Smalley <sds@tycho.nsa.gov>, James Antill <jantill@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>, redhat-lspp <redhat-lspp@redhat.com>
Subject: Re: [redhat-lspp] Re: [PATCH 2/3] Re: MLS enforcing PTYs, sshd, and
 newrole
References: <926802.72514.qm@web36614.mail.mud.yahoo.com>
In-Reply-To: <926802.72514.qm@web36614.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler wrote:
> --- Daniel J Walsh <dwalsh@redhat.com> wrote:
>
>   
>> We still have a problem on MLS machines, in that
>> newrole can be used to 
>> pass data via pseudo terminals.
>>
>> script
>> newrole -l SystemHigh
>> cat TopSecret.doc
>> ^d
>> ^d
>> cat typescript
>>
>> I propose we add this patch to newrole to check if
>> we are on a pseudo 
>> terminal and then fail if user is using -l.
>>
>> Basically this patch checks the major number of the
>> stdin, stdout, 
>> stderr for a number in the pseudo number range,  If
>> yes the pseudo 
>> terminal, if not continue.  Not pretty but it solves
>> the problem.  I 
>> could not figure out another way to check if you are
>> on a pseudo terminal. 
>>
>> Comments?
>>     
>
> Are you 100% certain that this is only a pty
> issue? Any chance you'll have a similar problem
> with other devices, pipes, fifos, UDS or the like?
> My pair of Lincolns says otherwise, but they've
> been wrong before.
>
>
>   
That would probably be a fools bet.  There are other checks in newrole 
to make sure it is talking to a terminal, though.  I worry that I have 
hit all the pseudo terminals though.  I am hoping others smarter then me 
in the kernel would know.
> Casey Schaufler
> casey@schaufler-ca.com
>   



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
