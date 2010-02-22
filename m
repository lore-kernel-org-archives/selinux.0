From: Alan Rouse <alan.rouse@ericsson.com>
To: "Justin P. mattock" <justinmattock@gmail.com>,
        Stephen Smalley
	<sds@tycho.nsa.gov>
CC: Dominick Grift <domg472@gmail.com>,
        "'selinux@tycho.nsa.gov'"
	<selinux@tycho.nsa.gov>
Date: Mon, 22 Feb 2010 12:58:55 -0500
Subject: RE: SELinux Policy in OpenSUSE 11.2
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F52E41FF3A0@EUSAACMS0703.eamcs.ericsson.se>
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>
	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>
	 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7C47DB.40602@gmail.com>
	 <1266436827.4945.123.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A78028F@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7DB3B4.2070409@gmail.com>
	 <1266589714.32011.14.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7EDC9A.40801@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E316B01D@EUSAACMS0703.eamcs.ericsson.se>
 <1266614711.32011.107.camel@moss-pluto.epoch.ncsc.mil>
 <4B7F06F1.4070305@gmail.com>
In-Reply-To: <4B7F06F1.4070305@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Justin wrote:
> alan,
>
> here is a good tutorial on the login:
> http://www.gentoo.org/proj/en/hardened/selinux/selinux-handbook.xml?part=3&chap=4

Do I need to change the login context for some linux user / users?

> just make sure /etc/pam.d/*
> has pam_selinux.so close/open
> (in the certain files)

I'm not following you.   Do I need to edit one or more of the files in /etc/pam.d/? 

Sorry I'm a bit slow on this.  You're knowledge about linux is leaving me in the dust!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
