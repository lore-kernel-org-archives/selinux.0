Message-ID: <451D771F.5080905@us.ibm.com>
Date: Fri, 29 Sep 2006 14:42:23 -0500
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
>> On Wed, 2006-09-27 at 16:25 -0500, Michael C Thompson wrote:
<snip>
>>> After reading the thread, it seems like Janak's patches were getting 
>>> close, but quite a few ideas were thrown out there, namely:
>>>
>>> 1) Have newrole be non-suid by default, and require the LSPP 
>>> configuration package to enable its suid status (which would then 
>>> enable the capabilities)
>>>
>>> 2) Have newrole be suid all of the time.
>>>
>>> 3) Have newrole determine if namespace is used for the configuration, 
>>> which would then determine if the caps need to be loaded or not.
>>>
>>> Do you know if there was any decision on the path to take that I am 
>>> unable to find on the mailing list?
>>
>> I think (2) is unacceptable (the real issue is not whether it is suid
>> per se, but whether it retains powerful capabilities like CAP_SYS_ADMIN
>> - it is already suid for the earlier audit support, but drops everything
>> but CAP_AUDIT_WRITE and reverts to the caller's uid upon startup).
> 
> With Janak's patch, there is no differentiation between the capabilities 
> needed to polyinstantiate and the capabilities to audit. Is there a 
> desire to audit outside of an LSPP environment? If so, then I will 
> address this issue in the patch (I see AUDIT being a requirement of 
> LSPP, so there is a clear dependence chain).
> 
> There is also the issue which Russel Coker brought up which is that 
> pam_namespace is valuable to people outside an LSPP environment. Should 
> this future work take that into account?

I think it would be acceptable to have AUDIT_PRIV and NAMESPACE_PRIV, 
based on my suggestion below.

>> I don't know how to do (3) cleanly, as it seems to violate PAM
>> encapsulation.
>>
>> (1) addresses the concern for non-LSPP users, but doesn't fully address
>> my concerns about the additional risk to LSPP users.  One obvious issue
>> is that drop_capabilities() currently also resets to the caller's uid,
>> which Janak's patches do not change.  Which I think means that any
>> directories and files created by pam_namespace will initially be
>> assigned the caller's uid, and potentially exposed to tampering by
>> processes in the caller's uid.  SELinux policy might prevent such
>> tampering, but it bears investigating.  Likewise, this means that the
>> newrole process itself runs in the caller's uid and might be exposed to
>> interference by the caller in some forms, although I would expect that
>> SELinux would block that as long as newrole is running in a different
>> domain.
> 
> I will take some time and look at this further.

After some discussion with some people in my department, I would like to 
suggest the following proposal for newrole, which I believe would 
address the need for polyinstantiation in the LSPP environment.

I propose we fork newrole into a two separate processes in the LSPP 
environment. One process would retain only the CAP_AUDIT_WRITE 
capability, and be responsible for handling the bulk of newrole 
operation. The other process, which would only be forked when compiled 
for the LSPP environment, would retain all capabilities required for the 
polyinstantiation operation.

This second, more privilaged, process's scope would be limited to 
handling the pam_session requests. This would allow this separate 
process to remain suid for its lifetime (hopefully alleviating Stephen 
Smalley's concerns) and split it from the more vulnerable code.

Interactions between the less-secure and more-secure processes would be 
handled through a restricted IPC mechanism.

What do people think of this idea?

Thanks,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
