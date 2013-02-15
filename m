Message-ID: <511E38E7.4040609@tycho.nsa.gov>
Date: Fri, 15 Feb 2013 08:32:23 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Luis Ressel <aranea@aixah.de>
CC: selinux@tycho.nsa.gov
Subject: Re: Mount of cgroup filesystems fails when booting in SELinux enforcing
 mode
References: <20130214222502.2f7d657c@gentp.lnet>
In-Reply-To: <20130214222502.2f7d657c@gentp.lnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/14/2013 04:25 PM,  Luis Ressel wrote:
> Hello everyone,
>
>
> does anybody have an idea about this bug?
> https://bugs.gentoo.org/show_bug.cgi?id=457618
>
> It looks like help from SELinux kernel developers would be really
> helpful here, as everything is going on in-kernel here. It would be
> especially helpful if someone could explain why there are no avc denial
> messages.
>
> If it helps, this is the userland script which mounts the cgroup
> filesystems and therefore causes the messages:
>
>          local agent="/lib64/rc/sh/cgroup-release-agent.sh"
>          mkdir /sys/fs/cgroup/openrc
>          mount -n -t cgroup \
>                  -o none,nodev,noexec,nosuid,name=openrc,release_agent="$agent" \
>                  openrc /sys/fs/cgroup/openrc
>          echo 1 > /sys/fs/cgroup/openrc/notify_on_release
>
>          yesno ${rc_controller_cgroups:-YES} && [ -e /proc/cgroups ] || return 0
>          while read name hier groups enabled rest; do
>                  case "${enabled}" in
>                          1)      mkdir /sys/fs/cgroup/${name}
>                                  mount -n -t cgroup -o nodev,noexec,nosuid,${name} \
>                                          ${name} /sys/fs/cgroup/${name}
>                                  ;;
>                  esac
>          done < /proc/cgroups
>
> The "echo 1" line yields a "permission denied" error, but apart from
> that there are no other messages.
>
>
> If you need more details, just ask me.
> Any feedback will be greatly appreciated!

Try stripping dontaudit rules from your policy and re-testing.
semodule -DB
<re-test>
semodule -B




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
