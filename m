Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0DLBWXf028510
	for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2006 16:11:32 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0DLBTpN013661
	for <selinux@tycho.nsa.gov>; Fri, 13 Jan 2006 21:11:29 GMT
Message-ID: <43C81742.90502@redhat.com>
Date: Fri, 13 Jan 2006 16:10:26 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: sound policy (aumix-minimal)
References: <1137079986.29815.196.camel@sgc.columbia.tresys.com>
In-Reply-To: <1137079986.29815.196.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> Is the sound policy (sound.te) actually needed?  It is meant
> for /bin/aumix-minimal to set alsa mixer settings when booting.  Looking
> at the permissions, initrc_t already has sufficient permissions to do
> this.  I believe we can drop this module.  Thoughts?
>
>   
No problem with me.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
