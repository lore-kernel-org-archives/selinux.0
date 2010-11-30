Subject: Re: analysing optional policy
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <201011262055.01924.russell@coker.com.au>
References: <201011262055.01924.russell@coker.com.au>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Nov 2010 10:36:14 -0500
Message-ID: <1291131374.1328.25.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-11-26 at 20:55 +1100, Russell Coker wrote:
> I'm having a problem with optional policy not being used when I think it 
> should.
> 
> Is it possible to use apol to get information on optional policy for .pp files 
> so I can try to work out why it doesn't get enabled?
> 
>                 unconfined_run_to(depmod_t, depmod_exec_t)
> 
> In the Debian policy I have the above in an optional section of base.pp but 
> for reasons that I don't understand it's not being loaded (both tests and 
> running apol on policy.24 show this).
> 
> I've inspected the contents of base.conf and they appear to be OK.
> 
> Any suggestions of other tools to analyse this will be appreciated.
> 

Is this with the policy found in
selinux-policy-src_0.2.20100524-4_all.deb?  I don't see
unconfined_run_to being used in that policy.

It looks like modutils is part of base, so depmod_t and depmod_exec_t
should be defined.  But there is a requires statement at the top of
modutils for "bool secure_mode_insmod".  Is secure_mode_insmod in the
policy?

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
