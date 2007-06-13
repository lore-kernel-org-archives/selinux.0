Subject: Re: selinux backups
From: Stephen Smalley <sds@tycho.nsa.gov>
To: david carvalho <david@di.ubi.pt>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        James Antill <jantill@redhat.com>
In-Reply-To: <049d01c7ade0$d28ca260$fd01000a@ubi.pt>
References: <049d01c7ade0$d28ca260$fd01000a@ubi.pt>
Content-Type: text/plain
Date: Wed, 13 Jun 2007 14:18:21 -0400
Message-Id: <1181758701.17547.453.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-13 at 18:32 +0100, david carvalho wrote:
> Good afternoon.
> Wich is the best way to make a backup of a system running lvm and
> selinux ?
> It seems that with lvm systems, the best way is to take a snapshot
> (wich seems a waste
> of space in a Volume Group). But with Selinux ?  tar-1.15 doesn't
> apply the right 
> permissions when extracting (at least of what I tested). 
> I've bee using "dump" for a while, and I tested it right now and it
> preserves the "extended attributes" so it seems to be the right option
> for me since the scripts I'm using, use "dump"
> Is it possible/preferable to use tar or star ?

What's your distribution and release?  star was the first to support
preserving xattrs and selinux, dump/restore later added support, and I
think that even tar now has support at least in Fedora.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
