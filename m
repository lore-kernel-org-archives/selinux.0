MIME-Version: 1.0
In-Reply-To: <1232115724-2621-2-git-send-email-dpquigl@tycho.nsa.gov>
References: <1232115724-2621-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <1232115724-2621-2-git-send-email-dpquigl@tycho.nsa.gov>
Date: Sun, 18 Jan 2009 10:53:59 -0500
Message-ID: <7e0fb38c0901180753m504f06f4u1bd379a55ecb9bbc@mail.gmail.com>
Subject: Re: [PATCH 1/3] SELinux: Condense super block security structure
	flags and cleanup necessary code.
From: Eric Paris <eparis@parisplace.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Cc: jmorris@namei.org, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jan 16, 2009 at 9:22 AM, David P. Quigley <dpquigl@tycho.nsa.gov> wrote:
> The super block security structure currently has three fields for what are
> essentially flags.  The flags field is used for mount options while two other
> char fields are used for initialization and proc flags. These latter two fields are
> essentially bit fields since the only used values are 0 and 1.  These fields
> have been collapsed into the flags field and new bit masks have been added for
> them. The code is also fixed to work with these new flags.
>
> Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>

Acked-by: Eric Paris <eparis@redhat.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
