Message-ID: <4C210F17.6030301@gmail.com>
Date: Tue, 22 Jun 2010 12:29:27 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: selinux_required option given and selinux is disabled
References: <AANLkTikAhExdRILzInlYswXnAFbJsSGec43O7p2VcaEe@mail.gmail.com> <1277233608.28715.102.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1277233608.28715.102.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/22/2010 12:06 PM, Stephen Smalley wrote:
> On Tue, 2010-06-22 at 08:53 -0700, Justin Mattock wrote:
>> playing around with pam_namespace I seem to at a crux with trying to
>> figure out how to use require_selinux in pam.d/login with pam_namespace
>>
>> heres what I see:
>>
>> pam_selinux(login:session): Open Session
>> pam_unix(login:session): session opened for user name by LOGIN(uid=0)
>> pam_selinux(login:session): Open Session
>> pam_selinux(login:session): Username= name SELinux User = name Level= s0
>> pam_selinux(login:session): Security Context name:staff_r:staff_t:s0 Assigned
>> pam_selinux(login:session): set name security context to name:staff_r:staff_t:s0
>> pam_selinux(login:session): Key Creation Context
>> name:staff_r:staff_t:s0 Assigned
>> pam_selinux(login:session): set name key creation context to
>> name:staff_r:staff_t:s0
>> pam_namespace(login:session): selinux_required option given and
>> selinux is disabled
>> Cannot make/remove an entry for the specified session
>>
>> did I miss something with this?
>
> Was pam_namespace built with --enable-selinux?
>


yeah it's always been enabled, as well as audit.. one thing that I 
remember is I did receive an error when building(as well as today) to 
avoid this error I used the --enable-db=no so maybe this has something 
todo with this.

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
