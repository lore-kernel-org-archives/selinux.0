Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7HFRRE1008688
	for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2011 11:27:30 -0400
Received: from oproxy6-pub.bluehost.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p7HFRTU6021443
	for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2011 15:27:30 GMT
Received: from localhost ([127.0.0.1] helo=box559.bluehost.com)
	by box559.bluehost.com with esmtpa (Exim 4.76)
	(envelope-from <rarob@travelinglightfarm.net>)
	id 1Qti1g-0000l9-A4
	for selinux@tycho.nsa.gov; Wed, 17 Aug 2011 09:27:29 -0600
Message-ID: <c572d642a1bff2e1c49ce2d881d7eb2f.squirrel@box559.bluehost.com>
In-Reply-To: <1313592334.28571.18.camel@moss-pluto>
References: <5d23aa2d56b118186ba6a735c220f728.squirrel@box559.bluehost.com>
    <1313592334.28571.18.camel@moss-pluto>
Date: Wed, 17 Aug 2011 11:27:29 -0400
Subject: Re: RHEL5, selinux-policy-2.4.6.30-el5, and pidof AVC issue
From: rarob@travelinglightfarm.net
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> What exactly do you want myDomain_t to be able to do, and to what target
> processes?  I doubt you want to allow this for all of these domains.
> Which target processes do you want myDomain_t to be able to look up /
> kill?
>
> The relevant constraint here would be in policy/mcs, as your process is
> running with a MCS level of s0 aka SystemLow but the target is running
> s0-s0:c0.c1023 aka SystemHigh.  Type attribute is mcsptraceall,
> refpolicy interface is mcs_ptrace_all().  Alternatively you could run
> your process fully ranged to SystemHigh and avoid the need to add this
> attribute.
>
> --
> Stephen Smalley
> National Security Agency

Stephen,
  Basically I need to be able to run the equivalent of '/sbin/service *
status' for any service, and eventually start/stop as well.  I *think* I
may have cracked a good chunk of it (the status portion) by adding
'domain_dontaudit_ptrace_all_domains()' and 'allow myDomain_t pidfile:
{read getattr ioctl}'.
  I guess my understanding of SELinux is missing how the levels apply to a
basic targeted policy.  I had thought they didn't apply.  Eventually we
do want our policy to support MLC/MCS and ultimately the LSPP.  If we're
not running MCS/MLS does the SystemLow/SystemHigh ranges actually apply?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
