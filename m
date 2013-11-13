Message-ID: <5283A616.3080201@tycho.nsa.gov>
Date: Wed, 13 Nov 2013 11:17:26 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dan Walsh <dwalsh@redhat.com>, eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH 01/05] Make sure we do the polkit check on all dbus interfaces.
References: <1384357088-21451-1-git-send-email-dwalsh@redhat.com>
In-Reply-To: <1384357088-21451-1-git-send-email-dwalsh@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/13/2013 10:38 AM, Dan Walsh wrote:
> Change policy kit to only allow access on the console.
> ---
>  policycoreutils/sepolicy/org.selinux.policy | 36 +++++++++++++++--------------
>  policycoreutils/sepolicy/selinux_server.py  |  7 +++++-
>  2 files changed, 25 insertions(+), 18 deletions(-)

Pushed as policycoreutils-2.2.3 along with the dbus call bug fix from
the prior set.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
