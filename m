Subject: Re: Assigning a Type to Network Interfaces
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jason Shaw <js44352@gmail.com>
Cc: Paul Moore <paul.moore@hp.com>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, selinux@lists.fedoraproject.org,
        selinux@tycho.nsa.gov
In-Reply-To: <c63e41181001172021k16589685pf807e11feea5eb29@mail.gmail.com>
References: <c63e41181001140608u37e57495s15bd7c7d2f50a0e3@mail.gmail.com>
	 <1263479874.8548.20.camel@moss-pluto.epoch.ncsc.mil>
	 <c63e41181001172021k16589685pf807e11feea5eb29@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 19 Jan 2010 09:20:53 -0500
Message-Id: <1263910853.12068.6.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2010-01-17 at 21:21 -0700, Jason Shaw wrote:
> Just wanted to follow-up to see if I am misunderstanding the purpose
> of semanage -interface. Once a type is assigned to an interface such
> as eth0, should an application running in its own domain be able to
> bind to the interface without an allow rule (using net_raw, tcp, or
> udp)?

(extended cc line to include fedora and upstream selinux lists).

There are no netif-based checks during bind(2).  There can be
netif-based checks during packet send/recv, but the legacy checks were
obsoleted and removed as I noted, and the newer checks require
additional configuration (iptables for SECMARK, netlabel or ipsec for
labeled networking).

> On Thu, Jan 14, 2010 at 7:37 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
>         
>         On Thu, 2010-01-14 at 07:08 -0700, Jason Shaw wrote:
>         > I need help understanding if SELinux supports restricting a
>         confined
>         > application from binding to specific network interfaces. I
>         cannot seem
>         > to make this work under F11 and F12 (using targeted, mls,
>         and
>         > reference policies), or under RHEL 5.3U3 targeted.
>         >
>         > Details:
>         > - I have a system with two network interfaces: eth0 and
>         eth1.
>         > - I have an application that must only be allowed to read
>         data from
>         > eth0 (raw and tcp).
>         > - I do not need to label packets.
>         >
>         > Here's what I have tried
>         > 1) In a new policy module, I create new types: myApp_exec_t,
>         myApp_t,
>         > myApp_eth0_t, myApp_eth1_t.
>         > 2) I use semanage -fcontext to label my application's
>         executable file
>         > as myApp_exec_t
>         > 3) I assign eth0 with a new type: 'semanage interface -a -t
>         > myApp_eth0_t eth0'
>         > 4) I assign eth1 with a new type: 'semanage interface -a -t
>         > myApp_eth1_t eth1'
>         > 5) In my policy module, I allow the following: "allow
>         myApp_t
>         > self:capability net raw", and "allow myApp_t self:tcp_socket
>         { accept
>         > read }"
>         > 6) I verify that when I execute my application, using ps
>         -efZ it is
>         > running in the myApp_t domain (has transitioned properly
>         from
>         > unconfined_t)
>         >
>         > The problem is, my app can read raw or tcp data from either
>         eth0 or
>         > eth1 even though both interfaces have been assigned
>         different types
>         > using semanage -interface.
>         >
>         > Is this because 'allow myApp_t self:capability net_raw' does
>         not
>         > distinguish between network interfaces? Is my understanding
>         of
>         > semanage -interface incorrect - shouldn't labeling the
>         interface
>         > result in no ability to use the interface unless explicitly
>         allowed?
>         
>         
>         The legacy network permission checks were removed in Linux
>         2.6.30, and
>         even prior to that they had been disabled for a long time by
>         default
>         unless you set /selinux/compat_net to 1.  These days you need
>         to use
>         secmark or the newer ingress/egress permission checks to
>         achieve the
>         same effect.   Using secmark requires you to configure
>         iptables SECMARK
>         targets to label the packets.  Using ingress/egress requires
>         you to
>         configure labeled networking (netlabel or labeled ipsec) and
>         make sure
>         that /selinux/policy_capabilities/network_peer_controls exists
>         and is
>         set to 1 (requires Linux >= 2.6.25 and a policy built with
>         that
>         capability).  See:
>         http://paulmoore.livejournal.com/4281.html
>         http://paulmoore.livejournal.com/2128.html
>         
>         --
>         Stephen Smalley
>         National Security Agency
>         
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
