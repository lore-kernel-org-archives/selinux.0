MIME-Version: 1.0
In-Reply-To: <CAHw9pMVuZk6i42oT5ejfP+W1qa8zNGLKmWyxDJd5jn+u9Lqhfw@mail.gmail.com>
References: <CAHw9pMVuZk6i42oT5ejfP+W1qa8zNGLKmWyxDJd5jn+u9Lqhfw@mail.gmail.com>
Date: Fri, 9 May 2014 09:16:27 -0400
Message-ID: <CAHC9VhRoU0y=4XuLAPPUBs6xD-T=1XcCx5FxXr9zTB39FHmYYw@mail.gmail.com>
Subject: Re: svirt & labeled network
From: Paul Moore <paul@paul-moore.com>
To: vlad halilov <vlad.halilov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

That TODO list isn't maintained to the best of my knowledge, but you
are correct in that there is little to no integration with VM
networking.  I have a personal TODO list that includes adding better
support for raw network traffic, which will help resolve this to some
extent, but that work has not been started.

On Fri, May 9, 2014 at 7:22 AM, vlad halilov <vlad.halilov@gmail.com> wrote:
> Hi again. I successfully executed vm with static label (system_u:system_r:svirt_t:s1) but suprised, that vm see entire traffic
> on network interface. Interface attached via bridge and passed to vm as virtio device. In selinux todo list , but what with vm
> http://selinuxproject.org/page/SVirt/TODO ) i see a job 'Integration with Labeled Networking/IPSec/Labeled NFS (e.g. use of overlay VPNs for
> networks on host)'. Does this mean, that current stable (rhel) selinux release not cover vm network? I have tested network isolation for regular proccess, this working fine, but what with vm's part?
>
> ---
> vlad f halilov

-- 
paul moore
www.paul-moore.com
