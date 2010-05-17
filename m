Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4HCXOJB001493
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2010 08:33:24 -0400
Received: from mail-pw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o4HCWicr023649
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2010 12:32:44 GMT
Received: by pwj2 with SMTP id 2so678458pwj.12
        for <selinux@tycho.nsa.gov>; Mon, 17 May 2010 05:33:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1274098502.2093.2.camel@gorn.columbia.tresys.com>
References: <AANLkTims07JUhAD9T2KvEGHZauBW6etkgCUQFKTAD1OP@mail.gmail.com>
	 <1274098502.2093.2.camel@gorn.columbia.tresys.com>
Date: Mon, 17 May 2010 17:33:22 +0500
Message-ID: <AANLkTilfYQzJy9tTjcjGXULO5ELAh4XuxMmrC1zGk7gQ@mail.gmail.com>
Subject: Re: [refpolicy] A strange usecase
From: Shaz <shazalive@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>, refpolicy@oss1.tresys.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, May 17, 2010 at 5:15 PM, Christopher J. PeBenito
<cpebenito@tresys.com> wrote:
> On Mon, 2010-05-17 at 16:42 +0500, Shaz wrote:
>> How can we "make sure a guest user can only see traffic counters of
>> eth0 but not eth1"
>
> It is not possible.  That info comes out of the /proc/net/dev proc file.
> All interfaces are in the same file, so you can either see all of the
> interfaces or none of the interfaces.  This can be controlled by
> allowing or denying access to proc_net_t files.

Not even with iptables-selinux?

-- 
Shaz


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
