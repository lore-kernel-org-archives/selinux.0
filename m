Subject: Re: [SEMANAGE] [SETSEBOOL] Clone record on set/add/modify
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43BBD6C0.6020108@cornell.edu>
References: <43BBD6C0.6020108@cornell.edu>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 12:29:45 -0500
Message-Id: <1136395785.27632.272.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-01-04 at 09:08 -0500, Ivan Gyurdiev wrote:
> Hi, Steven pointed out (off-list) that libsemanage vs libsepol behavior 
> is inconsistent with respect to set/add/modify.
> In libsemanage, the object being added becomes "managed" by the library, 
> while this is not true in libsepol. We decided it was better to have the 
> client control the object passed in, and be responsible for freeing it.
> 
> This patch makes the appropriate changes (which include reversal of some 
> of the code from the other patches) to implement that.
> It also includes a bugfix for the error path of 
> database_policydb.c:list, pointed out by Russel Coker.

Thanks, your entire patch series has been merged as of libsepol 1.11.2,
libsemanage 1.5.4, and policycoreutils 1.29.3.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
