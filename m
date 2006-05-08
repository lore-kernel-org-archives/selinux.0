Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k48NrcBY001664
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 19:53:38 -0400
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k48Nrbtw023722
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 23:53:38 GMT
Date: Mon, 8 May 2006 19:53:33 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC][SECMARK 05/08] Add new packet controls to SELinux
In-Reply-To: <1147106449.23640.102.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0605081947400.19850@d.namei>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
 <Pine.LNX.4.64.0605071136100.8588@d.namei> <1147106449.23640.102.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 8 May 2006, Stephen Smalley wrote:

> Should we provide alternative ways of specifying the initial value for
> selinux_compat_net as well, as we do with checkreqprot (it can be
> initialized via kernel config option or via boot parameter as well as
> modified via selinuxfs)?  That way a distribution can choose to build
> with compatibility enabled by default without patching, and users can
> boot a kernel with a particular mode of operation if desired.

It doesn't seem warranted as a boot option and/or kernel config option as 
the desired behavior can be trivially selected during early boot.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
