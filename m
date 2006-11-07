Message-ID: <4550E7E4.4000505@us.ibm.com>
Date: Tue, 07 Nov 2006 14:09:08 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 4/8] make newrole suid (take 3)
References: <454A8F35.2020006@us.ibm.com> <454A95BC.7000807@us.ibm.com> <20061107052338.GB11273@sergelap.austin.ibm.com>
In-Reply-To: <20061107052338.GB11273@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Serge E. Hallyn wrote:
> Quoting Michael C Thompson (thompsmc@us.ibm.com):
>> Michael C Thompson wrote:
>>> The 8 patches are as follows:
>>> 1) Modifications to Makefile to support future patch needs
>>>   Add newrole-lspp.pamd
>>> 2) New extract_pw_data function and use in main()
>>> 3) Add signal handler function
>>> 4) Update drop_capabilities() and use in main()
>> This is the 4th of 8 patches.
>> This patch applies against policycoreutils-1.30.30-1.
>>
>> This patch adds expands the drop_capabilities functionality
>> to support various compile-time options (with audit, with
>> namespace, or neither).
>>
>> Changes:
>>  * Splits drop_capabilities into three versions (compile time option):
>>    - 'No-cap' version, returns true
>>    - 'audit-only' version, retains only CAP_AUDIT_WRITE
>>       Enable with AUDIT_LOG_PRIV=y
>>    - 'namespace+' version, retains CAP_AUDIT_WRITE, CAP_SYS_ADMIN and
>>       more to allow namespace actions
>>       Enable with NAMESPACE_PRIV = y
>>  * main() calls drop_capabilities unconditionally
> 
> It looks like your two later versions of drop_capabilities() don't call
> setresuid?  Your comment doesn't explain why, and a very quick scan of
> your later patches didn't show you adding them.

OK, thanks for pointing this out, its a clear deficiency in the code's 
documentation. Here is my explanation of the code:

There are 4 versions of compiling this code:
1. No auditing or namespace support
2. Auditing but not namespace
3. Namespace but not auditing
4. Both

For the 3rd version of drop_capabilities, that is the return 0; inline, 
it is used when compiled without auditing or namespace capabilities. 
Therefore, there is no need to make newrole suid in this case, and 
drop_capabilities is a 'no-op'.

In the case where you compile with only auditing support the original 
version of drop_capabilities (which does do setresuid) is sufficient 
because as long as we maintain the CAP_AUDIT_WRITE, we can get rid of 
the other capabilities and switch to the user's uid.

However, in order to support namespaces, we need to retain more 
capabilities and Stephen Smalley suggested that the euid of the process 
not be changed to the caller's uid until after the pam_open_session() 
call, so that any actions taken by the pam_namespace module are done as 
euid 0. The reasoning was that the calling user would not be able to 
take advantage of the directories that get created by the pam_namespace 
module before it could set their correct permissions and security 
contexts. The transition_to_caller_uid() function is what handles this 
setresuid() change when compiled to support namespaces, and is called 
after the pam_open_session() call returns.

So, in summary, the 1st version of drop_capabilities() does setresuid 
immediately because we don't need to retain euid 0, the 2nd version of 
drop_capabilities() defers the setresuid to transition_to_call_uid() 
function in order to have a more secure pam_open_session() call, and the 
3rd version is for when newrole is not suid, and therefore doesn't need 
to make that call.

Let me know if any of the above explanations are not sufficient because 
I plan on adding this to the code.

Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
