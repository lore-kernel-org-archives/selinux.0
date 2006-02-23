Message-ID: <43FE45DE.1060503@trustedcs.com>
Date: Thu, 23 Feb 2006 17:31:42 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@namei.org>, Amy Griffis <amy.griffis@hp.com>,
        Dustin Kirkland <dustin.kirkland@us.ibm.com>,
        Linux Audit Discussion <linux-audit@redhat.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Steve Grubb <sgrubb@redhat.com>
Subject: Re: [PATCH] context based audit filtering (take 3)
References: <43F49805.2000109@trustedcs.com>	 <43FB86DD.2020708@trustedcs.com>  <43FBA962.5090904@trustedcs.com> <1140620332.31467.226.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1140620332.31467.226.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2006-02-21 at 17:59 -0600, Darrel Goeddel wrote:
> 
>>The updated version of Dustin's patch I referred to is below.  The changes are
>>are follows:
>>
>>- printk a warning and ignore invalid selinux rules (but still hang on to them
>>  so they may be activated with a later policy reload).
> 
> 
> Should this be a printk or an audit_log call?

Steve G had suggested syslogging it, so I went with the printk.  What would
be more noticeable?

>>@@ -370,6 +410,14 @@ static int audit_compare_rule(struct aud
>> 			if (audit_compare_watch(a->watch, b->watch))
>> 				return 1;
>> 			break;
>>+		case AUDIT_SE_USER:
>>+		case AUDIT_SE_ROLE:
>>+		case AUDIT_SE_TYPE:
>>+		case AUDIT_SE_SEN:
>>+		case AUDIT_SE_CLR:
>>+			if (strcmp(a->fields[i].se_str, b->fields[i].se_str))
>>+				return 1;
>>+			break;
> 
> 
> Do you want to catch aliases here?  If so, you need to have SELinux look
> up the strings and compare the actual values.  But possibly that isn't
> critical for the purposes of just preventing duplicate filters.

I like treating them separately because the are conceptually different to the
creator of the audit rules.  If X and Y are both types in the policy, then we
should be able to define rules based on them.  And yes... this kinda goes back
to keeping rules around even if they are currently invalid (or aliases).
Lets say that the current policy has X aliased to Y, and a ploicy reload
results in X and Y being distinct types - I think the audit rules should be in
there for X and Y.

If we do away with the idea of invalid (or aliased) rules around, we could add
in a comparator function for selinux, but I think we are fine the way it is.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
