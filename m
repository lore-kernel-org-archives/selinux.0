From: Paul Moore <paul.moore@hp.com>
To: tmiller@tresys.com
Subject: Re: [patch 0/2] policy capability support
Date: Thu, 6 Dec 2007 13:50:49 -0500
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jbrindle@tresys.com
References: <20071205184848.180973622@tresys.com>
In-Reply-To: <20071205184848.180973622@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712061350.49277.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 05 December 2007 1:48:48 pm tmiller@tresys.com wrote:
> This is a respin of the policy capability support patch that preserves
> the policycaps in the final policy binary and includes support for
> displaying policy caps in dispol/dismod.

Looks like it is working ...

 # cat /selinux/policy_capabilities/network_peer_controls
 0# semodule -i peer_test.pp
 # cat /selinux/policy_capabilities/network_peer_controls
 1# semodule -r peer_test
 # cat /selinux/policy_capabilities/network_peer_controls
 0# 

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
