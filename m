Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1KGESKY030696
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 11:14:28 -0500
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1KGEQBs029320
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2008 16:14:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: =?iso-8859-2?q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
Subject: Re: refpolicy: patch for Debian backup cron daily jobs
Date: Thu, 21 Feb 2008 03:13:48 +1100
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
References: <20080219122951.GA23700@bobek.pm.i.cz> <200802202224.48452.russell@coker.com.au> <20080220154140.GA9839@bobek.pm.i.cz>
In-Reply-To: <20080220154140.GA9839@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200802210313.50682.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 21 February 2008 02:41, Václav Ovsík <vaclav.ovsik@i.cz> wrote:
> > I wrote the policy for backup_t as a domain for anything the sys-admin
> > might run at the command-line for the purpose of backing things up.  For
> > me it's LVM snapshots that are copied (via dd or gzip) to a USB device. 
> > Nothing Debian specific there, and I've run it on a few Fedora machines
> > too.
>
> This was really Debian-specific - cron jobs doing a local backup into
> /var/backup...

backup_store_t might be Debian specific at the moment (but could be used for 
other things), executing a shell script to perform the backup is quite 
generic.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
