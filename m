Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Walker, Jason" <Jason.Walker@csoconline.com>,
        "'SeLinux@tycho.nsa.gov'" <SeLinux@tycho.nsa.gov>
Subject: Re: Troubles with 2.4.18 kernel
Date: Thu, 28 Mar 2002 23:23:54 +0100
References: <72222DC86846D411ABD300A0C9EB08A106C52D23@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A106C52D23@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020328222355.29056421B8@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 28 Mar 2002 22:21, Walker, Jason wrote:
> My VMWare installation is having some problems with the 2.4.18 kernel.
> Specifically, the IDE CD-ROM drive is causing lockups in the virtual
> machine.  This is happening with both a 'stock' 2.4.18 kernel and with the
> SELinux version.
>
> Problem is, I can't find older releases of LSM/SELinux on the nsa.gov
> website...where are older releases kept?

http://lsm.immunix.org/

Immunix has had SE Linux included in their patches for several versions now 
and they have lots of old versions on their site.

I usually take my patches from Immunix instead of the NSA site.  When a new 
kernel comes out Immunix has a patch long before the NSA.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
