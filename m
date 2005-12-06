Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jB6JPlMA022444
	for <selinux@tycho.nsa.gov>; Tue, 6 Dec 2005 14:25:48 -0500 (EST)
Received: from xproxy.gmail.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jB6JJZks001991
	for <selinux@tycho.nsa.gov>; Tue, 6 Dec 2005 19:19:35 GMT
Received: by xproxy.gmail.com with SMTP id s8so110357wxc
        for <selinux@tycho.nsa.gov>; Tue, 06 Dec 2005 11:18:36 -0800 (PST)
From: Mario Olimpio de Menezes <mo.menezes@gmail.com>
Reply-To: mo.menezes@gmail.com
To: selinux@tycho.nsa.gov
Subject: Re: slapd on debian stable
Date: Tue, 6 Dec 2005 17:08:12 -0200
References: <1133804764.15188.21.camel@wintermute.xmldesign.de> <87iru2i0ju.fsf@glaurung.internal.golden-gryphon.com>
In-Reply-To: <87iru2i0ju.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512061708.12891.mo.menezes@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

    In Debian Sarge, /usr/sbin/slapd is a link to /usr/lib/slapd

$ ls -l /usr/sbin/slapd
lrwxrwxrwx  1 root root 12 2005-12-01 11:53 /usr/sbin/slapd -> ../lib/slapd

On Tuesday 06 December 2005 15:43, Manoj Srivastava wrote:
> Hi,
>
> On Mon, 05 Dec 2005 18:46:03 +0100, Erich Schubert <erich@debian.org> said:
> > Hi, at least on debian stable (didn't check unstable), the debian
> > slapd binary is located in /usr/lib/slapd (and thus not
> > system_u:object_r:slapd_exec_t) Should we add a conditional or an
> > unconditional statement for this to the ldap policy files?
>
>         In Sid, the location seems to be changed:
> __> dlocate slapd | egrep 'slapd$'
> slapd: /usr/sbin/slapd
>
>         manoj

-- 
Mario O.de Menezes, Ph.D.     "Many are the plans in a man's heart, but
LinuxUser: #24626         is the Lord's purpose that prevails" Pv 19.21
                        http://www.ipen.br/~mario      

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
