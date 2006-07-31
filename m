Message-ID: <44CE4B34.8060101@trustedcs.com>
Date: Mon, 31 Jul 2006 13:25:56 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "'SELinux List'" <SELinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH 2/2] userland support for new range_transition	statements
References: <44CA298B.7080706@trustedcs.com> <1154364031.1447.127.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1154364031.1447.127.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>>+static int range_trans_rule_read(range_trans_rule_t **r, struct policy_file *fp)
>>+{
>>+	uint32_t *buf, nel, nclass;
>>+	unsigned int i, j;
>>+	range_trans_rule_t *rt, *lrt = NULL;
>>+	class_perm_node_t *cp, *lcp = NULL;
>>+
>>+	buf = next_entry(fp, sizeof(uint32_t));
>>+	if (!buf)
>>+		return -1;
>>+	nel = le32_to_cpu(buf[0]);
>>+	for (i = 0; i < nel; i++) {
>>+		rt = malloc(sizeof(range_trans_rule_t));
>>+		if (!rt) {
>>+			return -1;
>>+		}
>>+		range_trans_rule_init(rt);
>>+
>>+		if (type_set_read(&rt->stypes, fp))
>>+			return -1;
> 
> 
> Leaks rt.  I'd suggest linking rt into the list earlier as we do
> elsewhere, so that it can be freed upon policydb_destroy.

<snip - more error path fixups >

>>+						return -1;
>>+					}
>>+					memset(rt, 0, sizeof(range_trans_t));
>>+					rt->source_type = i + 1;
>>+					rt->target_type = j + 1;
>>+					rt->target_class = cp->class;
>>+					if (mls_range_cpy(&rt->target_range, &rule->trange)) {
>>+						ERR(state->handle, "Out of memory!");
> 
> 
> Leaks stypes, ttypes, and rt.

Thanks for catching those - I knew there was something else I needed to do ;)
I'll have to look at the code I modeled those functions after to see if they
have the same issues...  I'll post a new version of this patch (I'll wait a
bit to see if there is other feedback) later.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
