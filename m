Subject: Re: setfiles and restorecon performance patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>,
   "Stephen C. Tweedie" <sct@redhat.com>
In-Reply-To: <200601031959.34132.russell@coker.com.au>
References: <200601031959.34132.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 08:55:13 -0500
Message-Id: <1137160513.3445.131.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-01-03 at 19:59 +1100, Russell Coker wrote:
> The attached patch (against policycoreutils-1.29.2-8 from rawhide) makes 
> setfiles and restorecon fork off a child process to stat the files before the 
> main process gets to them.

Merged as of policycoreutils 1.29.7, with the change to STAT_BLOCK_SIZE
that we discussed off-list.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
