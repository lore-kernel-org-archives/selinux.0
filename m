Subject: Re: [RFC PATCH] allow range_transitions and MLS users in modules
From: Joshua Brindle <jbrindle@tresys.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: SELinux List <selinux@tycho.nsa.gov>, Serge Hallyn <serue@us.ibm.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <450EDC2E.50009@trustedcs.com>
References: <450EDC2E.50009@trustedcs.com>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 14:01:20 -0400
Message-Id: <1158602480.3056.12.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-18 at 13:49 -0400, Darrel Goeddel wrote:
> - Add the ability to require MLS sensitivities and categories in
> policy
>   modules.
> - Remove the restrictions on defining users in MLS-enabled modules.
> - Handle range_trans_rules in modules.
> 
> This all allows range_transition statements to be used in policy
> modules
> and allows definition of users in MLS policy modules.
> 
> I haven't tested this as much as I would like, but it is working
> nicely
> for me.  I have built several policies (MLS, non-MLS, strict,
> targeted,
> etc.) and have built several modules exercising the new functionality.
> I'd appreciate any feedback you may have at this point.
> 
what is the syntax for requiring levels? Got a sample module we can try?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
