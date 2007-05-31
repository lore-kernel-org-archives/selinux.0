Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4VGEwhR016721
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 12:14:58 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4VGEvdA021960
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 16:14:57 GMT
Received: by an-out-0708.google.com with SMTP id c38so96080ana
        for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 09:14:56 -0700 (PDT)
Message-ID: <9d1b82480705310914l338e5b1dobb39452d9dc8e905@mail.gmail.com>
Date: Thu, 31 May 2007 21:44:55 +0530
From: Pravin <shindepravin@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: [RFC] Patch for using SELinux to stop DoS attack
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

We have experimented stoping host level DoS attacks using SELinux.
I was hoping to seek some feedback regarding the same.

We added rate controlling machanism to selinux so that
host based DoS attacks can be stopped.
It fundamentally makes sure that the rate at which SELinux is getting
Access control request for perticular (subject, object, action) tuple,
shouldn't cross specified  frequency for specified timeslot.

SELinux access control decisions are based on (subject, object, action)  tupple.
we added one more object to this tuple, called as
maximum_frequency_allowed per time_slot.

Every request for any (subject, object, action) to selinux will
increase their frequency for current time slot,
and when they cross maximum_frequency_allowed per timeslot, access
will be denied from that point onwards for remaining of that timeslot.

To implement this,
we modifed "av_decision" structure in "security.h"  to have variable
max_frequency_allowed added to it.
We have also modified "context_struct_compute_av" function in
"ss/services.c" to assign value to "avd->max_frequency_allowed" for
given (sid, tid, tclass).
This value of max_frequency_allowed  is determined by policies which
specify the maximum frequency for given (sid, tid, tclass).

To compute current access frequency for given (sid, tid, tclass) at
current timeslot,
we have modified "avc_entry" structure in "avc.c" file, to add
variables for current_frequency, last_time_accessed.
Function "avc_has_perm_noaudit" is modified to
 1. Check if it is still in timeslot
 2. increment current_frequency for given tuple of (sid, tid, tclass)
 3. Deny the access if current_frequency is crossing max_frequency_allowed.

Currently the policies which decides what is max_frequency_allowed for
given pair of (sid, tid, tclass) are are in very simple format.
These policies are maintained seperately, and are not mixed with
selinux policies.

The appropriate value of max_frequency_allowed for any pair of (sid,
tid, tclass) can be find out by, first observing the system in
permissive mode, and getting the average frequency values.

We used this modified SELinux to detect and stop "syn flood" attacks
and "infinite fork" problem in experimental environment. And we got
some success in it.
But we have not got any chance to test it against real production
machine with real attack.

Following are the problems that we are facing in this idea.

1. Currently the rate control rules are directly kept in kernel, we
want to read them from file, but opening and reading from file from
within kernel is little difficult, and we are still struggling with
it.
2. We dont have any effective way to deal with false positive. We tried
We want to use exponential smoothing with limited success. But kernel
is giving some trubbles with floating point calculation
3. We dont know what will be correct timeslot to be used.
4. We dont have any proper way to determine the correct value of
max_frequency_allowed for given pair (sid, tid, tclass)
5. This is not a fullproof system as there are many things missing.

Here, I am giving the patch for linux-2.6.21 kernel.
Looking forword for some feedback on this.
Regards,
Pravin Shinde


diff -uNr linux-2.6.21.orig/security/selinux/avc.c
linux-2.6.21_selinux_rate_control/security/selinux/avc.c
--- linux-2.6.21.orig/security/selinux/avc.c	2007-04-26 08:38:32.000000000 +0530
+++ linux-2.6.21_selinux_rate_control/security/selinux/avc.c	2007-05-31
21:26:33.000000000 +0530
@@ -32,6 +32,21 @@
 #include "avc.h"
 #include "avc_ss.h"

