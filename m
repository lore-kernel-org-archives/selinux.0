Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Subject: Re: pppd with ipppd
Date: Sun, 8 Sep 2002 22:34:38 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <20020906174227.C97B8FA8D@ivanova.coker.com.au> <200209081926.06666.russell@coker.com.au> <20020908200112.6F3E8FA8D@ivanova.coker.com.au>
In-Reply-To: <20020908200112.6F3E8FA8D@ivanova.coker.com.au>
MIME-Version: 1.0
Message-Id: <200209082234.38885.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 8 Sep 2002 22:00, Carsten Grohmann wrote:
> > Why does ipppd need to run "ifconfig" while the regular pppd doesn't?  Or
> > is it some script that calls ifconfig?
>
> ifconfig is uesing by the SuSE ip-(up|down) scripts. You can remove the
> complete ifconfig section.

Or could just have "can_exec(pppd_t, ifconfig_exec_t)"...

> > Also I expect that ifconfig does not need udp access to pppd_t, it would
> > be just another instance of pppd not setting it's file handles to close
> > on exec.
> >
> > > May be that some rule is SuSE specific. I missing labeling the password
> > > files in your rules. Don't you use it?
> >
> > What do you mean?
>
> You define the type pppd_secret_t but you don't use it. Do you labeled the
> secret files manual? Or have she etc_t as security context?

Oh yes, I just forgot about that.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
