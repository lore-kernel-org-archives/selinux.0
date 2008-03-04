Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m24J5Cat026892
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 14:05:12 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m24J572k013122
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 19:05:07 GMT
Subject: Re: refpolicy: patch rpc
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
In-Reply-To: <20080227111051.GA22890@bobek.pm.i.cz>
References: <20080225123830.GA31035@bobek.pm.i.cz>
	 <1203949867.32061.52.camel@gorn>  <20080227111051.GA22890@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 04 Mar 2008 14:02:22 -0500
Message-Id: <1204657342.14217.17.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-02-27 at 12:10 +0100, Václav Ovsík wrote:
> On Mon, Feb 25, 2008 at 09:31:07AM -0500, Christopher J. PeBenito wrote:
> >...
> > Perhaps we should make sm-notify rpcd_exec_t and allow exec on that?
> 
> A new patch attached.

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
