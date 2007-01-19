From: Paul Moore <paul.moore@hp.com>
To: Antoine Martin <antoine@nagafix.co.uk>
Subject: Re: 2.6.19.2 Oops
Date: Fri, 19 Jan 2007 10:48:30 -0500
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>
References: <45B09CFA.5070805@nagafix.co.uk> <45B0C712.3090802@nagafix.co.uk> <45B0E782.9070102@nagafix.co.uk>
In-Reply-To: <45B0E782.9070102@nagafix.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200701191048.30219.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, January 19 2007 10:45 am, Antoine Martin wrote:
> Disabling Netlabel did the trick.
> Shouldn't that be sent to stable for 2.6.19.3? (it is a oops after all)

Yep, I'm working on a patch as I type this ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
