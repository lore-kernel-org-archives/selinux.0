Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA26136
	for <selinux@tycho.nsa.gov>; Mon, 20 May 2002 16:21:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA23311
	for <selinux@tycho.nsa.gov>; Mon, 20 May 2002 20:19:57 GMT
Received: from unicorn.lemuria.org (a083166.adsl.hansenet.de [213.191.83.166])
        by jazzband.ncsc.mil  with ESMTP id UAA23307 for <selinux@tycho.nsa.gov>; Mon, 20 May 2002 20:19:55 GMT
Date: Mon, 20 May 2002 22:17:30 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: Policy creation RFC
Message-ID: <20020520221730.B24186@lemuria.org>
References: <4934.1021921674@www51.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4934.1021921674@www51.gmx.net>; from ian.sollars@gmx.net on Mon, May 20, 2002 at 09:07:54PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, May 20, 2002 at 09:07:54PM +0200, Ian Sollars wrote:
> For example, a point-and-click GUI is probably overkill considering
> the likely user base of selinux - i.e. security experts, sysadmins,
> and hobbyists.

not at all. a great many systems do not really have a need for
complicated security policies.

for example, I have a real-life system that is used as a staging
server by outside personel. I'd love to restrict them to a small set of
actions, e.g:

- log in via ftp and/or ssh
- read/write access to a directory or set of directories
- execution rights for a small set of binaries
  (user-dependent, some of them need to use telnet to access other
   machines on the network, most don't)

now if the configuration for such a straightforward policy could be
done with a GUI tool, then I could get selinux on a production machine.
the reason being this: If you work for a company, you have to make sure
someone can take over for you in case of illness or holidays. your
replacement is usually less skilled than you are(*).



(*) not necessarily on a general level, but usually within your areas
of expertise. e.g. when I play replacement for someone else, I'm
usually less skilled in whatever it is they are doing.

-- 
New GPG Key issued (old key expired):
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
