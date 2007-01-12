Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0CMTCl7003655
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2007 17:29:12 -0500
Received: from web36610.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l0CMU2d4003986
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2007 22:30:02 GMT
Date: Fri, 12 Jan 2007 14:29:52 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1168633787.7993.549.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <360757.85439.qm@web36610.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> An example from the MLS/LSPP world:  a Secret
> process can read an
> Unclassified document and copy it to a Secret
> document, but it cannot
> copy it to an Unclassified document (no write down).
>  But it may very
> well wish to preserve DAC information on the copy.

Well, sort of. That's what actually got
implemented, but if you read the CMW spec
it's clear that what they really wanted was
the copy to remain Unclass until the Secret
user did something to it that would make it
Secret. Any difference in treatment of the
MAC attributes from the DAC atributes is an
artifact of implementation, not an intention
of design. The traditional rule that mv
maintains attributes while cp use what the
current process would do holds with (most)
MAC systems.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
