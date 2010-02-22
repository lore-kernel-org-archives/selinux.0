Message-ID: <4B81DE00.1040907@gmail.com>
Date: Sun, 21 Feb 2010 17:29:36 -0800
From: "Justin P. mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Alan Rouse <alan.rouse@ericsson.com>, Dominick Grift <domg472@gmail.com>,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>	 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>	 <4B7C47DB.40602@gmail.com>	 <1266436827.4945.123.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F529A78028F@EUSAACMS0703.eamcs.ericsson.se>	 <4B7DB3B4.2070409@gmail.com>	 <1266589714.32011.14.camel@moss-pluto.epoch.ncsc.mil>	 <4B7EDC9A.40801@gmail.com>	 <5A5E55DF96F73844AF7DFB0F48721F0F52E316B01D@EUSAACMS0703.eamcs.ericsson.se>	 <1266614711.32011.107.camel@moss-pluto.epoch.ncsc.mil>	 <5A5E55DF96F73844AF7DFB0F48721F0F52E316B05F@EUSAACMS0703.eamcs.ericsson.se> <1266615434.32011.111.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1266615434.32011.111.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hmm... this dbus error is a bugger..
spent yesterday and most of today on this.
(and I know I said I was going to goto a kernel bug).

Anyways:
seems after doing a fresh install then installing
the selinux apps/libs the system has not done
an initial relabel, upon reboot gdm will restart/flicker
5 times before erroring out, then drop you to a general login.
If I chmod 644 /etc/selinux/config this goes away.
(my guess is libselinux didn't have the permissions to read the config
defaulting to "targeted").

but as soon as I relabel the filesystem the dbus error will
appear(but not the screen flickering 5 times). when this happens I:
vim /etc/selinux/refpolicy-standard/booleans
and change init_upstart to true.

then I can bootup.

why is init_upstart needed in order for this to work,
when this system uses sysvinit?

positive side is this thing boots up without the need
for the policy to be named targeted.

Justin P. mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
