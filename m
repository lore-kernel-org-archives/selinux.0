Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4VBt8xN009663
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2012 07:55:09 -0400
Message-ID: <4FC75C0E.7040709@tresys.com>
Date: Thu, 31 May 2012 07:54:54 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
CC: <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] Add SELinux policy capability for always checking
 packet class.
References: <1338384128-14144-1-git-send-email-cpebenito@tresys.com> <16326289.E5RbHv6gkl@sifl>
In-Reply-To: <16326289.E5RbHv6gkl@sifl>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/30/12 10:30, Paul Moore wrote:
> On Wednesday, May 30, 2012 09:22:08 AM Chris PeBenito wrote:
>> Currently the packet class in SELinux is not checked if there are no
>> SECMARK rules in the security or mangle netfilter tables.  Some systems
>> prefer that packets are always checked, for example, to protect the system
>> should the netfilter rules fail to load or if the nefilter rules
>> were maliciously flushed.
>>
>> Add the always_check_packets policy capability which, when enabled, treats
>> SECMARK as enabled, even if there are no netfilter SECMARK rules.
> 
> I'm against committing this patch without some matching mechanism to 
> incorporate the secmark labeling configuration in the greater SELinux policy.  
> I explained why roughly 87 times in the previous RFC email thread started by 
> Chris so I'll save us all some time and not repeat it here.
> 
> Ignoring my own objections for a moment and glancing at the patch, I see that 
> it is incomplete/incorrect as it does not include support for the network peer 
> labels.  See the original RFC email thread.

The question is if they should be tied to the same policy capability.  If so, this capability should be renamed.  If not, the patch is fine, as I can just as easily send a second patch.  I'm undecided if they should be tied together.

>> Signed-off-by: Chris PeBenito <cpebenito@tresys.com>
>> ---
>>  security/selinux/hooks.c            |    8 ++++++--
>>  security/selinux/include/security.h |    2 ++
>>  security/selinux/selinuxfs.c        |    3 ++-
>>  security/selinux/ss/services.c      |    3 +++
>>  4 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index fa2341b..b818b2d 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -137,12 +137,16 @@ static struct kmem_cache *sel_inode_cache;
>>   * This function checks the SECMARK reference counter to see if any SECMARK
>> * targets are currently configured, if the reference counter is greater
>> than * zero SECMARK is considered to be enabled.  Returns true (1) if
>> SECMARK is - * enabled, false (0) if SECMARK is disabled.
>> + * enabled, false (0) if SECMARK is disabled.  If the always_check_packets
>> + * policy capability is enabled, SECMARK is always considered enabled.
>>   *
>>   */
>>  static int selinux_secmark_enabled(void)
>>  {
>> -	return (atomic_read(&selinux_secmark_refcount) > 0);
>> +	if (selinux_policycap_alwayspacket)
>> +		return 1;
>> +	else
>> +		return (atomic_read(&selinux_secmark_refcount) > 0);
>>  }
>>
>>  /*
>> diff --git a/security/selinux/include/security.h
>> b/security/selinux/include/security.h index dde2005..ff1b0b8 100644
>> --- a/security/selinux/include/security.h
>> +++ b/security/selinux/include/security.h
>> @@ -68,12 +68,14 @@ extern int selinux_enabled;
>>  enum {
>>  	POLICYDB_CAPABILITY_NETPEER,
>>  	POLICYDB_CAPABILITY_OPENPERM,
>> +	POLICYDB_CAPABILITY_ALWAYSPACKET,
>>  	__POLICYDB_CAPABILITY_MAX
>>  };
>>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
>>
>>  extern int selinux_policycap_netpeer;
>>  extern int selinux_policycap_openperm;
>> +extern int selinux_policycap_alwayspacket;
>>
>>  /*
>>   * type_datum properties
>> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
>> index 4e93f9e..4a593d0 100644
>> --- a/security/selinux/selinuxfs.c
>> +++ b/security/selinux/selinuxfs.c
>> @@ -44,7 +44,8 @@
>>  /* Policy capability filenames */
>>  static char *policycap_names[] = {
>>  	"network_peer_controls",
>> -	"open_perms"
>> +	"open_perms",
>> +	"always_check_packets"
>>  };
>>
>>  unsigned int selinux_checkreqprot =
>> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE; diff --git
>> a/security/selinux/ss/services.c b/security/selinux/ss/services.c index
>> 4321b8f..d81438a 100644
>> --- a/security/selinux/ss/services.c
>> +++ b/security/selinux/ss/services.c
>> @@ -72,6 +72,7 @@
>>
>>  int selinux_policycap_netpeer;
>>  int selinux_policycap_openperm;
>> +int selinux_policycap_alwayspacket;
>>
>>  static DEFINE_RWLOCK(policy_rwlock);
>>
>> @@ -1812,6 +1813,8 @@ static void security_load_policycaps(void)
>>  						  POLICYDB_CAPABILITY_NETPEER);
>>  	selinux_policycap_openperm = ebitmap_get_bit(&policydb.policycaps,
>>  						  POLICYDB_CAPABILITY_OPENPERM);
>> +	selinux_policycap_alwayspacket = ebitmap_get_bit(&policydb.policycaps,
>> +						  POLICYDB_CAPABILITY_ALWAYSPACKET);
>>  }
>>
>>  static int security_preserve_bools(struct policydb *p);


-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
