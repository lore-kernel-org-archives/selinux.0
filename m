Message-Id: <200209081959.TAA03658@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>
Subject: Re: pppd with ipppd
Date: Sun, 8 Sep 2002 22:00:40 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <20020906174227.C97B8FA8D@ivanova.coker.com.au> <200209081926.06666.russell@coker.com.au>
In-Reply-To: <200209081926.06666.russell@coker.com.au>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Sonntag, 8. September 2002 19:26 schrieb Russell Coker:
> Firstly in future please supply patches made with "diff -u", this saves
> time for people who merge them (otherwise they have to run diff
> themselves), and it means that the patches may still apply if you
> generated them from an old version of the source.
>
> On Fri, 6 Sep 2002 19:41, Carsten Grohmann wrote:
> > I follow your suggestion and add the few line for the ipppd to the
> > pppd_t domain. The attached files contains the rules and the patch for
> > the net_context and network.te files.
>
> I've applied the change to the file contexts in my tree.
>
> Why does ipppd need to run "ifconfig" while the regular pppd doesn't?  Or
> is it some script that calls ifconfig?

ifconfig is uesing by the SuSE ip-(up|down) scripts. You can remove the 
complete ifconfig section.

> Also I expect that ifconfig does not need udp access to pppd_t, it would
> be just another instance of pppd not setting it's file handles to close
> on exec.
>
> > May be that some rule is SuSE specific. I missing labeling the password
> > files in your rules. Don't you use it?
>
> What do you mean?

You define the type pppd_secret_t but you don't use it. Do you labeled the 
secret files manual? Or have she etc_t as security context? 

Carsten


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
