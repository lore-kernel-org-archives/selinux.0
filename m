Subject: Re: lilo and initrd
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <200308161715.35442.carstengrohmann@gmx.de>
References: <200308161715.35442.carstengrohmann@gmx.de>
Content-Type: text/plain
Message-Id: <1061212570.25048.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 18 Aug 2003 09:16:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-08-16 at 11:15, Carsten Grohmann wrote:
> today I read in the SELinux README file, I should not use the 
> initrd= option with the selinux entry. Knows anybody why? 

That is an old note that is no longer accurate, even for the old
2.4-based SELinux.  Prior to 2.4.19, if you booted a SELinux kernel with
an initrd, the kernel would try to perform the initial policy load from
the initrd itself, which would fail unless you had installed a policy
onto the initrd.  The old 2.4-based SELinux should work fine now with an
initrd; the SELinux kernel will not try to load the policy until the
real root filesystem has been mounted.

In the 2.6-based SELinux and the new 2.4-based SELinux (back port of the
2.6-based SELinux), the initial policy load has been pushed into
userspace, and an initrd is specifically used for this purpose.  We have
patched our mkinitrd script to copy load_policy and the binary policy
file onto the initrd and to include commands in the /linuxrc script to
load the policy from the initrd before the real root filesystem has been
mounted.  See the README in selinux-doc.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
