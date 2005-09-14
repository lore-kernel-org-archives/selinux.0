Subject: Re: info on SELinux support for IPSEC
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Prakash Saivasan <helloprak@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20050914152648.73447.qmail@web54406.mail.yahoo.com>
References: <20050914152648.73447.qmail@web54406.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 14:20:49 -0400
Message-Id: <1126722049.12299.157.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-14 at 16:26 +0100, Prakash Saivasan wrote:
> Hi All,
> 
>     Can anyone provide me with information on SELinux
> support/integration with IPSEC ? Is there any document that talks
> about the implementation details policy et al.,

The necessary kernel patches are still being discussed on the netdev
mailing list.  An updated patch for ipsec tools has been posted recently
to the redhat-lspp list.  Nothing upstream yet.

A presentation from last year's SELinux Symposium describes the overall
approach:
http://www.selinux-symposium.org/2005/presentations/session2/2-3-jaeger.pdf

It is also described in the original submissions on netdev:
http://marc.theaimsgroup.com/?l=linux-netdev&m=111629897618372&w=2
http://marc.theaimsgroup.com/?l=linux-netdev&m=111629897610638&w=2

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
