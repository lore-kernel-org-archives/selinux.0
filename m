Message-ID: <44D12036.7030601@trustedcs.com>
Date: Wed, 02 Aug 2006 16:59:18 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 2/2] userland support for new range_transition statements
References: <44CA298B.7080706@trustedcs.com>	 <1154438074.23513.30.camel@twoface.columbia.tresys.com>	 <44D0D516.5010906@trustedcs.com> <1154548289.27457.96.camel@localhost.localdomain>
In-Reply-To: <1154548289.27457.96.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Wed, 2006-08-02 at 11:38 -0500, Darrel Goeddel wrote:
> 
>>Joshua Brindle wrote:
>>
>>>On Fri, 2006-07-28 at 11:13 -0400, Darrel Goeddel wrote:
>>>
>>>
>>>>Index: libsepol/include/sepol/policydb/policydb.h
>>>>===================================================================
>>>>--- libsepol/include/sepol/policydb/policydb.h  (revision 38)
>>>>+++ libsepol/include/sepol/policydb/policydb.h  (working copy)
>>>
>>>
>>>>+typedef struct range_trans_rule {
>>>>+       type_set_t stypes;
>>>>+       type_set_t ttypes;
>>>>+       class_perm_node_t *classes;     /* only class is used */
>>>>+       mls_range_t trange;
>>>>+       struct range_trans_rule *next;
>>>>+} range_trans_rule_t;
>>>>+
>>>
>>>
>>>Are we sure that mls_range_t is semantic enough to store the rule, even
>>>in a module situation where all the symbols are not present?
>>
>>Hmmm...  I assume that you have MLS requirements in mind when you say that,
>>especially the '.' notation.  The problem is that if we specify "s4:c0.c12" as
>>the range, how do we know what will be between c0 and c12 (they are arbitrary
>>names).  Are you suggesting possibly storing the string and figuring the whole
>>thing out at expand time?
>>
> 
> 
> Or storing the start and end of the range. This seems analogous to
> attributes to me and we defer interpreting them until expand time.

A level can contain any combination of category ranges and single categories
such as "s3:c0,c4,c10.c20,c24,c30.c38".  It seems like we would need a list of
structs to represent each piece semantically (single cat c0, single cat c4,
range of cats from c10 to c20, ...) - the string seems to do that nicely.  To
use the above level, we would require the sensitivity s3 and the categories
c0, c4, c10, c20, c24, c30, and c38.  At expansion time, the string would tell
us that we really wanted the categories in between c10 and c20, as well as the
categories in between c30 and c38, to be included as well.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
