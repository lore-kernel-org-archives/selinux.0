Message-Id: <200209092004.UAA29734@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>
Subject: Re: pppd with ipppd
Date: Mon, 9 Sep 2002 22:00:59 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <200209082234.38885.russell@coker.com.au>
In-Reply-To: <200209082234.38885.russell@coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Sonntag, 8. September 2002 22:34 schrieb Russell Coker:
> On Sun, 8 Sep 2002 22:00, Carsten Grohmann wrote:
> > > Why does ipppd need to run "ifconfig" while the regular pppd doesn't?
> > >  Or is it some script that calls ifconfig?
> >
> > ifconfig is uesing by the SuSE ip-(up|down) scripts. You can remove the
> > complete ifconfig section.
>
> Or could just have "can_exec(pppd_t, ifconfig_exec_t)"...

If you don't need it, I would don't add this to the general rules. For my 
SuSE rules I would add this in a seperate file (pppd_suse.(te|fc)) like the 
other SuSE specific settings.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
