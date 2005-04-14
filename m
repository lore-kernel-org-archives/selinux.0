Date: Thu, 14 Apr 2005 23:52:07 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul.moore@hp.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
Subject: Re: You mentioned somewhere there is a step by step guide	to	getting the MLS policy installed on a machine?
Message-ID: <20050414225207.GA9016@lkcl.net>
References: <41EC4682.8050807@trustedcs.com> <41F6D30D.9070904@trustedcs.com> <1106771757.23386.348.camel@moss-spartans.epoch.ncsc.mil> <42408CAB.4030007@redhat.com> <1111583468.21107.15.camel@moss-spartans.epoch.ncsc.mil> <424175DA.9040804@redhat.com> <1111586615.21107.60.camel@moss-spartans.epoch.ncsc.mil> <425ED188.3020008@hp.com> <1113511093.2123.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1113511093.2123.74.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 14, 2005 at 04:38:13PM -0400, Stephen Smalley wrote:

> 3) Rather than immediately booting the MLS-enabled kernel into multi-
> user mode, you should instead boot with enforcing=0 single to fix up the
> context on /etc/mtab, which is re-created by the shutdown while you were
> still running with selinux=0.  You can run /sbin/restorecon /etc/mtab
> from single-user mode, then /usr/sbin/setenforce 1 and exit the single-
> user shell to come up multi-user.

 /etc/mtab is/was an issue (not in MLS) iirc with debian - it
 was the cause of much grief - esp. when a program didn't exit
 at shutdown, locked the partition (e.g. /usr), caused umount
 to fail, cascade-caused /etc/mtab to not be updated, there's
 a bug in /etc/init.d/mountvirtfs.sh where it incorrectly
 detect(s/ed?) that /etc/mtab wasn't writeable, cascade-caused
 mountvirtfs.sh to think that /usr was still mounted read-write
 from the prior shutdown, and it went pear-shaped from there.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
