Subject: Re: strange policy loading problem
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
In-Reply-To: <1268334980.16780.101.camel@moss-pluto.epoch.ncsc.mil>
References: <201003031018.38030.russell@coker.com.au>
	 <1268334980.16780.101.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 11 Mar 2010 14:59:32 -0500
Message-Id: <1268337572.16780.112.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-03-11 at 14:16 -0500, Stephen Smalley wrote:
> On Wed, 2010-03-03 at 10:18 +1100, Russell Coker wrote:
> > I'm running a 2.6.32 system under KVM and it keeps OOMing when I try to run 
> > semodule.
> > 
> > # free
> >              total       used       free     shared    buffers     cached
> > Mem:        507532     475320      32212          0       4168      11148
> > -/+ buffers/cache:     460004      47528
> > Swap:       524280      19848     504432
> > 
> > The policy.24 file is just under 900K in size, the output of free is above, it 
> > doesn't seem particularly short of RAM.  The dmesg output is below.  Any 
> > suggestions for what I should investigate?
> > 
> > I could just give the VM a gig of RAM, but I run lots of real systems with 
> > less than 512M so I would like this to work.
> > 
> > 
> > [10750.523296] load_policy: page allocation failure. order:4, mode:0xc0d0
> > [10750.524503] Pid: 13383, comm: load_policy Not tainted 2.6.32-trunk-amd64 #1
> 
> This has been reproduced by others, and in looking further at it, I
> think it is due to switching the avtab from using vmalloc() to using
> kmalloc() as part of commit 3232c110b56bd01c5f0fdfd16b4d695f2e05b0a9
> without reducing MAX_AVTAB_SIZE sufficiently to ensure that we don't put
> too much pressure on the slab allocator.  Options seem to be:
> 1) Reduce MAX_AVTAB_SIZE further so that the max avtab allocation is a
> lower order allocation that isn't likely to fail on kcalloc, and keep
> using that always.
> 2) Change the avtab code to dynamically select use of vmalloc/vfree or
> kcalloc/kfree depending on the selected avtab size.

So, for example, this might solve your immediate problem:

diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 8da6a84..db15fe9 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -82,7 +82,7 @@ struct avtab_node *avtab_search_node_next(struct avtab_node *node, int specified
 void avtab_cache_init(void);
 void avtab_cache_destroy(void);
 
-#define MAX_AVTAB_HASH_BITS 13
+#define MAX_AVTAB_HASH_BITS 10
 #define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
 #define MAX_AVTAB_HASH_MASK (MAX_AVTAB_HASH_BUCKETS-1)
 #define MAX_AVTAB_SIZE MAX_AVTAB_HASH_BUCKETS

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