+#ifdef SELINUX_RATE_CONTROL
+
+// ALPHA is used for exponential smoothing
+// Ideally value should be 0.7 or 0.8
+// but kernel is creating problems when it becomes floating point value :-(
+// So, i have made it 1
+#define ALPHA 1
+
+// This is the fixed time slot used.
+// Value of this  time slot can be changed as per need.
+#define TIME_SLOT 100
+
+#endif // SELINUX_RATE_CONTROL
+
+
 static const struct av_perm_to_string av_perm_to_string[] = {
 #define S_(c, v, s) { c, v, s },
 #include "av_perm_to_string.h"
@@ -87,6 +102,13 @@
 	u16			tclass;
 	struct av_decision	avd;
 	atomic_t		used;	/* used recently */
+#ifdef SELINUX_RATE_CONTROL
+	//  Added variables
+	unsigned long		time_slot_begining_pr ; // time when this timeslot started
+	unsigned long		last_time_used_pr ; // Time when this avc_entry was
last accessed
+	u32 			avg_freq_pr ; // Expoentially smoothen average access frequency
+	u32			curr_freq_pr ; // Frequency of current timeslot
+#endif //  SELINUX_RATE_CONTROL
 };

 struct avc_node {
@@ -852,6 +874,11 @@
 	int rc = 0;
 	u32 denied;

+#ifdef SELINUX_RATE_CONTROL
+	// flag saying that maximum frequency is crossed or not.
+	int frequency_exceed = 0 ;
+#endif // SELINUX_RATE_CONTROL
+
 	rcu_read_lock();

 	node = avc_lookup(ssid, tsid, tclass, requested);
@@ -861,9 +888,55 @@
 		if (rc)
 			goto out;
 		rcu_read_lock();
+
+#ifdef SELINUX_RATE_CONTROL
+		// if there is some limit specified in rate_controlling rules for
this (ssid, tsid and tclass) then
+		// initiazize the basic variables
+		if(entry.avd.max_freq_pr != 0)
+		{
+			entry.time_slot_begining_pr = jiffies;
+			entry.last_time_used_pr = jiffies ;
+			entry.avg_freq_pr = 0 ;
+			entry.curr_freq_pr = 0 ;
+		}
+#endif // SELINUX_RATE_CONTROL
+
 		node = avc_insert(ssid,tsid,tclass,&entry);
 	}

+
+#ifdef SELINUX_RATE_CONTROL
+	// If there is any rule specified for this (ssid, tsid and tclass) then
+	if(node->ae.avd.max_freq_pr != 0)
+	{
+		// if time-slot is over then,
+		if((jiffies-node->ae.time_slot_begining_pr) > TIME_SLOT)
+		{
+			node->ae.time_slot_begining_pr = jiffies;
+			node->ae.last_time_used_pr = jiffies ;
+			// calculating moving average for frequencies.
+			// here if ALPHA is 1 so, avg_freq_pr will be effectively
curr_freq_pr only :-(
+			node->ae.avg_freq_pr = (node->ae.avg_freq_pr * (1-ALPHA)) + (ALPHA
* node->ae.curr_freq_pr);
+			node->ae.curr_freq_pr=0;
+			if(node->ae.avg_freq_pr > node->ae.avd.max_freq_pr)
+			{
+				frequency_exceed = 1;
+				printk (KERN_INFO "SELINUX_RATE_CONTROL: (sid %u, tid %u, tclass
%u) frequency %u exceeds limit %u\n", ssid, tsid, tclass,
node->ae.avg_freq_pr, node->ae.avd.max_freq_pr );
+			}
+		}	
+		else
+		{ // time slot is not over yet, then
+			node->ae.last_time_used_pr = jiffies ;
+			if ((node->ae.curr_freq_pr >= node->ae.avd.max_freq_pr) &&
(node->ae.avg_freq_pr >= node->ae.avd.max_freq_pr))
+			{
+				frequency_exceed = 1;
+				printk (KERN_INFO "SELINUX_RATE_CONTROL:* (sid %u, tid %u, tclass
%u) frequency %u exceeds limit %u\n", ssid, tsid, tclass,
node->ae.avg_freq_pr, node->ae.avd.max_freq_pr );
+			}
+			++node->ae.curr_freq_pr;
+		}
+	}
+#endif // SELINUX_RATE_CONTROL
+
 	p_ae = node ? &node->ae : &entry;

 	if (avd)
