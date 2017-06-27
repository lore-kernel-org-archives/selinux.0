From: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: russell@coker.com.au
Cc: Laurent Bigonville <bigon@debian.org>, selinux <selinux@tycho.nsa.gov>,
 863187-forwarded@bugs.debian.org
Subject: Re: run_init messes up terminal settings
Date: Wed, 28 Jun 2017 00:05:44 +1000
Message-ID: <10484288.3CQNiTDCeZ@russell.coker.com.au>
In-Reply-To: <1498490551.13301.16.camel@tycho.nsa.gov>
References: <f19a1c21-5c15-cb56-9e55-08df2f66429a@debian.org>
 <d5e647e7-8767-b176-e769-6a50de234af2@debian.org>
 <1498490551.13301.16.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Monday, 26 June 2017 11:22:31 AM AEST Stephen Smalley wrote:
> I'd be inclined to just drop open_init_pty (for that matter, I'd like
> to deprecate/drop run_init entirely, but I guess it might be needed if
> not using DIRECT_INITRC=y and not using systemd).

Currently for my use (which involves more strict configurations than most 
Debian users have) the only use of run_init is for running newaliases on a 
Postfix system and for any dpkg commands relating to Postfix (which end up 
running newaliases in the postinst).

The alternative to this is to allow sendmail when run from an unconfined_t or 
sysadm_t shell the ability to write to etc_aliases_t.

Given the problems with run_init and the lack of use of it it seems that 
changing the policy to give slightly more access to sendmail would make sense.

Currently we have user_mail_t as the domain for sendmail when run from 
unconfined_t and user_t.  We need to either have separate domains for this or 
rely on constraints to prevent a user_r session from writing to etc_aliases_t.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
