Subject: Re: How the native device nodes of /dev/* get relabeled?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: TaurusHarry <harrytaurus2002@hotmail.com>
Cc: selinux-mailing-list <selinux@tycho.nsa.gov>
In-Reply-To: <SNT139-w43C25DEB5952D5BB6F5452ABE80@phx.gbl>
References: <SNT139-w43C25DEB5952D5BB6F5452ABE80@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 25 May 2010 08:35:19 -0400
Message-ID: <1274790919.2742.33.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-05-25 at 06:01 +0000, TaurusHarry wrote:
> Hi SELinux experts,
> 
> Thanks for reading my question. I know the whole file system could be
> relabeled if we touch /.autorelabel, then during system boots up
> rc.sysinit will go on to call relabel_selinux() function to fix the
> label for the whole file system, however, this happens after
> rc.sysinit has called start_udev, which will mount tmpfs onto /dev/
> and take the responsibility to restorecon it properly. So how do we
> make sure those native device nodes under /dev/* such as /dev/console
> and /dev/null being properly labeled? They would be accessed by the
> hostname or mount program before rc.sysinit calls start_udev(when the
> tmpfs has not been mounted and labeled on /dev/).

Once policy has been loaded, you can run restorecon -R /dev to fix up
the labels of any device nodes that were previously created; rc.sysinit
does that in Fedora, but you could take it earlier in the initialization
process, anytime after policy load (you could do it from the initramfs
script right after policy load).

Otherwise, you have to just allow certain domains to access the default
type applied to the initial /dev nodes (e.g. tmpfs_t if it is a tmpfs
mount or a devtmpfs mount). refpolicy does this via
fs_rw_tmpfs_chr_files() for certain domains, including init_t, initrc_t,
mount_t, hotplug_t.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
