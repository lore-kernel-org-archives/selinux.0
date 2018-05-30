From: Peter Enderborg <peter.enderborg@sony.com>
To: <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Daniel Jurgens <danielj@mellanox.com>, Doug
 Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 16:10:59 +0200
Message-ID: <20180530141104.28569-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH V3 0/5] selinux:Significant reduce of
 preempt_disable holds
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Holding the preempt_disable is very bad for low latency tasks
such as audio and therefore we need to break out the rule-set dependent
part from this disable. By using a RCU instead of rwlock we
have an efficient locking and less preemption interference.

Selinux uses a lot of read_locks. This patch replaces the rwlock
with RCU that does not hold preempt_disable.

Intel Xeon W3520 2.67 Ghz running FC27 with 4.15.0-rc9git (+measurement)
I get preempt_disable of about 1.2ms in security_compute_av().
With the patch I get 960us as the longest security_compute_av()
without preempt disabeld. There are very much noise in the measurement
but it is not likely a degrade.

And the preempt_disable times is also very dependent on the selinux
rule-set.

In security_get_user_sids() we have two nested for-loops and the
inner part calls sittab_context_to_sid() that calls
sidtab_search_context() that has a for loop() over a while() where
the loops is dependent on the rules.

On the test system the average lookup time is 60us and does
not change with the introduced RCU usage.

The boolean change becomes a lot more heavy with this patch,
but it is a very rare usage in compare with read only operations.
The lock held during a policydb_copy is about 1ms on a XEON.

To use RCU the structure of policydb has to be accesses through a pointer.
We need 5 patches to get there.
 
[PATCH V3 1/5 selinux-next] selinux: Make allocation atomic in policydb objects functions.
This patch change the allocation for policydb objects. They are in its own patch
to make the complicated part easier to read.

[PATCH V3 2/5 selinux-next] selinux: Introduce selinux_ruleset struct
This makes the access for the rule evaluation going though a single pointer.

[PATCH V3 3/5 selinux-next] selinux: sidtab_clone switch to use rwlock.
We need to make sidtabs copys so this patch change the locks to a rwlock
and create a copy function.

[PATCH V3 4/5 selinux-next] selinux: seqno separation
This patch adds separation of the read and write and uses
the pointer to switch rule set. It uses seqno for error handling
since there are a possibility to have multiple access.

[PATCH V3 5/5 selinux-next] selinux: Switch to rcu read locks for avc_compute
All the preparation is done so this patch do the change of locks to rcu.

History:
V1 rwsem
V2 did not handle all policydb objects, solved with the policydb_copy
   did not handle sidtab for booleans, I think this one does however
   shutdown is not used but not removed. 
