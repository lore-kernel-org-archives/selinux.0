Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j11GFS53016291
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 11:15:29 -0500 (EST)
Received: from web50202.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j11GFUYB019400
	for <selinux@tycho.nsa.gov>; Tue, 1 Feb 2005 16:15:30 GMT
Message-ID: <20050201161531.68020.qmail@web50202.mail.yahoo.com>
Date: Tue, 1 Feb 2005 08:15:31 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: File Browsing apps and getattr
To: ivg2@cornell.edu, Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1107264384.6956.2.camel@cobra.ivg2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Ivan Gyurdiev <ivg2@cornell.edu> wrote:


> Why is the stat() information so important for
> security?

In a mandatory access control environment the
attributes (e.g. inode information) are
considered to be as sensitive as the data.
Why? Because the attributes are manipulated
by processes with the same sensitivity as
the data. A Top Secret file can be manipulated
by a Top Secret user. If an Unclassified user
could read the attributes information could
be overtly passed down using chmod, chown,
utime, link, unlink, acl_set_file, and
truncate.

> If you won't do this, how do you plan to address the
> denials I have
> posted about? 
> 
> Will you leave ls in this state:
> 
> [phantom@cobra ~]$ ls -l /var
> total 112
> ?---------   ? ?    ?       ?            ? account
> drwxr-xr-x  10 root root 4096 Jan 16 05:33 cache

This is exactly what the U2X mandatory access
control systems do. Actually, you'll see ls
spewing "access denied" messages, not the neater
"?" form you have here.

In the U2X world we always had the luxury of
telling irate users that this is exactly the
correct behavior that they had paid extra for.
Cackle.


=====
Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Find what you need with new enhanced search.
http://info.mail.yahoo.com/mail_250

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
