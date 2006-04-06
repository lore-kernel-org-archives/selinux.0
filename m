Subject: Re: Sendmail & SELinux policies
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Tanel Kokk <tanel.kokk@seb.ee>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <44350058.7080505@seb.ee>
References: <4434DAC4.6090006@seb.ee>
	 <1144323640.6176.5.camel@moss-spartans.epoch.ncsc.mil>
	 <44350058.7080505@seb.ee>
Content-Type: text/plain
Date: Thu, 06 Apr 2006 08:14:40 -0400
Message-Id: <1144325680.6176.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-04-06 at 14:49 +0300, Tanel Kokk wrote:
> Stephen Smalley wrote:
> > On Thu, 2006-04-06 at 12:09 +0300, Tanel Kokk wrote:
> 
> > This looks suspect, as the null device should be labeled null_device_t,
> > not just device_t.  ls -Z /dev/null
> 
> Ouch! I have to note, that I have chrooted sendmail environment and 
> /sm_chroot/dev/null really has a label device_t. Now fixed to null_device_t.

Ok.  FYI, setfiles has a -r option for applying it to a chroot'd tree,
contributed by the Hardened Gentoo folks.  As in:
	setfiles -r /path/to/root /etc/selinux/targeted/contexts/files/file_contexts /path/to/root

> > Not sure why your local rule isn't applied though, unless you just
> > didn't do a make load after adding it.  You can try doing a make clean
> > load to be sure it was rebuilt.
> > 
> 
> I allways did 'make relabel' and 'make reload'.

make relabel is only necessary if you altered file contexts (.fc files),
and even then, you can usually just apply setfiles or restorecon
selectively if you know which part of the file tree needs to be updated
to avoid a full relabel.  I'd try a make clean load to be sure it
properly rebuilt.

BTW, a make relabel will likely reset the types on your chroot
environment unless you've added entries for them to your file contexts.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
