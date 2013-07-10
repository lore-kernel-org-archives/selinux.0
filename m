From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: fix selinuxfs policy file on big endian systems
Date: Wed, 10 Jul 2013 15:38:06 -0400
Message-Id: <1373485086-6809-1-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The /sys/fs/selinux/policy file is not valid on big endian systems like
ppc64 or s390.  Let's see why:

static int hashtab_cnt(void *key, void *data, void *ptr)
{
	int *cnt = ptr;
	*cnt = *cnt + 1;

	return 0;
}

static int range_write(struct policydb *p, void *fp)
{
	size_t nel;
[...]
	/* count the number of entries in the hashtab */
	nel = 0;
	rc = hashtab_map(p->range_tr, hashtab_cnt, &nel);
	if (rc)
		return rc;
	buf[0] = cpu_to_le32(nel);
	rc = put_entry(buf, sizeof(u32), 1, fp);

So size_t is 64 bits.  But then we pass a pointer to it as we do to
hashtab_cnt.  hashtab_cnt thinks it is a 32 bit int and only deals with
the first 4 bytes.  On x86_64 which is little endian, those first 4
bytes and the least significant, so this works out fine.  On ppc64/s390
those first 4 bytes of memory are the high order bits.  So at the end of
the call to hashtab_map nel has a HUGE number.  But the least
significant 32 bits are all 0's.

We then pass that 64 bit number to cpu_to_le32() which happily truncates
it to a 32 bit number and does endian swapping.  But the low 32 bits are
all 0's.  So no matter how many entries are in the hashtab, big endian
systems always say there are 0 entries because I screwed up the
counting.

The fix is easy.  Use a 32 bit int, as the hashtab_cnt expects, for nel.

Signed-off-by: Eric Paris <eparis@redhat.com>
---
 security/selinux/ss/policydb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index c8adde3..f6195eb 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -3203,9 +3203,8 @@ static int range_write_helper(void *key, void *data, void *ptr)
 
 static int range_write(struct policydb *p, void *fp)
 {
-	size_t nel;
 	__le32 buf[1];
-	int rc;
+	int rc, nel;
 	struct policy_data pd;
 
 	pd.p = p;
-- 
1.8.1.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
