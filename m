MIME-Version: 1.0
In-Reply-To: <1232115724-2621-3-git-send-email-dpquigl@tycho.nsa.gov>
References: <1232115724-2621-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <1232115724-2621-3-git-send-email-dpquigl@tycho.nsa.gov>
Date: Sun, 18 Jan 2009 11:07:02 -0500
Message-ID: <7e0fb38c0901180807s457c3abflc1e8e7532fd3f68c@mail.gmail.com>
Subject: Re: [PATCH 2/3] SELinux: Add new security mount option to indicate
	security label support.
From: Eric Paris <eparis@parisplace.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Cc: jmorris@namei.org, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jan 16, 2009 at 9:22 AM, David P. Quigley <dpquigl@tycho.nsa.gov> wrote:
> There is no easy way to tell if a file system supports SELinux security labeling.
> Because of this a new flag is being added to the super block security structure
> to indicate that the particular super block supports labeling. This flag is set
> for file systems using the xattr, task, and transition labeling methods unless
> that behavior is overridden by context mounts.
>
> Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>

Acked-by: Eric Paris <eparis@redhat.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
