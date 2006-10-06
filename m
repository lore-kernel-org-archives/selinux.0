Message-ID: <45268BD9.9050809@redhat.com>
Date: Fri, 06 Oct 2006 13:01:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Michael C Thompson <thompsmc@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, jdesai@us.ibm.com
Subject: Re: [RFC PATCH] newrole suid breakdown
References: <452432FA.1060009@us.ibm.com> <45250F35.6030204@redhat.com> <200610060915.15441.russell@coker.com.au>
In-Reply-To: <200610060915.15441.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Thursday 05 October 2006 23:57, Daniel J Walsh <dwalsh@redhat.com> wrote:
>   
>> Does the code continue to work correctly if I compile in AUDIT_LOG_PRIV
>> and NAMESPACE_PRIV but run it without the setuid bit and as a normal
>> user.  IE, We want the option to only set this setuid when in an MLS
>> environment.  This is not required for targeted or strict policy machines.
>>     
>
> Who does "we" mean in this context?
>
> I would like to have newrole work with namespaces in a strict policy 
> environment!
>
>   
I am not denying you that right.  I am asking for the tool to continue 
working with or without setuid.
IE Don't force a setuid app on the OS, if I don't do pam_namespace or 
care about role auditing.

We means Red Hat/Fedora.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
