Subject: RE: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F529A780232@EUSAACMS0703.eamcs.ericsson.se>
References: 
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
	 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7B21A2.3080006@gmail.com> <4B7B97D4.7020005@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A558C9F@EUSAACMS0703.eamcs.ericsson.se>
	 <1266425895.4945.105.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780180@EUSAACMS0703.eamcs.ericsson.se>
	 <1266433081.4945.112.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A780232@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain
Date: Wed, 17 Feb 2010 14:58:44 -0500
Message-Id: <1266436724.4945.122.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-02-17 at 14:37 -0500, Alan Rouse wrote:
> Oops.
> 
> I'm a bit confused though.  What are the scenarios that trigger an
> autorelabel?  I've not had any luck with the -autorelabel kernel boot
> parameter, nor with the /.autorelabel flag file.  OTOH sometimes when
> I reboot it (apparently) decides to autorelabel.

In Fedora, automatic relabeling is performed by /etc/rc.d/rc.sysinit.
It is triggered if SELinux is enabled and either: 
1) the word "autorelabel" appears as a parameter in the kernel command
line, or
2) a file named "/.autorelabel" exists (in which case the file is then
removed)

The /.autorelabel file is automatically created by rc.sysinit if you
ever boot with SELinux disabled so that a subsequent boot with SELinux
re-enabled will trigger the automatic relabeling as well.

In any event, you can always just run fixfiles -F restore yourself (or
run 'make relabel' from the refpolicy directory). 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
