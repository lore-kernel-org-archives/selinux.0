Message-ID: <4523E1E5.7030907@us.ibm.com>
Date: Wed, 04 Oct 2006 11:31:33 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: newrole - adding capabilities for polyinstantiation
References: <451AEC39.2090409@us.ibm.com>	 <1159450384.11489.5.camel@moss-spartans.epoch.ncsc.mil>	 <451C3A37.8080509@us.ibm.com>  <4522E6DA.1000200@us.ibm.com> <1159973532.19176.84.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1159973532.19176.84.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2006-10-03 at 17:40 -0500, Michael C Thompson wrote:
>> Michael C Thompson wrote:
>>> Stephen Smalley wrote:
>>>> (1) addresses the concern for non-LSPP users, but doesn't fully address
>>>> my concerns about the additional risk to LSPP users.  One obvious issue
>>>> is that drop_capabilities() currently also resets to the caller's uid,
>>>> which Janak's patches do not change.  Which I think means that any
>>>> directories and files created by pam_namespace will initially be
>>>> assigned the caller's uid, and potentially exposed to tampering by
>>>> processes in the caller's uid.
>> As the code stands, even if we delayed the setresuid till right before 
>> the call to exec the shell, the files created by pam_namespace would 
>> still have the caller's uid because the real uid of the process isn't 
>> affected by the suid bit (only the effective uid), and file system 
>> operations are based on the real uid.
> 
> That is not correct.  File system operations in Linux are based on the
> fsuid, which shadows the euid unless explicitly set.

hmm, you are right (and I, alas, was wrong). However, the files will be 
created with the egid being the calling user (as it stands). I imagine 
we'd want to change that.

>> What we would need to do is change the real uid to be, say, root in 
>> order to protect the operations done by pam_namespace. This could be 
>> done right before the calls to pam_namespace, but I'm not sure how much 
>> value is obtained from that approach.
> 
> If you delay the setresuid call until after pam_namespace runs, then
> files created by it should be created in uid 0 by default, and thus not
> immediately accessible to the caller.

I assume then that this is desirable? If so, I'll implement it. I've 
been working on breaking the code up to be a little more modular, so 
that such a change would be clean and easy to implement.

>> There are a few concerns which have arisen due to this polyinstantiation 
>> and suid newrole work. One such concern is that with labeled networking, 
>> using newrole to change your MLS level will not work as intended, since 
>> the relabeled tty will not be able to talk to the socket. This would 
>> limit using newrole to manipulate our MLS to the console, and would 
>> leave newrole capable of only changing the role and type on network 
>> connections.
>>
>> However, even with this MLS level concern aside, is it expected that 
>> using newrole to change your active role will also polyinstantiate 
>> directories? If so, then newrole needs to be a setuid root program.
> 
> For some users, yes.  But this will vary depending on user need.

I'll continue my work on making newrole a more accetpable suid program then.

Thanks,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
