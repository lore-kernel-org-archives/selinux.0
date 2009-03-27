Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2RKwIAt003705
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 16:58:18 -0400
Received: from g4t0014.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2RKwHfp006009
	for <selinux@tycho.nsa.gov>; Fri, 27 Mar 2009 20:58:18 GMT
From: Paul Moore <paul.moore@hp.com>
To: linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/6] lsm: Relocate the IPv4 security_inet_conn_request() hooks
Date: Fri, 27 Mar 2009 16:58:13 -0400
Cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org, casey@schaufler-ca.com,
        etienne.basset@numericable.fr
References: <20090327205455.17740.61639.stgit@flek.lan>
In-Reply-To: <20090327205455.17740.61639.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200903271658.13633.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 27 March 2009 04:54:55 pm Paul Moore wrote:
> The current placement of the security_inet_conn_request() hooks do not
> allow individual LSMs to override the IP options of the connection's
> request_sock ...

My apologies, please ignore this.  I was in the process of sending a patchset 
and fat fingered the enter key.  The real patchset will follow shortly. 

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
