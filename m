Date: Fri, 28 Nov 2008 20:09:16 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Subrata Modak <subrata@linux.vnet.ibm.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, ltp-list <ltp-list@lists.sf.net>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [RFC] Testing Support for deferred mapping of contexts & enable
 processes with mac_admin to get the raw inode contexts
In-Reply-To: <1227860870.5059.14.camel@subratamodak.linux.ibm.com>
Message-ID: <alpine.LRH.1.10.0811282007240.8222@tundra.namei.org>
References: <1227860870.5059.14.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 28 Nov 2008, Subrata Modak wrote:

> Hi Stephen/James,
> 
> Is there any plan, or, somebody working to add Testing Support to LTP
> for:
> 1) Deferred mapping of contexts, &
> 2) Enable processes with mac_admin to get the raw inode contexts,

Not that I'm aware of.
> 
> recently being added to 2.6.27
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=12b29f34558b9b45a2c6eabd4f3c6be939a3980f,
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=abc69bb633931bf54c6db798bcdc6fd1e0284742
> 
> Regards--
> Subrata
> 
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
