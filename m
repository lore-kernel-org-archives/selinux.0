Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0HIY8Xf006833
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 13:34:09 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0HIY7Rq009700
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 18:34:07 GMT
Subject: Re: latest diff
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43CC6D3C.1060307@redhat.com>
References: <43CC6D3C.1060307@redhat.com>
Content-Type: text/plain
Date: Tue, 17 Jan 2006 13:35:25 -0500
Message-Id: <1137522925.29815.276.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged, with a few notes:

On Mon, 2006-01-16 at 23:06 -0500, Daniel J Walsh wrote:
> Added wine policy to mimic java.
> 
> Do we need one for mono?  Or do we change java policy to 
> unconfined_execmem policy?

It looks like the wine policy falls into this too, which is why I
dropped the wine for now.  It does look like unconfined_execmem is the
right way to go.  My idea is that it should be transparent as much as
possible, like shlib_t/textrel_shlib_t.  So for example, the
unconfined_domtrans() would have the regular transition and a transition
to unconfined_execmem_t.

> Do you have a problem with my range_transition rules?

The auditd one is ok, but I still disagree with the ping one.  I don't
understand why it matters for ping, especially since only files are
handled by MCS.

> +allow system_mail_t eventpollfs_t:file r_file_perms;
> I got bug reports on the above.  I have no idea why.

I put it in, but it would be interesting to find out why.

> I still think running hostname policy for anything other than init and 
> dhcpc is a bad idea.

Agreed.

> +    domain_dontaudit_read_all_domains_state($1)
> was added to unconfined_t to eliminate AVC messages created by running 
> top when logged in on a MCS machine.  If you are running unconfined_t:s0 
> and run top you will not be able to read all the processes running at 
> s0-s0:c0.c255

This is merged too, but its probably useful to put it in an
ifdef(`enable_mcs', since its dontauditing MCS denials.  Might one also
be needed for MLS?

> Do you have a problem with the MLS gen_user stuff?

Theres a few things I'm wrestling with.

1. Do we really want to do this (more identities) for the upstream
policy?
2. Do we want to enable secadm for strict in general or just MLS?
3. The user file already has a large amount ifdefs, which can be
confusing.

The last one isn't really specific to the patch, but its been on my
mind, but as I'm writing this I have an idea how it might be remedied.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
