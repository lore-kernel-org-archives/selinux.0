Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3CDWPU9020504
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2011 09:32:29 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p3CDWSHA029432
	for <selinux@tycho.nsa.gov>; Tue, 12 Apr 2011 13:32:28 GMT
Message-ID: <4DA454C4.4050709@tresys.com>
Date: Tue, 12 Apr 2011 09:33:56 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: This patch cleans up a couple of crashes caused by libselinux
References: <4D9CD3F5.9080002@redhat.com>
In-Reply-To: <4D9CD3F5.9080002@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/06/2011 04:58 PM, Daniel J Walsh wrote:
> If you fail to load_policy in the init or SELinux is disabled, you need
> to free the selinux_mnt variable and clear the memory.
> 
> systemd was calling load_polcy on a DISABLED system then later on it
> would call is_selinux_enabled() and get incorrect response, since
> selinux_mnt still had valid data.
> 
> The second bug in libselinux, resolves around calling the
> selinux_key_delete(destructor_key) if the selinux_key_create call had
> never been called.  This was causing data to be freed in other
> applications that loaded an unloaded the libselinux library but never
> setup setrans or matchpathcon.
> 

Applied in libselinux-2.0.102

Thanks!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
