Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAJJ3dRb019956
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 14:03:39 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAJJ3cqY018950
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 19:03:38 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hAJJ3b0o018945 for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 19:03:37 GMT
Subject: RE: where to download LSM-patched 2.4
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: samwun <samwun@hgcbroadband.com>, Russell Coker <russell@coker.com.au>
Cc: "'SELinux ML'" <selinux@tycho.nsa.gov>
In-Reply-To: <013601c3ae97$e658a650$5801a8c0@samgpj2wzuimme>
References: <013601c3ae97$e658a650$5801a8c0@samgpj2wzuimme>
Content-Type: text/plain
Message-Id: <1069268601.25899.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 19 Nov 2003 14:03:22 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-11-19 at 07:23, samwun wrote:
> Where can I download LSM-patched 2.4 for lsm-2.4-selinux-2003040709.tgz
> kernel source?

That was from the April 2003 release of the old LSM-based SELinux.  If
you want the last released code of the old LSM-based SELinux, you can
obtain it from http://www.nsa.gov/selinux/download1.html.  Aside from
certain historical versions, older releases are not provided on the NSA
site.

> The problem is the SELinux kernel is able to loaded up after a reboot,
> but
> whenever issuing a command
> "ls --context" or whatever other SELinx related command options, it
> always
> said that the command ooptions needs SELinux kernel to support,  but I
> have
> verified the /var/log/messages file and uname command telling the
> SELinux
> kernel is loaded successfully. What could be missing from my
> installation?

Failure to load an initial policy?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
