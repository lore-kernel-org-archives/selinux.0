Subject: Re: [PATCH] keys: randomize key serial numbers
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: David Howells <dhowells@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@epoch.ncsc.mil, jmorris@redhat.com
In-Reply-To: <14647.1150205744@warthog.cambridge.redhat.com>
References: <13450.1150204888@warthog.cambridge.redhat.com>
	 <1150144497.4754.5.camel@moss-tarheels.epoch.ncsc.mil>
	 <14647.1150205744@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 09:57:14 -0400
Message-Id: <1150207034.3677.28.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I think the concept of "covert channels" needs to be explained better
here.
> I'm not sure what the problem is exactly that you're trying to fix.

Basically, since the serial number pool is shared among all contexts,
some malicious process in one context (typically called a trojan) could
allocate keys according to some pattern, and that pattern would be
visible to another process (typically called a spy) running in a
different context.

For example, the trojan could transmit an arbitrary binary stream very simply
by setting itself up on a periodic timer, perhaps on a 100 ms interval.  Then,
when the timer fires, the trojan could either sit idle to transmit a 0, or
allocate a new key to transmit a 1.  The spy process would set itself up on a
similar schedule and attempt to allocate one new
key in each timer interval.  Since the current serial number allocator is trivially
predictable, the spy simply examines the serial number assigned to the new key to
determine whether or not the trojan transmitted a 1 or a 0.  Over time, a
significant amount of data could be leaked through this channel.

Covert channels can be categorized according to their "noisiness."  For the
most part, the noisier a channel is, the less bandwidth it provides to trojans.  
The only noise on the channel discussed above comes from other activity on the
system, such as login/logout attempts and new key allocations, that interfere
with the trojan's transmissions by increasing the serial number.

Using a randomized allocator should greatly increase the noise on the channel,
since the numbers become unpredictable.  Every shortcut we take reduces the noise
by some amount, like picking a single random number and walking the tree from that.
However, it isn't our intention to maximize the noise on the channel, and I believe
your argument for conserving entropy is well-founded.

If you want more information about covert channels, I'd recommend the old TCSEC
guide: http://www.radium.ncsc.mil/tpep/library/rainbow/NCSC-TG-030.html

On Tue, 2006-06-13 at 14:35 +0100, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > How about the attached patch?
> 
> And, of course, I should try compiling and running the kernel before sending
> the patch.
> 

This looks good to me, it will certainly reduce the bandwidth of the
channel.  Do you want me to resubmit this, or do you want to handle it
yourself?

> Try this instead.
> 
> David
> 
> ---
> warthog>diffstat -p1 /tmp/key-random.diff 
>  security/keys/key.c |   28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/security/keys/key.c b/security/keys/key.c
> index b6061fa..adf4206 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -15,11 +15,11 @@ #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/security.h>
>  #include <linux/workqueue.h>
> +#include <linux/random.h>
>  #include <linux/err.h>
>  #include "internal.h"
>  
>  static kmem_cache_t	*key_jar;
> -static key_serial_t	key_serial_next = 3;
>  struct rb_root		key_serial_tree; /* tree of keys indexed by serial */
>  DEFINE_SPINLOCK(key_serial_lock);
>  
> @@ -169,22 +169,23 @@ static void __init __key_insert_serial(s
>  /*****************************************************************************/
>  /*
>   * assign a key the next unique serial number
> - * - we work through all the serial numbers between 2 and 2^31-1 in turn and
> - *   then wrap
> + * - these are assigned randomly to avoid security issues through covert
> + *   channel problems
>   */
>  static inline void key_alloc_serial(struct key *key)
>  {
>  	struct rb_node *parent, **p;
>  	struct key *xkey;
>  
> -	spin_lock(&key_serial_lock);
> -
> -	/* propose a likely serial number and look for a hole for it in the
> +	/* propose a random serial number and look for a hole for it in the
>  	 * serial number tree */
> -	key->serial = key_serial_next;
> -	if (key->serial < 3)
> -		key->serial = 3;
> -	key_serial_next = key->serial + 1;
> +	do {
> +		get_random_bytes(&key->serial, sizeof(key->serial));
> +
> +		key->serial >>= 1; /* negative numbers are not permitted */
> +	} while (key->serial < 3);
> +
> +	spin_lock(&key_serial_lock);
>  
>  	parent = NULL;
>  	p = &key_serial_tree.rb_node;
> @@ -204,12 +205,11 @@ static inline void key_alloc_serial(stru
>  
>  	/* we found a key with the proposed serial number - walk the tree from
>  	 * that point looking for the next unused serial number */
> - serial_exists:
> +serial_exists:
>  	for (;;) {
> -		key->serial = key_serial_next;
> +		key->serial++;
>  		if (key->serial < 2)
>  			key->serial = 2;
> -		key_serial_next = key->serial + 1;
>  
>  		if (!parent->rb_parent)
>  			p = &key_serial_tree.rb_node;
> @@ -228,7 +228,7 @@ static inline void key_alloc_serial(stru
>  	}
>  
>  	/* we've found a suitable hole - arrange for this key to occupy it */
> - insert_here:
> +insert_here:
>  	rb_link_node(&key->serial_node, parent, p);
>  	rb_insert_color(&key->serial_node, &key_serial_tree);
>  
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
