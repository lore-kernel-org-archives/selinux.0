Subject: Re: [PATCH] audit validatetrans denials
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "'SELinux List'" <SELinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <4213C115.3030703@trustedcs.com>
References: <4213C115.3030703@trustedcs.com>
Content-Type: text/plain
Message-Id: <1108647155.24494.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 17 Feb 2005 08:32:35 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-16 at 16:54, Darrel Goeddel wrote:
> Attached is a patch that adds the auditing of denials caused by the 
> validatetrans rules in the policy.  Look good?

I'd rather do this the same way as compute_sid_handle_invalid_context(),
i.e. generate the context strings up front using
context_struct_to_string() after looking up the SIDs, use
policydb.p_class_val_to_name[tclass-1] to lookup the class name, and
perform a single audit_log() call.  Since you are already within the
security server at this point, you don't have to do it in the same
manner as the AVC.  And you already log error messages on any invalid
SIDs or classes (in which case you aren't going to be able to look them
up anyway).  So I think you just want to call a similar helper as
compute_sid_handle_invalid_context() in the case where
constraint_expr_eval() fails.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
