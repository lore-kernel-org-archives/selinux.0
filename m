Subject: Re: init, checkpolicy manpage and labeling questions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1062071503.3076.124.camel@kusturica>
References: <1062071503.3076.124.camel@kusturica>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1062074148.2517.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 28 Aug 2003 08:35:48 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-08-28 at 07:51, Magosányi Árpád wrote:
> First the questions:
> 
> Make relabel complained about /var/run/pump.sock . putting a <<none>>
> in file_contexts did not help, but I could manage it by removing the
> socket.
> Do we have labels on sockets yet?

Yes, this should work.  Are you using ext2 or ext3?  If ext2, then you
need the patch I posted on Monday in response to Karl MacMillan's
posting on the list; there is a typo in an #ifdef in ext2/namei.c that
prevents special inodes from getting the xattr operations.

> My other problem is with various files in /dev. I use devfs and devfsd.
> for example getfilecon fails for /dev/console, /dev/null, and /dev/pts/0
> (in a devpts fs). Can someone explain the situation to me?

For devpts, you need to enable the xattr handler, as mentioned in the
selinux-doc README.  There is presently no xattr handler for devfs; you
can implement one if you like, but devfs appears to be obsolete.

> You can find a checkpolicy manpage attached. I was not too definiitive:)

Thanks, I'll take a look at it, since I wrote the program.

> Also here is my boot method, as I did not want to boot from initrd:

Any particular reason?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
