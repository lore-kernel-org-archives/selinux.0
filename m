Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qB49vMhq030127
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2012 04:57:23 -0500
Received: from sander.oxilion (kantoor.oxilion.nl [93.186.176.113])
	by vds-1069.hoentjen.eu (Postfix) with ESMTPSA id 0CE9FE1343
	for <selinux@tycho.nsa.gov>; Tue,  4 Dec 2012 10:56:47 +0100 (CET)
Message-ID: <50BDC8DE.2080009@hoentjen.eu>
Date: Tue, 04 Dec 2012 10:56:46 +0100
From: Sander Hoentjen <sander@hoentjen.eu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: policy for PowerDNS
References: <50BCB590.8010602@hoentjen.eu> <1354547440.13093.3.camel@localhost>
In-Reply-To: <1354547440.13093.3.camel@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/03/2012 04:10 PM, grift wrote:
> On Mon, 2012-12-03 at 15:22 +0100, Sander Hoentjen wrote:
>> Hi all,
>>
>> I had created a policy for PowerDNS (pdns package in Fedora), but after
>> e-mailing with dwalsh he told me it might be better to just adapt the
>> named policy a bit. Here is what I have so far:
>> ======pdns.fc======
>> /usr/sbin/pdns_server  -- gen_context(system_u:object_r:named_exec_t,s0)
>> /etc/pdns/pdns.conf    -- gen_context(system_u:object_r:named_conf_t,s0)
>> /var/run/pdns.controlsocket -s
>> gen_context(system_u:object_r:named_var_run_t,s0)
>> /var/run/pdns.pid   -- gen_context(system_u:object_r:named_var_run_t,s0)
>
> escape the periods here though to minimize chances of error
>
Thanks, I fixed that now.
-- 
Sander

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
