Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: casey@schaufler-ca.com, russell@coker.com.au, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com
In-Reply-To: <45378681.3000106@redhat.com>
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
	 <45377BF0.6010403@redhat.com>
	 <1161264613.14632.120.camel@moss-spartans.epoch.ncsc.mil>
	 <45378681.3000106@redhat.com>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 10:32:35 -0400
Message-Id: <1161268355.14632.147.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-19 at 10:06 -0400, Daniel J Walsh wrote:
> Stephen Smalley wrote:
> > pam_selinux used to have support to let the user pick from the list of
> > reachable contexts for the user.  So you could just restore that
> > support.
> >   
> I don't think so.  This allowed you to select your TE role, not your 
> Sensitivity.  The problem is selecting your sensivity.  Since there is 
> an large number of sensitivities a user can log in as he will need to 
> key it in.

Ah, I was thinking of the old MLS implementation, pre-TCS.  Fair point.

> > That doesn't address sshd though.  Or gdm.  sshd shouldn't be too
> > difficult.  There were some externally developed gdm patches for selinux
> > that enabled context selection long ago, but nothing recent
> > (pre-Fedora).
> >   
> I though the sshd would happen automatically when you login via a secure 
> channel.  IE If I connect at TopSecret, I get TopSecret.

Only if running it via the modified xinetd and only if using labeled
networking.  Otherwise, you still need a way for users to select a level
for their session.

> I think gdm will require other features such that I launch terminals at 
> different sensitivity levels???

Well, doing that right requires security enhanced X, a modified window
manager, and a trusted path, so that won't be happening today.

> I think we should separate the TE Context selection from the Sensitivity 
> Selection, in order to satisfy the MLS problems.

Ok.

> > You don't need to remove -l from newrole; you can just constrain its use
> > via DAC and via SELinux policy, as Klaus has previously suggested.
> >
> >   
> So it will not work on ptys?  Or are you thinking a boolean? I think it 
> will be strange for a user to have the app work differently depending on 
> how they logged in, but I guess this is another short coming of MLS.

It would be restricted via DAC mode and possibly a boolean in policy,
such that an admin could allow use of it if desired.  Only the LSPP
config would need to lock it down.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
