Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9ELLsWt021765
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 17:21:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9ELLrmR001558
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 21:21:53 GMT
Received: from zaphod.crypt.gen.nz (203-79-124-63.adsl.paradise.net.nz [203.79.124.63])
        by jazzband.ncsc.mil  with ESMTP id h9ELLqjp001555 for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 21:21:52 GMT
Received: from www.crypt.gen.nz (zaphod.crypt.gen.nz [192.168.1.5])
	by zaphod.crypt.gen.nz (Postfix) with SMTP id 6A784FE9A
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 10:21:48 +1300 (NZDT)
Message-ID: <2544.202.27.185.71.1066166508.squirrel@www.crypt.gen.nz>
In-Reply-To: <1066145242.5054.213.camel@moss-spartans.epoch.ncsc.mil>
References: <3F8BE8E5.9050006@ipen.br>
    <1066145242.5054.213.camel@moss-spartans.epoch.ncsc.mil>
Date: Wed, 15 Oct 2003 10:21:48 +1300 (NZDT)
Subject: Re: avc_toggle and avc_enforcing
From: "Kerry Thompson" <kerry@crypt.gen.nz>
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Speaking of which, I'd like to assemble a quick list of userland ( or more
accurately, adminland ) changes between the current release and the
previous non-/selinux release to update the documentation I've got, like
the U-FAQ. The ones I've noticed so far :

- avc_enforcing, avc_toggle replaced by /selinux/enforcing
- id command requires -c to display context
- ps command uses -Z to display context
- initrd now mandatory
- selinux kernel boot option
- multiple changes to installation procedure
- SRPMs added to installation image
- new tools added ( Tresys tools, star )
- binary RPMs available ( thanks Daniel )

I've looked into the ChangeLog files, but there really isn't much info
there, so I'd like to hear of any other changes that have been made which
need to be documented.

I'm still working on getting my test system up to the new 2.4 and 2.6,
unfortunately I rendered it unbootable last night so it will take a little
longer than expected ( note to self : make sure kernel can build an initrd
before removing /boot/initrd* ).

Kerry


Stephen Smalley said:
> On Tue, 2003-10-14 at 08:15, Carlos Anísio Monteiro wrote:
>> Please, where I find the commands: avc_toggle and avc_enforcing. What
>> are it the packages where it are?
>
> They no longer exist as programs.  With the new SELinux API, you can
> simply 'cat /selinux/enforce' to see the current enforcing value,
> 'echo 1 > /selinux/enforce' to switch into enforcing mode, and
> 'echo  > /selinux/enforce' to switch into permissive mode (if permitted
> by the policy).
>
> --
> Stephen Smalley <sds@epoch.ncsc.mil>
> National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
