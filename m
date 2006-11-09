Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA9HSNUf026127
	for <selinux@tycho.nsa.gov>; Thu, 9 Nov 2006 12:28:23 -0500
Received: from mail6.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA9HRdx3021936
	for <selinux@tycho.nsa.gov>; Thu, 9 Nov 2006 17:27:40 GMT
Date: Thu, 9 Nov 2006 12:28:28 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Chad Sellers <csellers@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 4/4] SELinux: validate kernel object classes and permissions
In-Reply-To: <1163086571.12241.310.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <XMMS.LNX.4.64.0611091228200.25192@d.namei>
References: <C1751E53.19473%csellers@tresys.com>
 <1162933056.3009.62.camel@moss-spartans.epoch.ncsc.mil>
 <Pine.LNX.4.64.0611071620140.21330@d.namei> <1163086571.12241.310.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 9 Nov 2006, Stephen Smalley wrote:

> On Tue, 2006-11-07 at 16:20 -0500, James Morris wrote:
> > On Tue, 7 Nov 2006, Stephen Smalley wrote:
> > 
> > > (re-added list to cc)
> > 
> > Thanks.
> > 
> > Stephen, do you think these patches are suitable for merging?
> 
> Yes.
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.20.git



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
