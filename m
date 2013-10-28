Message-ID: <1382989275.3265.26.camel@localhost>
Subject: Re: avc_has_perm() returns -1 even when SELinux is in permissive
 mode
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul@paul-moore.com>, Daniel J Walsh <dwalsh@redhat.com>,
        Laurent Bigonville
	 <bigon@debian.org>,
        SELinux List <selinux@tycho.nsa.gov>
Date: Mon, 28 Oct 2013 15:41:15 -0400
In-Reply-To: <526EB7A8.6040409@tycho.nsa.gov>
References: <20131027144337.5b89c5a8@fornost.bigon.be>
	 <4233501.EyuflYia3d@sifl> <526EABE3.6090506@redhat.com>
	 <47693400.WomWgGLyAt@sifl> <526EB7A8.6040409@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2013-10-28 at 15:14 -0400, Stephen Smalley wrote:

> I think we just need the userspace AVC to handle it cleanly and we'll be
> fine.   I think my patch will work, but don't have a test case offhand;

Hard for me to test on Fedora with the return 0;

setenforce 0
touch /etc/systemd/system/hello.service
chcon -t invalid_t /etc/systemd/system/hello.service
semanage permissive -a init_t  (needed so init itself can read the file)

setenforce 1
systemctl status hello.service
This shouldn't be silent, but it seems like it is, I'd have expected an
USER_AVC between my user type and the unlabeled_t...

setenforce 0
systemctl status hello.service
On Fedora this works, on others, it'll likely fail with EINVAL, (since
init will have CAP_MAC_ADMIN in permissive.)  init will be able to read
invalid_t (in enforcing it'll see unlabeled_t) and should pass that down
in the security check and get rejected/need and audit message...

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
