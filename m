Date: Tue, 20 Aug 2002 10:08:00 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Timothy Wood <timothy@hallcomp.com>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: stripped mount point
In-Reply-To: <1029851518.9543.30.camel@phobos>
Message-ID: <Pine.GSO.4.33.0208200957200.24294-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 20 Aug 2002, Timothy Wood wrote:

> I just relabeled the files on my system and now my apache processes can
> not read from the doc root nor can they append to the logs.  Now I
> noticed when I relabeled the fs that each mount point was done
> independently whereas before it would just label everything as being
> under / (eg it labeled /, then it labeled /var, then /tmp, etc., etc.).
> The files are all labeled correctly but the avc messages have the mount
> points stripped from the path section (eg apache isn't denied access to
> /var/www/html it is denied access to /www/html).  Now I can see how this
> is causing a problem the question is why is it doing this?

>From your audit logs, you can see that httpd is running in the wrong
domain (initrc_t rather than httpd_t).  This suggests that /usr/sbin/httpd
is not labeled with httpd_exec_t and needs to be relabeled.  After
relabeling /usr/sbin/httpd (either by running chcon directly or by running
'make relabel' again), run 'run_init /etc/init.d/httpd restart' to restart
the daemon in the correct domain.

With regard to the relabeling, setfiles is always applied to each
filesystem (partition) in turn, since each filesystem must contain its own
persistent label mapping.  You are presumably seeing a change because you
now have multiple partitions whereas you must have previously only had
one.

With regard to auditing, the audit path is expected to be relative to the
root of each filesystem, since we cannot reliably reconstruct any kind of
"absolute" pathname from many of the locations in the kernel where a
permission check is performed.  However, the audit path is not relevant to
the access control enforcement - SELinux is inode-based, not path-based.
The audit path is merely intended to assist in understanding the audit
message.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
