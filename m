Subject: Re: [PATCH take 3] allow range_transitions and MLS users in modules
From: Joshua Brindle <jbrindle@tresys.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        Christopher PeBenito <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <4519681B.7080107@trustedcs.com>
References: <450EDC2E.50009@trustedcs.com>  <4519681B.7080107@trustedcs.com>
Content-Type: text/plain
Date: Thu, 28 Sep 2006 08:20:58 -0400
Message-Id: <1159446058.10903.0.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-26 at 12:49 -0500, Darrel Goeddel wrote:
> - Add the ability to require MLS sensitivities and categories in policy
> modules.
> - Remove the restrictions on defining users in MLS-enabled modules.
> - Handle range_trans_rules in modules.
> - Cleanup some uses of calloc/memset
> 
> This all allows range_transition statements to be used in policy modules
> and allows definition of users in MLS policy modules.
> 
> ---
> 
> New and improved!  Now with less calloc()s/memset()s.

Thanks, merged as of checkpolicy 1.30.12 and libsepol 1.12.27


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
