Date: Wed, 24 Jul 2002 10:22:56 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Richard Mayo <rmayo@caci.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: your mail
In-Reply-To: <OF3775534F.EB0631B6-ON85256C00.004AAC59@hq.caci.com>
Message-ID: <Pine.GSO.4.33.0207241012160.17252-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 24 Jul 2002, Richard Mayo wrote:

> It's obvious to me how to configure my computer to boot only to SELinux,
> but how do I force the computer into Enforcing mode?

You need to specify enforcing=1 on the kernel command line, as noted in
selinux/README.  You can add an append="enforcing=1" line to the entry in
lilo.conf if using LILO or you can add enforcing=1 to the kernel line
in grub.conf if using GRUB.  If you want the kernel to always operate in
enforcing mode (i.e. never be able to toggle into permissive mode), you
can simply rebuild the kernel without the SELinux Development Module
option.  See step 20 of the README.

> Also, when a user logs on the system asks if he or she would like to switch
> user contexts.  Is there an easy way to suppress this?

You could change login.c to use get_default_user_sid rather than
get_user_sid if you want login to always use the default user SID.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
