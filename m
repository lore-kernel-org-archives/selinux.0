Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>,
        Brian May <bam@snoopy.apana.org.au>
Subject: Re: security context for temporalily mounted filesystems
Date: Mon, 12 Aug 2002 00:01:50 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <200208091352.NAA00864@jazzband.ncsc.mil> <20020811145503.0E4C68654@lyta.coker.com.au> <20020811215228.CE1DDFA95@ivanova.coker.com.au>
In-Reply-To: <20020811215228.CE1DDFA95@ivanova.coker.com.au>
MIME-Version: 1.0
Message-Id: <20020811220151.0F45A8682@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 11 Aug 2002 23:51, Carsten Grohmann wrote:
> Who is an new type: usermountpoint_t and a new domain usermount_t like
> mount_t to allow the users in user_r to allow mount removeable disk
> devices?

I'm not sure I understand this.

However are you using Brian May's policy for multiple mount domains or my 
policy that is a derivative of his policy?  I think that some variation of 
the policy that Brian and I are working on for mount has a chance of getting 
into the CVS and it might be best for you to use it.

> I will post the changed rules tomorrow. Now I only test it and it works
> fine I guess.
>
> Carsten

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
