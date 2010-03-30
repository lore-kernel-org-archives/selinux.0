From: Paul Moore <paul.moore@hp.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: svirt on MLS has strange AVC.
Date: Tue, 30 Mar 2010 14:07:12 -0400
Cc: Eric Paris <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        "Daniel P. Berrange" <berrange@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>
References: <4BA7E4BF.1040002@redhat.com> <201003291600.06024.paul.moore@hp.com> <4BB20E8D.7030207@redhat.com>
In-Reply-To: <4BB20E8D.7030207@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201003301407.12372.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 30 March 2010 10:45:33 am Daniel J Walsh wrote:
> Paul you are suggesting that I write a MLS rule that says
> 
> svirt_t:ANYLEVEL can talk to svirt_t:ANYLEVEL over unix domain sockets.
> 
> Which would allow
> 
> svirt_t:s0 to talk to svirt_t:s1  Which seems very broken to me.

Well, based on the domains that were reported earlier in the thread ...

># ps -eZ | grep virt
>system_u:system_r:virtd_t:s0-s15:c0.c1023 27344 ? 05:34:47 libvirtd
>system_u:system_r:svirt_t:s0:c1 28549 ?        00:00:01 qemu-kvm

... I think you just need to write policy that allows "virtd_t:ANYLEVEL" and 
"svirtd_t:ANYLEVEL" to communicate; you shouldn't need to allow 
"svirt_t:ANYLEVEL" to communicate with "svirt_t" since only qemu-kvm is 
running as "svirt_t" and you are trying to get qemu-kvm and libvirtd to talk.

It is also worth pointing out that you don't need to use MLS constraints that 
completely disregard the MLS label, you can do some MLS label bounding, e.g. 
mlsnetwriteranged and mlsnetwritetoclr.  Also, feel free to suggest patches to 
the unix_socket MLS constraints, I'm not convinced they need to use the 
existing network socket constraints.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
