Message-ID: <4E3C1030.40406@manicmethod.com>
Date: Fri, 05 Aug 2011 11:45:52 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, qingtao.cao@windriver.com,
        Eric Paris <eparis@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: checkpolicy is broken (which is not)
References: <4E3AEA75.3090602@redhat.com> <4E3B3D39.4020700@windriver.com>  <4E3B441A.1090900@windriver.com> <4E3B5593.7000502@redhat.com>  <4E3B6F5B.40904@windriver.com> <1312548982.19283.14.camel@moss-pluto> <4E3BE94F.9010104@redhat.com>
In-Reply-To: <4E3BE94F.9010104@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
<snip>>>
>
> Well I will say that I thought the old construct did not make sense,
> since we have to declare most objects in the lanquage except for roles.
>

If SDS hadn't smacked it down I would have deprecated implicit role declaration 
in the original module compiler so it shouldn't be a surprise that I'm fine with 
this change. Refpolicy has always declared roles explicitly (a capability that 
didn't even exist before the module compiler) and if it didn't it was a 
refpolicy bug.

> This will help to find problems in the policy also like people doing
>
> role httpd_t types httpd_t;
>
> Which I have seen in the past.
>
> I just got the new toolchain to work with Fedora policy.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
