Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2KK0YtT001787
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2007 16:00:34 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2KK0WuO008023
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2007 20:00:33 GMT
Subject: Re: New fail2ban policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F01D96.1010806@redhat.com>
References: <45F01D96.1010806@redhat.com>
Content-Type: text/plain
Date: Tue, 20 Mar 2007 20:01:04 +0000
Message-Id: <1174420865.16552.3.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 09:28 -0500, Daniel J Walsh wrote:

This seems to have rules similar to iptables:

> +allow fail2ban_t self : capability { net_admin net_raw };
> +allow fail2ban_t self : rawip_socket { getopt create setopt };

But also transitions to iptables?

> +optional_policy(`
> +       iptables_domtrans(fail2ban_t)
> +')

This also seems out of place:

> +selinux_get_fs_mount(fail2ban_t)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
