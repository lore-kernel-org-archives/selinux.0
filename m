Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l9MMkcie008067
	for <selinux@tycho.nsa.gov>; Mon, 22 Oct 2007 18:46:38 -0400
Message-ID: <471D284D.70700@tycho.nsa.gov>
Date: Mon, 22 Oct 2007 18:46:37 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: trouble with ssh in today's rawhide + refpolicy
References: <471D1596.8070900@tycho.nsa.gov>
In-Reply-To: <471D1596.8070900@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> On a rawhide box updated this afternoon, running refpolicy trunk in mcs 
> mode, I get the following after rebooting the box and logging in over ssh:
> 
> $ id -Z
> sysadm_u:sysadm_r:system_chkpwd_t:s0
> 
> After issuing a "service sshd restart" on the box and trying again, it 
> changes to:

Should have used run_init to restart sshd.  When I do this, it remains 
system_chkpwd_t.  Also, I'm running in permissive mode and using public 
key to authenticate.

Some searching revealed previous bug reports, most recently Sept 21:
http://archives.gentoo.org/gentoo-hardened/msg_07021.xml


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
