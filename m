Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i43DMkRb004934
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 09:22:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i43DMiYW028962
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 13:22:44 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i43DMiBf028959 for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 13:22:44 GMT
Subject: Re: build script problem : sed command error
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: maxence.bernard@ensi-bourges.fr
Cc: selinux@tycho.nsa.gov
In-Reply-To: <40786.172.20.128.112.1083588820.squirrel@ldap.ensi-bourges.fr>
References: <40786.172.20.128.112.1083588820.squirrel@ldap.ensi-bourges.fr>
Content-Type: text/plain
Message-Id: <1083590556.7446.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 03 May 2004 09:22:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-05-03 at 08:53, maxence.bernard@ensi-bourges.fr wrote:
> + make DESTDIR=/var/tmp/policy-buildroot install
> sed: -e expression #1, char 132: Unknown option to 's'
> Usage: /usr/sbin/genhomedircon POLICYSOURCEDIR FILE_CONTEXTS
> make: *** [file_contexts/file_contexts] Erreur 1
> error: Bad exit status from /var/tmp/rpm-tmp.3423 (%install)

What is the output of:
sed -V
make --version
python -V

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
