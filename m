MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180409183605.5956-1-sds@tycho.nsa.gov>
References: <20180409183605.5956-1-sds@tycho.nsa.gov>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Apr 2018 11:53:30 -0700
Message-ID: <CA+55aFxdE9GYYu2iz_wWxs2O9qON1WemyHFH9derHfAmS00g-Q@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul@paul-moore.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Dmitry Vyukov <dvyukov@google.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: fix missing dput() before selinuxfs
 unmount
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Apr 9, 2018 at 11:36 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Commit 0619f0f5e36f ("selinux: wrap selinuxfs state") triggers
> a BUG when SELinux is runtime-disabled (i.e. systemd or equivalent
> disables SELinux before initial policy load via /sys/fs/selinux/disable
> based on /etc/selinux/config SELINUX=disabled).

Thanks, applied.

               Linus
