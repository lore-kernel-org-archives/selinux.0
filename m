Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBSKWWIi024529
	for <selinux@tycho.nsa.gov>; Tue, 28 Dec 2004 15:32:32 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBSKUiGx029093
	for <selinux@tycho.nsa.gov>; Tue, 28 Dec 2004 20:30:44 GMT
Subject: Re: pam_selinux when selinux is disabled
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1104264941.21391.140.camel@moss-spartans.epoch.ncsc.mil>
References: <20041228202032.GA5296@lkcl.net>
	 <1104264941.21391.140.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1104265628.21391.152.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 28 Dec 2004 15:27:08 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-12-28 at 15:15, Stephen Smalley wrote:
> On Tue, 2004-12-28 at 15:20, Luke Kenneth Casson Leighton wrote:
> > does anyone know what happens when selinux is disabled and pam_selinux
> > is being used [by login, ssh, kdm, whatever]?
> 
> I believe that pam_selinux checks is_selinux_enabled() and bails
> immediately with PAM_SUCCESS if SELinux is not enabled; check the
> current pam_selinux module in the recently opened Fedora Core public CVS
> tree (see http://cvs.fedora.redhat.com/core.shtml).

BTW, sshd is no longer using pam_selinux; we had to go back to a direct
patch due to changes in the upstream sshd.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
