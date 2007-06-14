Date: Thu, 14 Jun 2007 11:49:58 +0900
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: david carvalho <david@di.ubi.pt>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>, James Antill <jantill@redhat.com>
Subject: Re: selinux backups
Message-ID: <20070614024958.GA19806@insanity.honto.info>
References: <049d01c7ade0$d28ca260$fd01000a@ubi.pt> <1181758701.17547.453.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
In-Reply-To: <1181758701.17547.453.camel@moss-spartans.epoch.ncsc.mil>
From: omok@honto.info (Kazuki Omo)
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I checked some backup program for writing selinux article;
http://www.atmarkit.co.jp/fsecurity/rensai/selinux202/selinux01.html
(Available on next week, but it has Japanese character only.)

Current dump/restore and star are supporting SELinux.
If you want to use "cp", you have to use "-c" option for copying 
xattrs. 

Also, I couldn't take xattrs by "tar" and "rsync" on CentOS4.4.
I didn't check "tar" on Fedora, so it might be able to take xattr.
I don't know how we can take xattr with "rsync":-(

Regards,

OMO

On Wed, Jun 13, 2007 at 02:18:21PM -0400, Stephen Smalley wrote:
> On Wed, 2007-06-13 at 18:32 +0100, david carvalho wrote:
> > Good afternoon.
> > Wich is the best way to make a backup of a system running lvm and
> > selinux ?
> > It seems that with lvm systems, the best way is to take a snapshot
> > (wich seems a waste
> > of space in a Volume Group). But with Selinux ?  tar-1.15 doesn't
> > apply the right 
> > permissions when extracting (at least of what I tested). 
> > I've bee using "dump" for a while, and I tested it right now and it
> > preserves the "extended attributes" so it seems to be the right option
> > for me since the scripts I'm using, use "dump"
> > Is it possible/preferable to use tar or star ?
> 
> What's your distribution and release?  star was the first to support
> preserving xattrs and selinux, dump/restore later added support, and I
> think that even tar now has support at least in Fedora.
> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

-- 
Kazuki Omo: omok@honto.info
LIDS Japanese Information:
Japanese: http://www.selinux.gr.jp/LIDS-JP/index.html
English:  http://www.selinux.gr.jp/LIDS-JP/LIDS_en/index.html
Diary: http://omok.livejournal.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
