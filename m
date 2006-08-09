Message-ID: <44D9F166.4060103@trustedcs.com>
Date: Wed, 09 Aug 2006 09:29:58 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 2/2 take 2] userland support for new range_transition
 statements
References: <6FE441CD9F0C0C479F2D88F959B0158832AE65@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158832AE65@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
>>From: Darrel Goeddel [mailto:dgoeddel@trustedcs.com] 
>>
> 
> 
> Sorry it took so long to reply to this.
> 
> 
>> for module policy versions up to 6, there are no 
>>range_transitions  for base policy versions 6 and up, an 
> 
> 
> This is only per the grammar right? You are writing range_trans_rule_t's
> in every avrule block so version 6 does support them, just not the
> grammar yet.

Yes, the module format version 6 does include range_trans_t's, it just writes
0 rules because there is no way to specify them.

>> #if 0
>>@@ -307,6 +326,32 @@
>> 	}
>> }
>> 
>>+void range_trans_rule_init(range_trans_rule_t *x) {
>>+	type_set_init(&x->stypes);
>>+	type_set_init(&x->ttypes);
>>+	ebitmap_init(&x->tclasses);
>>+	mls_range_init(&x->trange);
>>+}
> 
> 
> x->next = NULL? 

D'oh.  Will initialize...

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
