Date: Mon, 25 Feb 2008 10:11:51 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux <selinux@tycho.nsa.gov>, sds@tycho.nsa.gov, dwalsh@redhat.com,
        Paul Moore <paul.moore@hp.com>
Subject: Re: [RFC PATCH] SELinux: differentiate between open and r/w operations
In-Reply-To: <1203706979.2914.46.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0802251007020.846@us.intercode.com.au>
References: <1203706979.2914.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 22 Feb 2008, Eric Paris wrote:

> +	if (selinux_policycap_openperm) {
> +		/*
> +		 * lnk files and socks do not really have an 'open'
> +		 */
> +		if (S_ISREG(inode->i_mode))
> +			av |= FILE__OPEN;
> +		else if (S_ISCHR(inode->i_mode))
> +			av |= CHR_FILE__OPEN;
> +		else if (S_ISBLK(inode->i_mode))
> +			av |= BLK_FILE__OPEN;
> +		else if (S_ISFIFO(inode->i_mode))
> +			av |= FIFO_FILE__OPEN;
> +		else if (S_ISDIR(inode->i_mode))
> +			av |= DIR__OPEN;
> +		else {
> +			printk(KERN_EMERG "inside open_file_to_av with unknown mode:%x\n", inode->i_mode);
> +			BUG();
> +		}
> +	}
> +	return av;

I don't think we should BUG() here, makes it too easy for a DoS attack 
if there is ever a possible further value for i_mode.

I suggest just printing a warning via printk_ratelimit and returning the 
value of file_to_av(), which simply preserves existing behavior.


- Ja,es
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
