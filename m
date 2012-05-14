Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4ECqSEZ002811
	for <selinux@tycho.nsa.gov>; Mon, 14 May 2012 08:52:29 -0400
Message-ID: <4FB1000D.4040403@tresys.com>
Date: Mon, 14 May 2012 08:52:29 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: RFC: packet checks always on option
References: <4FA95098.1050201@tresys.com> <1540303.QUZeuyPSRI@sifl>
In-Reply-To: <1540303.QUZeuyPSRI@sifl>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/10/12 16:02, Paul Moore wrote:
> On Tuesday, May 08, 2012 12:58:00 PM Christopher J. PeBenito wrote:
>> I recently became aware that the packet checks are now disabled when there
>> are no SECMARK rules ...
>>
>> ... this behavior is "allow by default": the opposite of what SELinux stands
>> for.  SELinux doesn't stop file checks if you mount an xattr filesystem that
>> has no labels.  High assurance systems would actually want the old behavior
>> so that networking would be denied if:
>>
>> * iptables rules fail to load
>> * iptables rules maliciously flushed, e.g. by compromised domain that has
>> net_admin
> 
> Ever since secmark was introduced it has required users/admins to ensure, via 
> a secondary mechanism not contained within the SELinux policy, that the 
> netfilter/iptables configuration was both correctly matched to the policy and 
> that is was not tampered with, either maliciously or accidentally.  Failure to 
> do this verification and correctly configure netfilter/iptables could result 
> in the mis-labeling of network traffic via the secmark label.
>
> This applies to both the current behavior and the "old" behavior.
> 
> Simply going back to always applying the per-packet secmark access controls 
> does nothing to solve the problem of ensuring correctness.  This is my main 
> problem with your argument.

I don't understand what correctness you're referring to.  Labeling correctness?  You always need that; thats the crux of having a proper running system.  But we don't stop enforcing policy if its not correct.  It sounds like you'd argue that if a filesystem with no labels is loaded that it should not have any enforcement.  That relies on the VFS as a secondary mechanism.
 
>> * during boot and shutdown you can guarantee no network access
> 
> You can do this through a variety of other mechanisms that have nothing to do 
> with secmark labels.

No, you can't.  None of them are enforceable as soon as the policy is loaded.  Otherwise you have gaps in enforcement, which is not desired for some systems.  The whole point of MAC systems is to reduce the trust in userspace code, and the above suggestion puts more trust in userspace code.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
