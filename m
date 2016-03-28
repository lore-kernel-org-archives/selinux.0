Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2SDWHJJ010509
 for <selinux@tycho.nsa.gov>; Mon, 28 Mar 2016 09:32:20 -0400
Date: Mon, 28 Mar 2016 13:29:15 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
 Dominick Grift <dac.override@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 Eric Paris <eparis@parisplace.org>
Message-ID: <768212085.1911631.1459171755950.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <56F93129.6020408@tycho.nsa.gov>
References: <56F93129.6020408@tycho.nsa.gov>
Subject: Re: CIL: invalid protocol (dccp portcon)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>






> On Monday, 28 March 2016, 14:26, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 03/28/2016 08:53 AM, Dominick Grift wrote:
>> 
>>  I was adding support for syslog ports, and /etc/services indicated to
>>  me that syslog(_tls) has support for dccp protocol. So tried to add
>>  that support in.
>> 
>>  However when trying to specify a portcon, secilc tells me dccp is an
>>  invalid protocol.
>> 
>>  e.g.
>> 
>>  (portcon "dccp" 6514 port_obj_context)
> 
> Doesn't appear to be supported by the selinux userspace presently (even
> apart from CIL).  Not sure why.  Looking back, I see the original
> "SELinux support for DCCP" RFC thread, which included a (now dead) 
> link
> to patches for userspace support, but I don't see any indication that

> they were ever submitted.

The only valid portcon protocol types supported by the kernel and policy
statements are "tcp" and "udp". I did some time ago send RFC patches
(kernel & CIL) to add "dccp" and "sctp" but these died. Adding support
for a dccp portcon statement would not be difficult as there is SELinux
support already for the protocol (policycoreutils is a pain though as
lots of language files !!!).
> 
> 
> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to 
> Selinux-request@tycho.nsa.gov.
> 
