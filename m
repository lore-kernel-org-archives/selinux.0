Subject: RE: SELinux Policy in OpenSUSE 11.2
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Rouse <alan.rouse@ericsson.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F52E41FF477@EUSAACMS0703.eamcs.ericsson.se>
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
	 <4B7C47DB.40602@gmail.com>
	 <1266436827.4945.123.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A78028F@EUSAACMS0703.eamcs.ericsson.se>
	 <4B7DB3B4.2070409@gmail.com>
	 <1266589714.32011.14.camel@moss-pluto.epoch.ncsc.mil>
	 <4B7EDC9A.40801@gmail.com>
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E316B01D@EUSAACMS0703.eamcs.ericsson.se>
	 <1266614711.32011.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E316B05F@EUSAACMS0703.eamcs.ericsson.se>
	 <1266615434.32011.111.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E316B09C@EUSAACMS0703.eamcs.ericsson.se>
	 <1266847801.15933.33.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E41FF16B@EUSAACMS0703.eamcs.ericsson.se>
	 <1266850844.15933.38.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E41FF364@EUSAACMS0703.eamcs.ericsson.se>
	 <1266861381.15933.48.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F52E41FF477@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain
Date: Mon, 22 Feb 2010 14:37:24 -0500
Message-Id: <1266867444.15933.75.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-02-22 at 14:12 -0500, Alan Rouse wrote:
> Stephen wrote:
> > You need to perform a restorecon -R /dev from /etc/rc.d/rc.sysinit so that the tmpfs /dev mount is properly 
> > labeled.  File a bug against whatever package owns that file in OpenSUSE (in Fedora, it is the initscripts 
> > rpm).
> 
> The scripts are different in suse.  I've placed the restorecon command in /etc/init.d/boot prior to the first mount attempt.  That seems to do the trick -- the denied messages related to tempfs are now gone.
> 
> See attached audit.log from the subsequent boot.

At this point, I think you can take the particular avc messages (split
up by logical grouping, e.g. for each unique scontext=) to the refpolicy
list (refpolicy@oss.tresys.com) and see about getting them resolved
upstream.  There may need to be some suse-specific rules added to the
refpolicy.

In the interim, you can always create a local policy module via
audit2allow to enable your system to work.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
