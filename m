Subject: Re: [RFC PATCH] allow range_transitions and MLS users in modules
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: SELinux List <selinux@tycho.nsa.gov>, Serge Hallyn <serue@us.ibm.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <450EDC2E.50009@trustedcs.com>
References: <450EDC2E.50009@trustedcs.com>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 15:51:36 -0400
Message-Id: <1158954696.3920.144.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-18 at 12:49 -0500, Darrel Goeddel wrote:
> - Add the ability to require MLS sensitivities and categories in policy
>   modules.
> - Remove the restrictions on defining users in MLS-enabled modules.
> - Handle range_trans_rules in modules.
> 
> This all allows range_transition statements to be used in policy modules
> and allows definition of users in MLS policy modules.
> 
> I haven't tested this as much as I would like, but it is working nicely
> for me.  I have built several policies (MLS, non-MLS, strict, targeted,
> etc.) and have built several modules exercising the new functionality.
> I'd appreciate any feedback you may have at this point.

I added a refpolicy branch that should help testing this.  It only has
range_transitions, plus categories and sensitivities in require{} in
modules at the moment.  Since I don't have my own patched toolchain, I
didn't test to see if it actually compiles modular, but it compiled ok
monolithic.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
