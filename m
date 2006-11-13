Message-ID: <4558DB75.9020608@hp.com>
Date: Mon, 13 Nov 2006 15:54:13 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, dccp@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH RFC] SELinux support for DCCP
References: <XMMS.LNX.4.64.0611110203540.25507@d.namei> <4558D93B.9030003@hp.com>
In-Reply-To: <4558D93B.9030003@hp.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
 > Based on my simple understanding of DCCP it looks okay to me, i.e. all the
> relevant things we do for TCP seem to be done now for DCCP.  Also, I don't think
> adding labeled networking support should be all that difficult; basically we
> would need to do the following (can anyone think of anything else?):
> 
> 1. Add the security_inet_conn_established() hook to the DCCP code path (if it
> isn't there already, need to check) so that the last part of the DCCP handshake
> is caught by the LSM.

Sorry, forgot to mention that we would also need to check the other related LSM
connection based hooks like inet_conn_request() and inet_csk_clone().

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
