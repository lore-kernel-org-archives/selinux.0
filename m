Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAUFLMDj016839
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2012 10:21:27 -0500
Message-ID: <20121130102055.ofc76mrlusc0s40g-cebfxv@webmail.spamcop.net>
Date: Fri, 30 Nov 2012 10:20:55 -0500
From: Pavel Roskin <proski@gnu.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric Paris <eparis@parisplace.org>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Bisected regression: iterate_fd() selinux change affects flash
	plugin
References: <20121025101416.v1wilj95q8wkk0os-cebfxv@webmail.spamcop.net>
	<20121111235001.a3gqhaijmec0gk0g-cebfxv@webmail.spamcop.net>
	<CACLa4pu4FFwKdoA8ATfmviOj0e0mAQ3U2FNEiJHCv4RfDY4ZoQ@mail.gmail.com>
	<20121112115707.r8h545480kg0cgkk-cebfxv@webmail.spamcop.net>
	<CACLa4pvixB3Ehz-Ds+opvMF73pNwQJxpNx=02qy94ufJag2qwA@mail.gmail.com>
	<20121130034034.GB4939@ZenIV.linux.org.uk>
	<20121130040240.GC4939@ZenIV.linux.org.uk>
In-Reply-To: <20121130040240.GC4939@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Al Viro <viro@ZenIV.linux.org.uk>:

> On Fri, Nov 30, 2012 at 03:40:34AM +0000, Al Viro wrote:
>
>> The bug is real, but Pavel's patch is all wrong.  The problem is in the
>> argument; we should pass descriptor number, not descriptor + 1.  And fixing
>> that (in iterator_fd() itself) makes all callbacks work as they ought to.
>>
>> PS: Pavel, the life is painful enough as it is, no need to involve BZ into
>> it.  Next time you need to post a patch, please do just that, especially
>> when it's so short, OK?
>
> See tonight's vfs.git#for-linus; the head is at commit a77cfcb.

Works for me!  Thank you!  Sorry if I mishandled anything.

-- 
Regards,
Pavel Roskin

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
