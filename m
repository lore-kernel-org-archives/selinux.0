From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Cc: 544215-forwarded@bugs.debian.org, Martin Orr <martin@martinorr.name>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: restorecon and symbolic links
References: <4A996106.4060604@martinorr.name>
Date: Sat, 29 Aug 2009 18:19:31 -0500
In-Reply-To: <4A996106.4060604@martinorr.name> (Martin Orr's message of "Sat,
	29 Aug 2009 18:10:30 +0100")
Message-ID: <87my5ijji4.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Aug 29 2009, Martin Orr wrote:

> With policycoreutils 2.0.71, "restorecon /dev/stdin" fails if stdin is a pipe:
> martin@caligula:~$ echo hi | sudo restorecon /dev/stdin
> realpath(/dev/stdin) failed No such file or directory
>
> Why would you want to do this?
> The Debian udev init script does
> ln -s /proc/self/fd/0 /dev/stdin
> restorecon /dev/stdin
> I am not sure why stdin is a pipe here but it is some consequence of the
> boot process.
>
> The intention here (and what happened with policycoreutils 2.0.69) is to
> relabel the symbolic link.  But the recent realpath patch changed this, and
> I don't think there is a way now to ask restorecon to relabel an individual
> symlink.

        There are consequences to this change not mentioned above: when
 booting with policycoreutils 2.0.71 /dev/pts (and several other device
 nodes) are not created which causes all sorts of trouble.

 This is a consequence of the realpath changes in restorecon, because
 when /lib/udev/create_static_nodes does
         ln -s /proc/self/fd/0 /dev/stdin
         restorecon /dev/stdin
 it now fails with the error
         realpath(/dev/stdin) failed No such file or directory
 This causes create_static_nodes to exit (due to set -e) before creating
 /dev/pts.

        I am planning on reverting the removal of special treatment of
 symlinks from the debian  unstable version until this is resolved.

        manoj
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
