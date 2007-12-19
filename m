Subject: Re: acpid.socket
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30712181608n40756522l10bf8a3e233b6546@mail.gmail.com>
References: <dd18b0c30712181608n40756522l10bf8a3e233b6546@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 19 Dec 2007 10:59:26 -0500
Message-Id: <1198079966.19081.48.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-12-18 at 16:08 -0800, Justin Mattock wrote:
> Hello im wanting to know if there is somebody else who has experienced
> this problem; when in enforcing mode from /etc/selinux/config. A
> system reboot then reports 
> a unable to connect to socket acpid.socket permissions denied. I've
> noticed the label gives me system_u:object_r:tmpfs_t then after
> restorecon acpid.socket I receive
> system_u:object_r:apmd_run_run_t .
> Any info would be helpful,

Is /var/run a tmpfs mount on your system?

That would explain why it defaults to tmpfs_t.  You'd need to mount it
with a rootcontext= mount option or restorecon it after mounting to give
it the correct type.

In Fedora, there is a similar issue with the tmpfs mount for /dev, since
it is initially populated before policy is loaded, so they do a
restorecon -R /dev from rc.sysinit.  You might have to do that
for /var/run too.  Has to occur _after_ you've loaded policy, of course.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
