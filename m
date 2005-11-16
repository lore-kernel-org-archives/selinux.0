Subject: Re: [ SEMANAGE ] Clear obsoleted objects
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <437A7AD5.6040500@cornell.edu>
References: <437A7AD5.6040500@cornell.edu>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 09:18:59 -0500
Message-Id: <1132150739.3425.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-15 at 19:18 -0500, Ivan Gyurdiev wrote:
> Get from here:
> Preparing...                ########################################### 
> [100%]
>    1:selinux-policy-targeted########################################### 
> [100%]
> Attempting to install base module '/usr/share/selinux/targeted/base.pp':
> Ok: return value of 0.
> Committing changes:
> libsepol.bool_update: boolean i18n_input_disable_trans no longer in policy
> libsepol.bool_update: could not update boolean i18n_input_disable_trans
> libsepol.sepol_bool_set: could not set boolean i18n_input_disable_trans
> libsemanage.dbase_policydb_set: could not set record value
> libsemanage.dbase_file_iterate: could not iterate over records
> libsemanage.semanage_base_merge_components: could not merge local 
> modifications into policy
> libsemanage.semanage_expand_sandbox: Unable to merge local modifications 
> into policy.
> Failed!
> 
> to here:
> 
> Preparing...                ########################################### 
> [100%]
>    1:selinux-policy-targeted########################################### 
> [100%]
> Attempting to install base module '/usr/share/selinux/targeted/base.pp':
> Ok: return value of 0.
> Committing changes:
> Ok: transaction number 0.
> 
> I really need to add some functions to the rtable that print out each 
> object (in a more sensible format than the one that's written to the 
> storage file), so we can report to the user what's being 
> obsoleted/changed - note that there's no messages in policy_components.c 
> for that reason. The TODO is related to "make libsemanage less verbose".

Thanks, merged as of libsemanage 1.3.55.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
