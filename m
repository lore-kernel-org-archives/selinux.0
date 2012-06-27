Message-ID: <1340796503.32737.8.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: strange labelling error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
Date: Wed, 27 Jun 2012 07:28:23 -0400
In-Reply-To: <201206272046.27259.russell@coker.com.au>
References: <201206270101.42198.russell@coker.com.au>
	 <1340724362.29157.47.camel@moss-pluto.epoch.ncsc.mil>
	 <201206272046.27259.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-06-27 at 20:46 +1000, Russell Coker wrote:
> On Wed, 27 Jun 2012, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > A domain with :capability2 mac_admin permission could set any arbitrary
> > value as a file security context, so it would just require a program in
> > such a domain (or perhaps any root program in permissive mode) to
> > accidentally pass the translated security context to setxattr or
> > possibly even to setfilecon if mcstrans wasn't running.
> 
> Thanks for that tip, I've just seen it happen when upgrading a system.  It 
> seems that dpkg converted "s0" to "SystemLow" when mcstransd was running, then 
> stopped mcstransd (as part of an upgrade process) and couldn't convert it back 
> to s0.  Now I have to work out why it did such a conversion.  The 
> file_contexts file uses the computer-friendly version of the range so there 
> shouldn't be a need for any conversion.
> 
> I don't like my chances of getting a dpkg patch in Wheezy, changing the most 
> important package in a distribution 3 days before a freeze is asking a lot.  I 
> will probably have to maintain a forked package in my own repository and hope 
> that I can get a change in the first update for Wheezy.
> 
> Below is one of the audit messages that were generated.
> 
> type=AVC msg=audit(1340784425.654:1271): avc:  denied  { mac_admin } for  
> pid=6276 comm="dpkg" capability=33  
> scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 
> tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 
> tclass=capability2
> 
> Hopefully I will have solved this in a few hours and posted the answer to the 
> list.

If dpkg uses the regular libselinux interfaces rather than the _raw()
interfaces, it will get the translated context as long as mcstrans is
running.  rpm and setfiles use selabel_lookup_raw() and
lgetfilecon_raw() to avoid such issues.

If dpkg was denied mac_admin, then the setfilecon/setxattr should have
failed unless the system was in permissive mode.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
