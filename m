Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6SB0Q5R026706
 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2014 07:00:27 -0400
Received: by mail-qa0-f54.google.com with SMTP id k15so7625947qaq.41
 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2014 04:00:30 -0700 (PDT)
Message-ID: <53D62D4B.3080402@quarksecurity.com>
Date: Mon, 28 Jul 2014 07:00:27 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
Subject: Re: do user space object managers really provide mandatory access
 control
References: <1406536400.32528.7.camel@x220.localdomain>
 <001701cfaa44$3b3857c0$b1a90740$@rubix.com>
 <1406544263.850.11.camel@x220.localdomain>
In-Reply-To: <1406544263.850.11.camel@x220.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: 'selinux' <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Dominick Grift wrote:
> On Mon, 2014-07-28 at 11:13 +0200, Andy Warner wrote:
>> MAC is usually defined as not being discretionary (it is mandatory). That
>> is, the enforcement of the policy is not at the discretion of a user or
>> owner. In my experience it is not defined as "being enforced by the kernel."
>> Generally MAC also implies (and sometimes demands) implementation principles
>> like encapsulation and non-bypassibility, which a kernel based
>> implementation might satisfy, but it is not a requirement of MAC to be
>> implemented in the kernel.
>>
>
> Thank you. I should rephrase "if one defines" to "when one defines"
>

One should not define MAC that way. MAC has nothing to do with where it 
is implemented. The original FLASK implementation [1] was actually 
implemented on a microkernel so most of the access control was in userspace.

[1] http://www.cs.utah.edu/flux/fluke/html/index.html

> I wonder whether the SELinux object manager related code implements any
> meaningful implementation principles like encapsulation,
> non-bypassibility, or others.
>

Insomuch as the policies prevent other, non-enforcing, applications from 
accessing the data, then yes. If the SELinux kernel objects that 
encapsulate SEPostgreSQL objects are only accessible by SEPostgreSQL 
then SEPostgreSQL can completely arbitrate access to its objects (rows, 
tables, etc) that the kernel does not know about.

>> I work in MAC based DBMS's which from your perspective could just be
>> considered an application layer, but it is implementing real MAC.  One
>> reason it cannot be totally implemented in the kernel is that the MAC is
>> arbitrating access to non-OS objects, such as database rows, tables, etc.
>> The DBMS can cooperate with the kernel and use the kernel for MAC based
>> decisions (if the MAC policy objectives are the same) but it cannot be
>> totally implemented in the kernel. At least, not without lots of tricky
>> theoretical work, which was my research topic years ago in grad school.
>> Enforcement of the policy is a key difficult issue.
>
> Depending on the answer to my question above that might beg the question
> then: why not implement a security server, and cache in the user space
> object manager itself. Although i think i know the answer to that
> question in advance: to facilitate centralized government of the policy
> rather than having that scattered all over.
>

You can. There was even a userspace security server project a few years 
back.

> All-in-all it sound like a lot of compromise.
>

Try getting Linus to let in patches that let the kernel understand 
database rows and tables for the sake of security and you'll quickly 
find that it is not a compromise, but the only practical answer.

> What, other than providing a central place of governance, would be the
> benefits of SELinux user space object managers, over any other "MAC"
> solutions implemented solely in the user space c.q. application layer?
>

You got it. The flask architecture is decide in one place, enforce 
everywhere else. Just because an object owner is in userspace does not 
make it fundamentally different from an object owner in the kernel. Who 
owns the objects should be enforcing access control. If all your 
filesystems were actually userspace processes, would it not make sense 
for them to still enforce access to files?

One practical benefit is the ability to get an active policy from the 
security server and run analysis on it. Granted you need to understand 
how object managers interact - this goes for kernel too. If you can 
access block devices directly then filesystem object managers can be 
bypassed. The policy needs to take that into account, and an analyst 
needs to understand it.
