Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBSHkxIi023215
	for <selinux@tycho.nsa.gov>; Tue, 28 Dec 2004 12:47:00 -0500 (EST)
Received: from kandu.netexpress.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBSHl1La027641
	for <selinux@tycho.nsa.gov>; Tue, 28 Dec 2004 17:47:01 GMT
Date: Thu, 29 Jul 2004 01:12:58 -0700
From: Steve Langasek <vorlon@netexpress.net>
Message-ID: <20040729081255.GD31603@quetzlcoatl.dodds.net>
References: <20040725095739.GH3437@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040725095739.GH3437@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: IDEA: /etc/pam.d/*/*
Reply-To: Pluggable Authentication Modules <pam-list@redhat.com>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/pam-list>,
	<mailto:pam-list-request@redhat.com?subject=unsubscribe>
List-Archive: </archives/pam-list>
List-Post: <mailto:pam-list@redhat.com>
List-Help: <mailto:pam-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/pam-list>,
	<mailto:pam-list-request@redhat.com?subject=subscribe>
To: nicholas.vermeer@gmail.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jul 25, 2004 at 10:57:39AM +0100, Luke Kenneth Casson Leighton wrote:
> there is a minor issue of inter-dependence of packages that may
> be resolved by applying the usual debian approach of 
> "if-it-was-a-config-file-make-it-a-directory".

> the issue is that Debian has to cater for SELinux being
> installed and not installed.

> openssh, login, kdm, gdm, su and several other packages all
> require "session pam_selinux.so required" to be added to
> their respective /etc/pam.d/XXX configurations in order for
> SE/Linux to operate correctly.

> Redhat is solving the issue by always enabling SE/Linux by
> default.

> Debian has no such luxury.

> therefore, openssh etc. etc. cannot accept upstream patches
> to have /etc/pam.d/ssh include that line by default, because
> if you do, and pam_selinux.so is not installed, you're hosed.

Er, Debian's support or lack thereof for SELinux doesn't seem terribly
relevant to what OpenSSH ships as a default PAM config, considering all
PAM-supporting Debian packages include fairly heavily-customized
configurations.

-- 
Steve Langasek
postmodern programmer


_______________________________________________
Pam-list mailing list
Pam-list@redhat.com
https://www.redhat.com/mailman/listinfo/pam-list


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
