Subject: Re: Updated policy
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41F6A47E.9010407@redhat.com>
References: <41F6A47E.9010407@redhat.com>
Content-Type: text/plain
Date: Wed, 26 Jan 2005 01:22:02 -0700
Message-Id: <1106727722.17956.3.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-25 at 14:56 -0500, Daniel J Walsh wrote:
> Many changes to allow policy to support telnetd, rlogind and rshd.
> 
> allow mount_t binfmt_misc_fs_t:dir mounton;
> Required to run wine.

Now there is:

allow mount_t binfmt_misc_fs_t:dir mounton;
...
# mount binfmt_misc on /proc/sys/fs/binfmt_misc
allow mount_t sysctl_t:dir { mounton search };

Are both of those necessary?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
