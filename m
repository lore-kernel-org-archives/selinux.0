Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9RJNDWt027504
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 14:23:13 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9RJMvIS010881
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 19:22:57 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
	by jazzswing.ncsc.mil  with ESMTP id h9RJMuDc010878
	for <selinux@tycho.nsa.gov>; Mon, 27 Oct 2003 19:22:56 GMT
Subject: Re: question about pam_selinux multiple option
From: Chris PeBenito <pebenito@gentoo.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <3F9D33EC.8060705@redhat.com>
References: <20031025134459.4fb0e536.ynakam@ori.hitachi-sk.co.jp>
	 <3F9D33EC.8060705@redhat.com>
Content-Type: text/plain
Message-Id: <1067282582.1077.16.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Mon, 27 Oct 2003 13:23:03 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-10-27 at 09:04, Daniel J Walsh wrote:
> The multiple option was added to allow the user to select the security 
> context they would be allowed to login in as.  We have decided to pull 
> this functionality from login programs and only allow the user to login 
> with the default context.

I'm curious what prompted this change?  Prompting the user for the
context they want to login with, for local logins, has been there for as
long as I've used SELinux (though thats only since March).  That is, in
the older /bin/login patches.

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
