Subject: Re: Access_terminal + ioctl
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1108961995.20655.8.camel@cobra.ivg2.net>
References: <1108961995.20655.8.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 08:57:53 -0500
Message-Id: <1109080673.2256.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-02-20 at 23:59 -0500, Ivan Gyurdiev wrote:
> Is it all right if I add back ioctl permission
> on $1_devpts_t, $1_tty_device_t, and devtty_t (chr_file)
> in the access_terminal macro?

Yes.

> Can I just use rw_file_perms?

No.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
