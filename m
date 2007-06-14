Subject: Re: selinux backups
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kazuki Omo <omok@honto.info>
Cc: david carvalho <david@di.ubi.pt>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>, James Antill <jantill@redhat.com>
In-Reply-To: <20070614024958.GA19806@insanity.honto.info>
References: <049d01c7ade0$d28ca260$fd01000a@ubi.pt>
	 <1181758701.17547.453.camel@moss-spartans.epoch.ncsc.mil>
	 <20070614024958.GA19806@insanity.honto.info>
Content-Type: text/plain
Date: Thu, 14 Jun 2007 06:56:02 -0400
Message-Id: <1181818562.17547.548.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-06-14 at 11:49 +0900, Kazuki Omo wrote:
> Hi,
> 
> I checked some backup program for writing selinux article;
> http://www.atmarkit.co.jp/fsecurity/rensai/selinux202/selinux01.html
> (Available on next week, but it has Japanese character only.)
> 
> Current dump/restore and star are supporting SELinux.
> If you want to use "cp", you have to use "-c" option for copying 
> xattrs. 
> 
> Also, I couldn't take xattrs by "tar" and "rsync" on CentOS4.4.
> I didn't check "tar" on Fedora, so it might be able to take xattr.
> I don't know how we can take xattr with "rsync":-(

Try rsync -X or --xattrs.  Requires a modern version of rsync though.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
