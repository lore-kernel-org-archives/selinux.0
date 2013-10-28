Message-ID: <526ECD75.7000709@tycho.nsa.gov>
Date: Mon, 28 Oct 2013 16:47:49 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Paul Moore <paul@paul-moore.com>, Daniel J Walsh <dwalsh@redhat.com>,
        Laurent Bigonville <bigon@debian.org>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: avc_has_perm() returns -1 even when SELinux is in permissive
 mode
References: <20131027144337.5b89c5a8@fornost.bigon.be>  <4233501.EyuflYia3d@sifl> <526EABE3.6090506@redhat.com>  <47693400.WomWgGLyAt@sifl> <526EB7A8.6040409@tycho.nsa.gov> <1382989275.3265.26.camel@localhost>
In-Reply-To: <1382989275.3265.26.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/28/2013 03:41 PM, Eric Paris wrote:
> On Mon, 2013-10-28 at 15:14 -0400, Stephen Smalley wrote:
> 
>> I think we just need the userspace AVC to handle it cleanly and we'll be
>> fine.   I think my patch will work, but don't have a test case offhand;
> 
> Hard for me to test on Fedora with the return 0;
> 
> setenforce 0
> touch /etc/systemd/system/hello.service
> chcon -t invalid_t /etc/systemd/system/hello.service
> semanage permissive -a init_t  (needed so init itself can read the file)
> 
> setenforce 1
> systemctl status hello.service
> This shouldn't be silent, but it seems like it is, I'd have expected an
> USER_AVC between my user type and the unlabeled_t...

# systemctl status hello.service
Failed to issue method call: Access denied
# ausearch -m USER_AVC -ts recent
time->Mon Oct 28 16:46:15 2013
type=USER_AVC msg=audit(1382993175.466:585): pid=1 uid=0 auid=4294967295
ses=4294967295  subj=system_u:system_r:init_t:s0 msg='avc:  denied  {
status } for auid=4204 uid=0 gid=0
path="/etc/systemd/system/hello.service" cmdline="systemctl status
hello.service"
scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
tcontext=unconfined_u:object_r:invalid_t:s0 tclass=service
exe="/usr/lib/systemd/systemd" sauid=0 hostname=? addr=? terminal=?'

> setenforce 0
> systemctl status hello.service
> On Fedora this works, on others, it'll likely fail with EINVAL, (since
> init will have CAP_MAC_ADMIN in permissive.)  init will be able to read
> invalid_t (in enforcing it'll see unlabeled_t) and should pass that down
> in the security check and get rejected/need and audit message...

# systemctl status hello.service
hello.service
   Loaded: masked (/etc/systemd/system/hello.service; masked)
   Active: inactive (dead)





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
