Message-ID: <45523185.40502@us.ibm.com>
Date: Wed, 08 Nov 2006 13:35:33 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 4/8] make newrole suid (take 3)
References: <454A8F35.2020006@us.ibm.com> <454A95BC.7000807@us.ibm.com> <20061107052338.GB11273@sergelap.austin.ibm.com> <4550E7E4.4000505@us.ibm.com> <20061108173224.GB15592@sergelap.austin.ibm.com>
In-Reply-To: <20061108173224.GB15592@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Serge E. Hallyn wrote:
> Quoting Michael C Thompson (thompsmc@us.ibm.com):
>> For the 3rd version of drop_capabilities, that is the return 0; inline, 
>> it is used when compiled without auditing or namespace capabilities. 
>> Therefore, there is no need to make newrole suid in this case, and 
>> drop_capabilities is a 'no-op'.
> 
> Ok - so will the Makefile in that case automatically not install it
> suid?

Correct. It will only be made suid if either AUDIT_LOG_PRIV or 
NAMESPACE_PRIV are flagged yes.

>> In the case where you compile with only auditing support the original 
>> version of drop_capabilities (which does do setresuid) is sufficient 
>> because as long as we maintain the CAP_AUDIT_WRITE, we can get rid of 
>> the other capabilities and switch to the user's uid.
>>
>> However, in order to support namespaces, we need to retain more 
>> capabilities and Stephen Smalley suggested that the euid of the process 
>> not be changed to the caller's uid until after the pam_open_session() 
>> call, so that any actions taken by the pam_namespace module are done as 
>> euid 0. The reasoning was that the calling user would not be able to 
>> take advantage of the directories that get created by the pam_namespace 
>> module before it could set their correct permissions and security 
>> contexts. The transition_to_caller_uid() function is what handles this 
>> setresuid() change when compiled to support namespaces, and is called 
>> after the pam_open_session() call returns.
> 
> Ok - sorry for not following the thread on that.

No worries.

> So the short answer for this case is "it will get set in
> pam_open_session".  I trust we know exactly what else will get called
> before pam_open_session happens, and trust it to be safe as root?

Not sure what you mean by "it will get set in pam_open_session". The uid 
gets set after the pam_open_session call.

This is a short list of what we do prior to the uid change:
- locale actions
- calls into libselinux, libaudit and libc
- calls to pam

In short, for the case where we want namespace support, we execute as 
root for nearly the entire lifetime of the application, and the parent 
process retains euid 0 as well while the shell has been exec'd and is 
waiting for the child to die.

We don't actually *need* to do this, but my reason was that if we retain 
the ability to setuid and retain the capabilities on the permitted (but 
not effective) list, then if an exploit would be discovered for the 
program, then all the attacker would need to do is re-raise those 
capabilities and game over.

I've only briefly consider the effects of maintaining euid=0 during the 
life-time of the application, but it seems to me the only impact it will 
have is during the pam_open_session call.

Does that make sense?

Thanks,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
