Message-ID: <44350829.1010106@seb.ee>
Date: Thu, 06 Apr 2006 15:23:05 +0300
From: Tanel Kokk <tanel.kokk@seb.ee>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Re: Sendmail & SELinux policies
References: <4434DAC4.6090006@seb.ee>	 <1144323640.6176.5.camel@moss-spartans.epoch.ncsc.mil>	 <44350058.7080505@seb.ee> <1144325680.6176.36.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1144325680.6176.36.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-04-06 at 14:49 +0300, Tanel Kokk wrote:
>> Stephen Smalley wrote:
>>> On Thu, 2006-04-06 at 12:09 +0300, Tanel Kokk wrote:
>>> This looks suspect, as the null device should be labeled null_device_t,
>>> not just device_t.  ls -Z /dev/null
>> Ouch! I have to note, that I have chrooted sendmail environment and 
>> /sm_chroot/dev/null really has a label device_t. Now fixed to null_device_t.
> 
> Ok.  FYI, setfiles has a -r option for applying it to a chroot'd tree,
> contributed by the Hardened Gentoo folks.  As in:
> 	setfiles -r /path/to/root /etc/selinux/targeted/contexts/files/file_contexts /path/to/root

That's good hind. I didn't know that.

> make relabel is only necessary if you altered file contexts (.fc files),
> and even then, you can usually just apply setfiles or restorecon
> selectively if you know which part of the file tree needs to be updated
> to avoid a full relabel.  I'd try a make clean load to be sure it
> properly rebuilt.
> 
> BTW, a make relabel will likely reset the types on your chroot
> environment unless you've added entries for them to your file contexts.
> 

I have labels for chroot directory, too. Before I have entry:

/sm_chroot/dev(/.*)?       system_u:object_r:device_t

and there wasn't separate labels for specific devise files. Now I added 
right labels for these ones, too.

-- 
Tanel Kokk


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
