Subject: Re: How can modular policy ever have worked? [patch]
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Erich Schubert <erich@debian.org>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1142867787.6145.18.camel@wintermute.xmldesign.de>
References: <1142691657.4017.23.camel@wintermute.xmldesign.de>
	 <1142865553.16487.21.camel@moss-spartans.epoch.ncsc.mil>
	 <1142867787.6145.18.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 11:00:55 -0500
Message-Id: <1142870455.16487.68.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-03-20 at 16:16 +0100, Erich Schubert wrote:
> No. A strace shows that load_policy is writing data to the load
> interface,
> which results in this invalid argument error:
> open("/selinux/load", O_RDWR|O_LARGEFILE) = 4
> write(4, "\214\377|\371\10\0\0\0SE Linux\24\0\0\0\1\0\0\0\10\0\0"...,
> 592395) = -1 EINVAL (Invalid argument)

Odd.  Send me a copy of the generated policy.20 file privately or put it
up on a public site where it can be downloaded, please.

> Any progress on the optional{} in base.pp issues?
> I have the impression that type attributes are broken; for example
> almost all (I can't say for sure, apol doesn't work for me; is there any
> other "policy decompiler"?)

Hmmm...I thought optionals in base was fixed in the current version.
checkpolicy/test has a crude dispol program for dumping a binary policy.
Reported your problem with apol yet?  sediff is useful for comparing two
policies, e.g. a monolithic build against a linked one from a modular
build.

>  the restorecon_t relabelto rules are
> missing, which are defined for file_type.
> So I have the impression that when linking the base policy with
> optionals, these attributes are messed up.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
