From: <peter.enderborg@sony.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Daniel Jurgens <danielj@mellanox.com>,
 Doug Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 <alsa-devel@alsa-project.org>, "Serge E . Hallyn" <serge@hallyn.com>
Date: Fri, 26 Jan 2018 15:32:36 +0100
Message-ID: <20180126143241.23108-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH v2 0/5] selinux:Significant reduce of
 preempt_disable holds
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Holding the preempt_disable is very bad for low latency tasks
as audio and therefore we need to break out the rule-set dependent
part from this disable. By using a RCU instead of rwlock we
have an efficient locking and less preemption interference.

Selinux uses a lot of read_locks. This patch replaces the rwlock
with RCY that does not hold preempt_disable.

Intel Xeon W3520 2.67 Ghz running FC27 with 4.15.0-rc9git (+measurement)
I get preempt_disable in worst case for 1.2ms in security_compute_av().
With the patch I get 960us as the longest security_compute_av()
without preempt disabeld. It very much noise in the measurement
but it is not likely a degrade.

And the preempt_disable times is also very dependent on the selinux
rule-set.

In security_get_user_sids() we have two nested for-loops and the
inner part calls sittab_context_to_sid() that calls
sidtab_search_context() that has a for loop() over a while() where
the loops is dependent on the rules.

On the test system the average lookup time is 60us and does
not change with the RCU usage.

To use RCU the structure of policydb has to be accesses through a pointer.
We need 4 patches to get there.

  [PATCH v2 1/5] selinux:Remove direct references to policydb.
  We remove direct references and pass it through function arguments.

  [PATCH v2 2/5] selinux: Move policydb to pointer structure
  Move the policydb to dynamic allocated structure.

  [PATCH v2 3/5] selinux: Move sidtab to pointer structure
  Same as for policydb but for sidtab. They are closly related
  and should be switched at the same time.
  
  [PATCH v2 4/5] selinux: Use pointer to switch policydb and sidtab
  Now we can switch rules by switching pointers.

  [PATCH v2 5/5] selinux: Switch locking to RCU.
  We are now ready to use RCU.
  
History: V1 rwsem
