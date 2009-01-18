MIME-Version: 1.0
In-Reply-To: <1232115724-2621-4-git-send-email-dpquigl@tycho.nsa.gov>
References: <1232115724-2621-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <1232115724-2621-4-git-send-email-dpquigl@tycho.nsa.gov>
Date: Sun, 18 Jan 2009 11:07:47 -0500
Message-ID: <7e0fb38c0901180807w44a9d0ajbbc4981674e990e@mail.gmail.com>
Subject: Re: [PATCH 3/3] SELinux: Unify context mount and genfs behavior
From: Eric Paris <eparis@parisplace.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Cc: jmorris@namei.org, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jan 16, 2009 at 9:22 AM, David P. Quigley <dpquigl@tycho.nsa.gov> wrote:
> Context mounts and genfs labeled file systems behave differently with respect to
> setting file system labels. This patch brings genfs labeled file systems in line
> with context mounts in that setxattr calls to them should return EOPNOTSUPP and
> fscreate calls will be ignored.
>
> Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>

Acked-by: Eric Paris <eparis@redhat.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
