Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Jeremy Kusnetz <JKusnetz@nrtc.org>,
        "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
Subject: Re: New to SELinux
Date: Mon, 19 Aug 2002 22:47:23 +0200
References: <9366A6ACB518D511B54B0008C78609E002440271@exchange.nrtc.org>
In-Reply-To: <9366A6ACB518D511B54B0008C78609E002440271@exchange.nrtc.org>
MIME-Version: 1.0
Message-Id: <20020819204723.DB9796C3@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 19 Aug 2002 22:33, Jeremy Kusnetz wrote:
> I've been reading SELinux documentation and getting ready to try to deploy
> it on a system.
>
> A couple of questions.  Are there any up to date archives of this mailing
> list other then what's on NSA's site, since it doesn't get updated daily
> (last update on July 3rd)?

Other people are maintaining archives that are more current.  Check google.

> Second, I got a scared and read a slashdot article from today saying that
> NSA is no longer developing SELinux due to lobbying from  Microsoft because
> the government is competing against private American companies.  Is this
> true?  Is SELinux still being developed?  Is it still being developed by
> NSA, or someonen else now.

Don't believe slashdot.

AFAIK it's business as usual.  Lots of new things are being planned for SE 
Linux...

> If it is still being developed, is there an SELinux patch to the 2.4.19
> kernel?  I can only find patches to 2.4.18.  I see LSM has a patch to
> 2.4.19 but I read somewhere that I should only use SELinux LSM patches.

Get the patch for 2.4.19 and recent 2.5.x kernels from 
http://lsm.immunix.org/ .

They always have new releases long before the NSA does.  Steve often releases 
patches that will apply on top of the LSM release or the NSA release to add 
new SE Linux support.  I include these patches in my Debian package, so the 
Debian packages I release are the most current single release files you can 
get.  I have them on my web site at http://www.coker.com.au/selinux/kern/ .

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
