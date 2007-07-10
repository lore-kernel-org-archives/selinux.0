Subject: Re: can i use selinux and others to control bandwidth?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ken YANG <spng.yang@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <469356AC.7090701@gmail.com>
References: <469356AC.7090701@gmail.com>
Content-Type: text/plain
Date: Tue, 10 Jul 2007 09:18:23 -0400
Message-Id: <1184073503.12430.180.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-07-10 at 17:51 +0800, Ken YANG wrote:
> 
> hi all:
> 
> 
> i wondered how to use selinux or the combination with
> other mechanisms to control bandwidth?
> 
> e.g. i can confine john to use 30% of the whole bandwidth,
> and confine jerry to use 70% of the bandwidth.
> 
> i search in selinux mailing list, but i don't find anything
> useful, can anyone give some hints?
> 

SELinux doesn't presently provide controls on resource usage, although
it has been discussed as a natural extension, e.g. per-role/domain/level
resource limits.  There were some people looking at extending CKRM for
SELinux, but I think they gave up after they saw that CKRM wasn't
getting upstreamed.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
