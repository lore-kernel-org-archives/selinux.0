Subject: Re: RHEL5, selinux-policy-2.4.6.30-el5, and pidof AVC issue
From: Stephen Smalley <sds@tycho.nsa.gov>
To: rarob@travelinglightfarm.net
Cc: selinux@tycho.nsa.gov
In-Reply-To: <c572d642a1bff2e1c49ce2d881d7eb2f.squirrel@box559.bluehost.com>
References: <5d23aa2d56b118186ba6a735c220f728.squirrel@box559.bluehost.com>
	 <1313592334.28571.18.camel@moss-pluto>
	 <c572d642a1bff2e1c49ce2d881d7eb2f.squirrel@box559.bluehost.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Aug 2011 11:40:49 -0400
Message-ID: <1313595649.28571.44.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-08-17 at 11:27 -0400, rarob@travelinglightfarm.net wrote:
> Stephen,
>   Basically I need to be able to run the equivalent of '/sbin/service *
> status' for any service, and eventually start/stop as well.  I *think* I
> may have cracked a good chunk of it (the status portion) by adding
> 'domain_dontaudit_ptrace_all_domains()' and 'allow myDomain_t pidfile:
> {read getattr ioctl}'.
>   I guess my understanding of SELinux is missing how the levels apply to a
> basic targeted policy.  I had thought they didn't apply.  Eventually we
> do want our policy to support MLC/MCS and ultimately the LSPP.  If we're
> not running MCS/MLS does the SystemLow/SystemHigh ranges actually apply?

As of RHEL5 and later, the targeted policy includes MCS.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