@@ -875,9 +948,19 @@
 		if (selinux_enforcing)
 			rc = -EACCES;
 		else
-			if (node)
-				avc_update_node(AVC_CALLBACK_GRANT,requested,
-						ssid,tsid,tclass);
+#ifdef SELINUX_RATE_CONTROL
+			if ( frequency_exceed )
+			{
+				rc = -EAGAIN ;
+			//	rc = -EBUSY ; // maybe we can use EBUSY also.
+			}
+			else
+#endif // SELINUX_RATE_CONTROL
+			{
+				if (node)
+					avc_update_node(AVC_CALLBACK_GRANT,requested,
+							ssid,tsid,tclass);
+			}
 	}

 	rcu_read_unlock();
diff -uNr linux-2.6.21.orig/security/selinux/include/security.h
linux-2.6.21_selinux_rate_control/security/selinux/include/security.h
--- linux-2.6.21.orig/security/selinux/include/security.h	2007-04-26
08:38:32.000000000 +0530
+++ linux-2.6.21_selinux_rate_control/security/selinux/include/security.h	2007-05-31
12:29:02.000000000 +0530
@@ -34,6 +34,9 @@
 #define POLICYDB_VERSION_MAX	POLICYDB_VERSION_RANGETRANS
 #endif

+#define SELINUX_RATE_CONTROL 1
+
+
 struct sk_buff;

 extern int selinux_enabled;
@@ -47,6 +50,9 @@
 	u32 auditallow;
 	u32 auditdeny;
 	u32 seqno;
