Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l34E4uuI009293
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2007 10:04:56 -0400
Received: from web86911.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l34E4rkm003157
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2007 14:04:54 GMT
Date: Wed, 4 Apr 2007 14:04:42 +0000 (GMT)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Re: Identification of Attribute values within the Security Server
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Message-ID: <648688.56539.qm@web86911.mail.ukl.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,



>Correct; attributes are expanded to their type sets when the policy is
>generated (at expand time for modular policy).  Originally this was
>always done and attributes were completely discarded from the policy at
>that time; later support was added for preserving allow rules based on
>attributes as a more compact representation, which is why there is now a
>type_attr_map in the policydb, but this is only used for avtab lookups
>by compute_av, not by the constraint evaluator.

Thanks,

Regarding the "security_compute_av", this function is only called if there is a cache miss i.e. (within the avc_perm_noaudit)

           if (!node) {
               rcu_read_unlock();
                     rc = security_compute_av(ssid,tsid,tclass,requested,&entry.avd);
                     if (rc)
                             goto out;
                     rcu_read_lock();
                     node = avc_insert(ssid,tsid,tclass,&entry);
         }

am i right?, but i had one question regarding the "struct av_decision *avd" that why avd->allowed is > 1 and avd -> seqno = 1 or 2 or 3 or .., Does avd->allowed mean that the access is allowed, but then what does avd->seqno mean? Is it a sequence number of type of thing.

the type of avd->allowed is u32, and it continues to grow, does this mean that how many access allowed decisions, the security server have already taken?. And further, does the negative values for all other variables mean simply, not active.

Usually, the avd is a pointer variable, in almost all the function calls, whose value is populated in appropriate methods. But final deciding point was not clear to me, that where SELinux hands, its decision to Linux DAC about its security policy. Does fs/namei.c/permission(), where SELinux is handing over its decision, or there are other points as well.


Thank You,
JG


		
___________________________________________________________ 
All New Yahoo! Mail – Tired of unwanted email come-ons? Let our SpamGuard protect you. http://uk.docs.yahoo.com/nowyoucan.html


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
