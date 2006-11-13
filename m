Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kADLIVol030888
	for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2006 16:18:31 -0500
Received: from mail2.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kADLHlOD008473
	for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2006 21:17:48 GMT
Date: Mon, 13 Nov 2006 16:18:42 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, dccp@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH RFC] SELinux support for DCCP
In-Reply-To: <4558D93B.9030003@hp.com>
Message-ID: <XMMS.LNX.4.64.0611131615470.9597@d.namei>
References: <XMMS.LNX.4.64.0611110203540.25507@d.namei> <4558D93B.9030003@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 13 Nov 2006, Paul Moore wrote:

> Based on my simple understanding of DCCP it looks okay to me, i.e. all the
> relevant things we do for TCP seem to be done now for DCCP.  Also, I don't think
> adding labeled networking support should be all that difficult; basically we
> would need to do the following (can anyone think of anything else?):
> 
> 1. Add the security_inet_conn_established() hook to the DCCP code path (if it
> isn't there already, need to check) so that the last part of the DCCP handshake
> is caught by the LSM.
> 2. Add the DCCP socket class to the SELinux NetLabel code.

Yep, it should be identical to TCP in the simplest case.  It may be 
possible to label services within a connection (kind of like substreams), 
but it'd need to be supported by xfrm and IPsec first.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
