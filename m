Subject: Re: RFC: packet checks always on option
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <4FA95098.1050201@tresys.com>
References: <4FA95098.1050201@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 14 May 2012 13:17:30 -0400
Message-ID: <1337015850.28157.43.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-05-08 at 12:58 -0400, Christopher J. PeBenito wrote:
> I recently became aware that the packet checks are now disabled when there are no SECMARK rules.  I missed the threads discussing this change (I realize its been some time), and the non-enforcement of a check isn't obvious.  Refpolicy's support of unlabeled packet usage also obscured the change.
> 
> My understanding on the rationale for this change was:
> 
> * when flushing iptables, it would lead to all networking being denied, which is opposite of the expected behavior of iptables (i.e. doesn't follow "least surprise")
> * if you have no SECMARK rules, you probably don't care about the checks anyway
> 
> I completely understand these arguments, as they are reasonable functional arguments.  However, this behavior is "allow by default": the opposite of what SELinux stands for.  SELinux doesn't stop file checks if you mount an xattr filesystem that has no labels.  High assurance systems would actually want the old behavior so that networking would be denied if:
> 
> * iptables rules fail to load
> * iptables rules maliciously flushed, e.g. by compromised domain that has net_admin
> * during boot and shutdown you can guarantee no network access
> 
> I think this behavior should be restored, but in a pragmatic way.  I think we should have an option to toggle between packet checks always being on and packet checks on only if there are SECMARK rules.  Then distros can ship with the latter setting.  For the systems that care about it, they can use the former setting.  Then everyone wins.
> 
> Options for implementing this are:
> 
> * a policy capability
> * a policy option similar to unknown permissions checking
> * a SELinux option similar to how compat_net was
> 
> I think the policy capability is not the best choice, since it doesn't exactly follow the concept of a policy capability.  A policy capability would imply that there are no packet checks under any circumstance if the policy capability is off, which wouldn't be the case.  I don't know which of the latter two options are better, other than the latter wouldn't require toolchain changes.

Didn't the old behavior lead to the undesirable result that refpolicy
allows every domain (or at least every domain that does networking) to
send/recv unlabeled packets, such that you cannot effectively employ
SECMARK unless you first modify and rebuild your entire policy to take
away the unlabeled packet access?  Whereas with the new behavior one
could drop those rules and then when someone does enable SECMARK, they
get to fully define the allowable network traffic?

I think another factor in the change had to do with ensuring that new
kernel + old policy continued to work in the face of various changes to
the packet and peer permission checking logic without needing to define
new policy capabilities.

I'm not adverse to making it optional/configurable, but I think a policy
capability is how you should do it.  That is what they are for, and they
are supposed to provide a more explicit mechanism than either the
handle_unknown logic or the old compat_net logic.  Maybe you just need a
clear name for the policy capability, like deny_unlabeled_packets.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
