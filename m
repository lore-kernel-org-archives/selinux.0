Subject: Re: [ SEMANAGE ] Stub out user/port functionality
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, dwalsh@redhat.com,
   jbrindle@tresys.com
In-Reply-To: <43256F48.7060909@cornell.edu>
References: <43256F48.7060909@cornell.edu>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 11:45:29 -0400
Message-Id: <1126712729.12299.97.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-09-12 at 08:06 -0400, Ivan Gyurdiev wrote:
> The attached patch for libsemanage stubs out the functionality for managing
> user and port records. This means simply editing the config files...
> As discussed with Joshua, loading the users and ports into policy needs
> to be accomplished at commit time, after linking in modules.
> 
> I'm still not entirely clear how all the pieces will fit together, but
> I think it would be good to merge a stubbed-out skeleton...later we could
> change it to make use of the planned semanage_handle_t.
> 
> The second patch fixes sepol headers to include stddef.h whenever size_t 
> is used.

Thanks, merged upstream.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
