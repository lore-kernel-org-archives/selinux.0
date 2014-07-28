Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6SB7WX5027219
 for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2014 07:07:32 -0400
From: "Andy Warner" <warner@rubix.com>
To: "'Dominick Grift'" <dominick.grift@gmail.com>
References: <1406536400.32528.7.camel@x220.localdomain>	
 <001701cfaa44$3b3857c0$b1a90740$@rubix.com>
 <1406544263.850.11.camel@x220.localdomain>
In-Reply-To: <1406544263.850.11.camel@x220.localdomain>
Subject: RE: do user space object managers really provide mandatory access
 control
Date: Mon, 28 Jul 2014 13:07:31 +0200
Message-ID: <001f01cfaa54$22054820$660fd860$@rubix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Cc: 'selinux' <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



-----Original Message-----
From: Dominick Grift [mailto:dominick.grift@gmail.com] 
Sent: Monday, July 28, 2014 12:44 PM
To: Andy Warner
Cc: 'selinux'
Subject: Re: do user space object managers really provide mandatory access control

On Mon, 2014-07-28 at 11:13 +0200, Andy Warner wrote:
>> MAC is usually defined as not being discretionary (it is mandatory). 
>> That is, the enforcement of the policy is not at the discretion of a 
> >user or owner. In my experience it is not defined as "being enforced by the kernel."
>> Generally MAC also implies (and sometimes demands) implementation 
>> principles like encapsulation and non-bypassibility, which a kernel 
>> based implementation might satisfy, but it is not a requirement of MAC 
>> to be implemented in the kernel.
> 

>Thank you. I should rephrase "if one defines" to "when one defines"

I would refute a definition of MAC that restricted it to the OS kernel. But if you did, then obviously you would definition exclude the possibility that MAC could exist outside the kernel, which makes your original questions seem moot. If you presume any MAC implementation is compromised, in user space or kernel, then obviously you have a problem. I do not think it is valid to assume that because something is in "user space" that it is easily compromised, though I understand that OS-centric viewpoint.

>I wonder whether the SELinux object manager related code implements any meaningful implementation principles like encapsulation, non-bypassibility, or >others.

I would assume they had to make some assurance arguments when they were officially evaluated (RHEL has done this, no?). Some non-bypassibility argument and strategy must be made for any MAC policy enforcement.

>> I work in MAC based DBMS's which from your perspective could just be 
>> considered an application layer, but it is implementing real MAC.  One 
>> reason it cannot be totally implemented in the kernel is that the MAC 
>> is arbitrating access to non-OS objects, such as database rows, tables, etc.
>> The DBMS can cooperate with the kernel and use the kernel for MAC 
>> based decisions (if the MAC policy objectives are the same) but it 
>> cannot be totally implemented in the kernel. At least, not without 
>> lots of tricky theoretical work, which was my research topic years ago in grad school.
>> Enforcement of the policy is a key difficult issue. 

>Depending on the answer to my question above that might beg the question
>then: why not implement a security server, and cache in the user space object manager itself. Although i think i know the answer to that question in advance: >to facilitate centralized government of the policy rather than having that scattered all over.

For us, we do not want to reinvent the wheel and duplicate functionality of the MAC policy of the OS matches our MAC objectives for the database. If we can rely on a preexisting implementation in our OS, then why not? Also, if the underlying MAC implementation has been officially evaluated (e.g., EAL-4), then that makes our security arguments and evaluations easier.

We also implement a MAC policy within the DBMS that is based upon the XACML policy language. In this case we do it all within the DBMS kernel. Our TE relies upon the OS for security decisions, while our MLS is implemented within the DBMS kernel but mirrors and cooperates with the SELinux MLS mechanism. So, we have varying degrees of what we use the OS for and what we do ourselves.

>All-in-all it sound like a lot of compromise.

Sure. I would say the same about using a complicated TE MAC policy as opposed to a more simple MLS policy. It's a compromise between flexibility and insurability. 

>What, other than providing a central place of governance, would be the benefits of SELinux user space object managers, over any other "MAC"
>solutions implemented solely in the user space c.q. application layer?

For us, a single point of evaluation is a big deal. OS's tend to be evaluated relatively quickly and commonly. 
