Date: Wed, 22 Jul 2009 23:53:44 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, sds@tycho.nsa.gov,
        spender@grsecurity.net, dwalsh@redhat.com, cl@linux-foundation.org,
        arjan@infradead.org, alan@lxorguk.ukuu.org.uk, kyle@mcmartin.ca,
        cpardy@redhat.com, arnd@arndb.de
Subject: Re: [PATCH -v2 1/2] VM/SELinux: require CAP_SYS_RAWIO for all
 mmap_zero operations
In-Reply-To: <20090721230339.20180.99803.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.0907222345530.17486@tundra.namei.org>
References: <20090721230339.20180.99803.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 21 Jul 2009, Eric Paris wrote:

>  	error = security_file_mmap(file, reqprot, prot, flags, addr, 0);
>  	if (error)
>  		return error;
> +
> +	if ((addr < mmap_min_addr) && !capable(CAP_SYS_RAWIO))
> +		return -EACCES;
> +

These DAC checks should happen before the LSM hook, in keeping with the 
general design goal of LSM of "DAC before MAC", so that application 
behavior remains as consistent as possible.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
