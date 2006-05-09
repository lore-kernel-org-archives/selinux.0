Subject: Re: restorecond and security related files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@gentoo.org>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <44608F34.3060907@gentoo.org>
References: <44608F34.3060907@gentoo.org>
Content-Type: text/plain
Date: Tue, 09 May 2006 10:47:49 -0400
Message-Id: <1147186069.32651.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-09 at 08:46 -0400, Joshua Brindle wrote:
> I noticed that /etc/samba/secrets.tdb was added to restorecond.conf. I 
> thought that restorecond was only going to be used for files of low 
> security relevancy? Are type transitions not sufficient in this case? if 
> not smbpasswd should use setfscreatecon() when writing it like passwd 
> does. Also, this doesn't seem to keep /etc/samba/smbpasswd correctly 
> typed or the /etc/samba/smbpasswd.<pid> temp file created when smbpasswd 
> is run.

While I agree that whenever possible we should seek to get the proper
type transitions in place and/or appropriate application modifications,
that doesn't necessarily mean that we can't list such files in
restorecond.conf in order to provide some degree of recovery (albeit
belated) when something steps outside of those transitions or bypasses
that modified code, which will always be possible as long as there are
unconfined_t processes on the system.  Even /etc/shadow is a candidate
there, because you can lose the type on it quite easily on a targeted
policy system, and better to have restorecond at least notice and
restore it belatedly than to never get it fixed at all (until some user
happens to notice or run a relabel).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
