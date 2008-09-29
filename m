Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8TFF5Kk005702
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2008 11:15:05 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m8TFE2dp025597
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2008 15:14:03 GMT
Message-ID: <48E0F0F8.40005@manicmethod.com>
Date: Mon, 29 Sep 2008 11:15:04 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to make libsemanage/selinux policy require less space.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Currently selinux-policy*rpm install the pp files in
> /usr/share/selinux/POLICYTYPE/*.pp
> 
> Then it calls semodule on them to load the policy.  libsemanage copies
> the policy package files to /etc/selinux/targeted/modules/active,  Then
> it recopies the files to /etc/selinux/targeted/modules/previous, where
> it finishes the assembly of the files.
> 
> So we end up requiring three times as much space as necessary if the
> modules are not changing.
> 
> Policy in Rawhide is 36 megabytes.
> 
> So on small devices or even usb sticks and cd's this is a large waste of
> space.  This patch is an attempt to use hard links when we can.
> 
> I have not put it in production, since I wanted people who know the
> library better then me to tell me whether it is a cracked idea.
> 
> There is really two ideas in the patch.  One is to add interfaces
> semanage_modules_*_file which take a file instead of a block of memory.
>  semodule would then be changed to use these interfaces.
> 
> The library then calls semanage_link,  This function checks to make sure
> the file countext of the source matches the file context of the
> destination, if they match, the tool will attempt a link, if either
> fails the tool will fall back to copy them.

I'm open to the idea, I'll take a look at the patch closer as soon as I can.

> 
> I changed the write_file to unlink the destination file which would
> remove the linked file if it exists.
> 

Why would write_file unlink the destination?

> 
> semanage_store has been changed, so that the creation of the sandbox is
> via link, if possible.
> 

Not sure what this means, you are using a link for the store itself?

> Is this a good idea or bad?
> 
> Also want to reinvestigate using some form of compression.

We've talked about this before but noone has gone off and implemented it. I don't want to slow down semodule and friends for the vast majority of people who don't care about space but for installations on small devices bzip2 can provide quite a bit of savings:

33M     targeted
1.6M    targeted.compressed





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
