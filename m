Message-ID: <4522E6DA.1000200@us.ibm.com>
Date: Tue, 03 Oct 2006 17:40:26 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: newrole - adding capabilities for polyinstantiation
References: <451AEC39.2090409@us.ibm.com> <1159450384.11489.5.camel@moss-spartans.epoch.ncsc.mil> <451C3A37.8080509@us.ibm.com>
In-Reply-To: <451C3A37.8080509@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael C Thompson wrote:
> Stephen Smalley wrote:
>> (1) addresses the concern for non-LSPP users, but doesn't fully address
>> my concerns about the additional risk to LSPP users.  One obvious issue
>> is that drop_capabilities() currently also resets to the caller's uid,
>> which Janak's patches do not change.  Which I think means that any
>> directories and files created by pam_namespace will initially be
>> assigned the caller's uid, and potentially exposed to tampering by
>> processes in the caller's uid.

As the code stands, even if we delayed the setresuid till right before 
the call to exec the shell, the files created by pam_namespace would 
still have the caller's uid because the real uid of the process isn't 
affected by the suid bit (only the effective uid), and file system 
operations are based on the real uid.

What we would need to do is change the real uid to be, say, root in 
order to protect the operations done by pam_namespace. This could be 
done right before the calls to pam_namespace, but I'm not sure how much 
value is obtained from that approach.

<snip>
>> We also need to consider whether more of the guidelines in e.g. the
>> Secure Programming HOWTO or the kinds of safeguards implemented
>> in /bin/su should be applied to newrole when it is suid.  Historically,
>> newrole wasn't viewed as an especially privileged program, since it
>> wasn't suid originally and since the user-role authorizations were
>> actually enforced by the kernel, not by newrole.  Thus it wasn't written
>> to be as paranoid about the caller as /bin/su is.
> 
> Will look at this as well.

There are a few concerns which have arisen due to this polyinstantiation 
and suid newrole work. One such concern is that with labeled networking, 
using newrole to change your MLS level will not work as intended, since 
the relabeled tty will not be able to talk to the socket. This would 
limit using newrole to manipulate our MLS to the console, and would 
leave newrole capable of only changing the role and type on network 
connections.

However, even with this MLS level concern aside, is it expected that 
using newrole to change your active role will also polyinstantiate 
directories? If so, then newrole needs to be a setuid root program.

If making newrole to be a setuid root program is considered 
unacceptable, an alternative needs to be provided for users to specify 
the desired role (and type) to assume upon login.

Thanks,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
