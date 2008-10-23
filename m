Subject: Re: semanage help
From: Stephen Smalley <sds@tycho.nsa.gov>
To: LC Bruzenak <lenny@MagitekLtd.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1224727612.14755.244.camel@homeserver>
References: <1224727612.14755.244.camel@homeserver>
Content-Type: text/plain
Date: Thu, 23 Oct 2008 08:53:22 -0400
Message-Id: <1224766402.28867.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-10-22 at 21:06 -0500, LC Bruzenak wrote:
> - get the file context -
> [root@v1 ~]# semanage fcontext -l | grep prelude_spool
> /var/spool/prelude(/.*)?                           all files          system_u:object_r:prelude_spool_t:s0 
> /var/spool/prelude-manager(/.*)?                   all files          system_u:object_r:prelude_spool_t:s0 
> 
> So it seems that it knows about this path match.
> 
> - set the file range -
> [root@v1 ~]# semanage fcontext -m -r s15:c0.c1023  "/var/spool/prelude(/.*)?"
> /usr/sbin/semanage: File context for /var/spool/prelude(/.*)? is not defined
> 
> [root@v1 ~]# semanage fcontext -m -r s15:c0.c1023 -t prelude_spool_t '/var/spool/prelude(/.*)?'
> /usr/sbin/semanage: File context for /var/spool/prelude(/.*)? is not defined
> 
> Can someone tell me what I'm doing wrong/how to fix?

Looks like it is defined by a policy module, and semanage fcontext -m
can only modify local definitions.

I'd think that you could add a local definition to override it, ala:
/usr/sbin/semanage fcontext -a -t prelude_spool_t -r s15:c0.c1023 '/var/spool/prelude(/.*)?'

but that complains that it already exists.  Maybe it ought to be using
semanage_fcontext_exists_local() instead?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
