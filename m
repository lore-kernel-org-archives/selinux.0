Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7NDw2hA030602
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 09:58:02 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7NDw1pd000662
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2011 13:58:01 GMT
Message-ID: <4E53B1E8.2050508@tresys.com>
Date: Tue, 23 Aug 2011 09:58:00 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Harry Ciao <qingtao.cao@windriver.com>, <slawrence@tresys.com>,
        <selinux@tycho.nsa.gov>
Subject: Re: [v0 PATCH 6/6] Skip tunable identifier and cond_node_t in expansion.
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com> <1314094112-6477-7-git-send-email-qingtao.cao@windriver.com> <4E53AE8C.6020707@redhat.com>
In-Reply-To: <4E53AE8C.6020707@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/23/11 09:43, Daniel J Walsh wrote:
> Eliminating booleans would be great and replacing them with tunables,
> but the tunables must be discoverable, and it must be easy for the
> administrator to discover the "tunable" and turn it on.
> 
> Currently audit2allow/audit2why turns on all booleans in a policy and
> checks to see if an AVC would be allowed with any boolean.  Then it
> prints out the booleans that would have allowed the access.  We use
> this functionality within setroubleshoot.  This is critical to making
> selinux policy usable.
> 
> User wants to allow ftp to access homedirs, he sets up ftp and SELinux
> blocks the access.  Setroubleshoot comes up and says turn on the
> ftp_home_dir boolean to allow this access.
> 
> 
> If we can not duplicate this functionality then I NAK the change from
> booleans to tunables.

Seems very easy to reproduce, as long as you turn on save-linked in
semanage.conf.  The linked policy would have all the tunable
information, right Harry?

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
