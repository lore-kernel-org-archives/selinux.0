Subject: Re: warning and question: e2fsck
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1061821751.1665.700.camel@kusturica>
References: <1061821751.1665.700.camel@kusturica>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1061822507.28086.440.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 25 Aug 2003 10:41:48 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-08-25 at 10:29, Magosányi Árpád wrote:
> Hi!
> 
> Kernel: 2.6.0-test3
> relevant configs: ext2 and ext3 support, support with selinux extended
> attributes
> 
> I have made a make relabel.
> After the next reboot, fsck have complained that the extended attribute
> is not okay. 
> I have made an e2fsck.
> It seems that most of my files have been deleted due to it.
> e2fsck is from debian sarge
> 
> And the question:
> How can I avoid it next time besides not fscking?

Upgrade your e2fsprogs.  Latest one is 1.34, iirc.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