+#ifdef SELINUX_RATE_CONTROL
+	u32 max_freq_pr;
+#endif // SELINUX_RATE_CONTROL
 };

 int security_compute_av(u32 ssid, u32 tsid,
diff -uNr linux-2.6.21.orig/security/selinux/ss/services.c
linux-2.6.21_selinux_rate_control/security/selinux/ss/services.c
--- linux-2.6.21.orig/security/selinux/ss/services.c	2007-04-26
08:38:32.000000000 +0530
+++ linux-2.6.21_selinux_rate_control/security/selinux/ss/services.c	2007-05-31
19:34:19.000000000 +0530
@@ -79,6 +79,78 @@
 struct policydb policydb;
 int ss_initialized = 0;

+
+#ifdef SELINUX_RATE_CONTROL
+#define MAX_RULES 50
+// this array holds list of tuples in format (sid, tid, tclass,
max_frequency_allowed)
+struct binary_policy_struct
+{
+	int used ;
+	struct context s_context ;
+	struct context t_context ;
+	u32 tclass ;
+	u32 max_freq ;
+} binary_policy_array_pr[MAX_RULES];
+
+/*
+ *	wildcard_context_match does the context matching with considering wildcards
+ * */
+int wildcard_context_match ( struct context * rule_context, struct
context *matched_context)
+{
+	int matched = 1 ;
+
+	/*Here value of zero in rule_context part is assumed as wildcard,
which matches everything.
+	 * so, the order of rule_context and matched_context can not be reverted here.
+	 * */
+
+	if ( rule_context->user != 0 )
+	{	// it means match user also.
+		if ( rule_context->user != matched_context->user )
+			matched = 0 ;
+	}
+	if ( rule_context->role != 0 )
+	{	// it means match role also.
+		if ( rule_context->role != matched_context->role )
+			matched = 0 ;
+	}
+	if ( rule_context->type != 0 )
+	{	// it means match type also.
+		if ( rule_context->type != matched_context->type )
+			matched = 0 ;
+	}
+	return matched ;
+}
+
+
+/*
+ * The search_myrules_pr will return the frequency for the given
tuple of (ssid, tsid, tclass)
+ * It will just search it in the policy_array_pr array and will
return the frequency.
+ * */
+u32 search_myrules_pr (struct context *s_context, struct context *
t_context, u32 tclass)
+{
+	int i ;
+
+	for ( i = 0 ; i < MAX_RULES ; ++i )
+	{
+		// Its assumed that rules are in order, so if i'th rule is not
there, it means, i+1 is also not there.
+		// if i'th rule is not present, then
+		if (binary_policy_array_pr[i].used == 0 )
+		{
+			return  (0);
+		}
+		// if i'th rule matches then
+		if ( (wildcard_context_match(&binary_policy_array_pr[i].s_context,
s_context)) && (wildcard_context_match(&binary_policy_array_pr[i].t_context,
t_context)) && (binary_policy_array_pr[i].tclass == tclass ) )
+		{
+			return  (binary_policy_array_pr[i].max_freq);
+		}
+	}
+
+	// zero stands for no matching rule present
+	return 0 ;
+}
+
+#endif // SELINUX_RATE_CONTROL
+
 /*
  * The largest sequence number that has been used when
  * providing an access decision to the access vector cache.
@@ -322,6 +394,10 @@
 	avd->auditdeny = 0xffffffff;
 	avd->seqno = latest_granting;

+#ifdef SELINUX_RATE_CONTROL
+	avd->max_freq_pr = search_myrules_pr (scontext, tcontext, tclass ) ;
+#endif // SELINUX_RATE_CONTROL
+
 	/*
 	 * If a specific type enforcement rule was defined for
 	 * this permission check, then use it.
@@ -520,6 +596,9 @@
 		avd->auditallow = 0;
 		avd->auditdeny = 0xffffffff;
 		avd->seqno = latest_granting;
+#ifdef SELINUX_RATE_CONTROL
+		avd->max_freq_pr= 0;
+#endif // SELINUX_RATE_CONTROL
 		return 0;
 	}

@@ -1250,6 +1329,162 @@

 extern void selinux_complete_init(void);

+
+#ifdef SELINUX_RATE_CONTROL
+/**
+	load_policy_pr () loads the policies for rate controls
+	currently the policies are hard-coded and part of kernel.
+	but these policies are to be read from file.
+	And currently we are considering only type part of security context.
+	but we can use all three parts of context in rules.
+
+	There are many enhancements needed in this function.
+*/
+int load_policy_pr();
+int load_policy_pr()
+{
+	struct type_datum *typdatum ;
+	int volatile i = 0 ;
+	struct context_pr
+	{
+		char user[30];
+		char role[30];
+		char type[30];
+
+	} ;
+	struct rule_struct
+	{
+		struct context_pr source_context ;
+		struct context_pr dest_context ;
+		int tclass ;
+		int max_freq ;
+	} rule_list[MAX_RULES] =
+		{
+			{
+				{{NULL},{NULL},{"vulerable04_t"}},
+				{{NULL},{NULL},{"vulerable04_t"}},
+				2, 15
+			},
+			{
+				{{NULL},{NULL},{"vulerable04_t"}} ,
+				{{NULL},{NULL},{"unpriv_tcp_port_t"}},
+				15, 15
+			}
+		};
+
+
+
+	printk (KERN_INFO "\nLoading SELINUX rate-control policies\n");
+	// Converting security contexts
+	
+	/*
+	 * Here I am supposed to read these policies from some configuration file.
+	 * Unfortunately, reading from file, when you are kernel is not so easy :-(
+	 * I am working on it.
+	 * */
+
+
+
+	for(i=0;i<MAX_RULES;++i)
+	{
+		// read the source context first
+		
+		binary_policy_array_pr[i].used = 0 ;
+
+		// start with user
+		binary_policy_array_pr[i].s_context.user =(u32) 0;
+		if (rule_list[i].source_context.user != 0 )
+		{
+			typdatum = hashtab_search(policydb.p_users.table,
rule_list[i].source_context.user);
+      			if (typdatum)
+           		{
+				binary_policy_array_pr[i].used = 1 ;
+				binary_policy_array_pr[i].s_context.user = (u32)typdatum->value;
+			}
+		}
+		// then with role
+		binary_policy_array_pr[i].s_context.role =(u32) 0;
+		if (rule_list[i].source_context.role != 0 )
+		{
+			typdatum = hashtab_search(policydb.p_roles.table,
rule_list[i].source_context.role);
+      			if (typdatum)
+           		{
+				binary_policy_array_pr[i].used = 1 ;
+				binary_policy_array_pr[i].s_context.role = (u32)typdatum->value;
+			}
+		}
+		// then with type
+		binary_policy_array_pr[i].s_context.type =(u32) 0;
+		if (rule_list[i].source_context.type != 0 )
+		{
+			typdatum = hashtab_search(policydb.p_types.table,
rule_list[i].source_context.type);
+      			if (typdatum)
+           		{
+				binary_policy_array_pr[i].used = 1 ;
+				binary_policy_array_pr[i].s_context.type = (u32)typdatum->value;
+			}
+		}
+
+
+		// read the target context now
+
+		// start with user
+		binary_policy_array_pr[i].t_context.user =(u32) 0;
+		if (rule_list[i].dest_context.user != 0 )
+		{
+			typdatum = hashtab_search(policydb.p_users.table,
rule_list[i].dest_context.user);
+      			if (typdatum)
+           		{
+				binary_policy_array_pr[i].used = 1 ;
+				binary_policy_array_pr[i].t_context.user = (u32)typdatum->value;
+			}
+		}
+		// then with role
+		binary_policy_array_pr[i].t_context.role =(u32) 0;
+		if (rule_list[i].dest_context.role != 0 )
+		{
+			typdatum = hashtab_search(policydb.p_roles.table,
rule_list[i].dest_context.role);
+      			if (typdatum)
+           		{
+				binary_policy_array_pr[i].used = 1 ;
+				binary_policy_array_pr[i].t_context.role = (u32)typdatum->value;
+			}
+		}
+		// then with type
+		binary_policy_array_pr[i].t_context.type =(u32) 0;
+		if (rule_list[i].dest_context.type != 0 )
+		{
+			typdatum = hashtab_search(policydb.p_types.table,
rule_list[i].dest_context.type);
+      			if (typdatum)
+           		{
+				binary_policy_array_pr[i].used = 1 ;
+				binary_policy_array_pr[i].t_context.type = (u32)typdatum->value;
+			}
+		}
+
+		
+		// now check the tclass and max_freq given
+		binary_policy_array_pr[i].tclass = (u32)rule_list[i].tclass;
+		binary_policy_array_pr[i].max_freq = (u32)rule_list[i].max_freq ;
+
+		// print the details for debug purpose
+		printk(KERN_INFO "i=%d used = %d, s_context(%llu,%llu,%llu),
tcontext(%llu,%llu,%llu), tclass=%llu, freq =%llu\n",
+		i, binary_policy_array_pr[i].used,
+		(unsigned long long) binary_policy_array_pr[i].s_context.user,
+		(unsigned long long) binary_policy_array_pr[i].s_context.role,
+		(unsigned long long) binary_policy_array_pr[i].s_context.type,
+		(unsigned long long) binary_policy_array_pr[i].t_context.user,
+		(unsigned long long) binary_policy_array_pr[i].t_context.role,
+		(unsigned long long) binary_policy_array_pr[i].t_context.type,
+		(unsigned long long) binary_policy_array_pr[i].tclass,
+		(unsigned long long) binary_policy_array_pr[i].max_freq );
+		
+	} // end for : MAX_RULES
+	return 0 ;
+}
+
+#endif // SELINUX_RATE_CONTROL
+
 /**
  * security_load_policy - Load a security policy configuration.
  * @data: binary policy data
@@ -1303,6 +1538,9 @@
 		selnl_notify_policyload(seqno);
 		selinux_netlbl_cache_invalidate();
 		selinux_xfrm_notify_policyload();
+#ifdef SELINUX_RATE_CONTROL
+		load_policy_pr();
+#endif // SELINUX_RATE_CONTROL
 		return 0;
 	}

@@ -1359,6 +1597,9 @@
 	selnl_notify_policyload(seqno);
 	selinux_netlbl_cache_invalidate();
 	selinux_xfrm_notify_policyload();
+#ifdef SELINUX_RATE_CONTROL
+	load_policy_pr();
+#endif // SELINUX_RATE_CONTROL

 	return 0;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
