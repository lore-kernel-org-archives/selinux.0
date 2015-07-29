MIME-Version: 1.0
In-Reply-To: <CACL4Mm-j2AJPc0347Ev0Rr2+FfBKEKgaZ+5boF35uAAwZFwrYg@mail.gmail.com>
References: <1437732285-11524-1-git-send-email-l.pawelczyk@samsung.com>
 <1437732285-11524-12-git-send-email-l.pawelczyk@samsung.com>
 <20150729152550.GC19285@mail.hallyn.com>
 <CACL4Mm-j2AJPc0347Ev0Rr2+FfBKEKgaZ+5boF35uAAwZFwrYg@mail.gmail.com>
Date: Wed, 29 Jul 2015 18:24:03 +0200
Message-ID: <CACL4Mm_HmzRAQ-bN+q2FXoRn5P7vLJptAULX+Tt_MJmfNct3cw@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] smack: documentation for the Smack namespace
From: Lukasz Pawelczyk <havner@gmail.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-doc@vger.kernel.org, NeilBrown <neilb@suse.de>,
 linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, selinux@tycho.nsa.gov,
 Lukasz Pawelczyk <l.pawelczyk@samsung.com>, Jonathan Corbet <corbet@lwn.net>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Jiri Slaby <jslaby@suse.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Fabian Frederick <fabf@skynet.be>, Al Viro <viro@zeniv.linux.org.uk>,
 James Morris <james.l.morris@oracle.com>,
 John Johansen <john.johansen@canonical.com>,
 Greg KH <gregkh@linuxfoundation.org>, Oleg Nesterov <oleg@redhat.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 Zefan Li <lizefan@huawei.com>, Joe Perches <joe@perches.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 29, 2015 at 6:13 PM, Lukasz Pawelczyk <havner@gmail.com> wrote:

> With this namespace you delegate part of CAP_MAC_ADMIN privilege to an
> unprivileged user (as with any other namespace).

Ok, maybe the part in the brackets is an overstatement. Mostly with
namespaces you create a full abstraction of some object and give user
priviledges to that object (e.g. uts structure, network interfaces,
with UTS and NET namespaces, etc). This is rather not possible with
Smack, as being a security module it has to retain its core security
paradigm.  It cannot be a separate LSM within a host LSM (remember the
part about changing process own label and changing any other object
label, mostly a file). So Smack namespace really as I see it has big
analogy to user namespace. You cannot abstract UIDs completely in a
namespace as those UIDs do live in a host as well. If you want to have
some capabilities over them, admin has to agree to that explicitly.

Thanks,
Lukasz
