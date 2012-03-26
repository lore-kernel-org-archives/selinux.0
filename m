Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QHtxO4016499
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 13:55:59 -0400
Received: by qadc11 with SMTP id c11so2489357qad.12
        for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 10:55:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120326173317.25d0ed1c@eldamar.bigon.be>
References: <20120326173317.25d0ed1c@eldamar.bigon.be>
Date: Mon, 26 Mar 2012 13:55:56 -0400
Message-ID: <CACLa4ps73sqV-O+aLKkFEoDtbp05heymjoz=LRrHWbq4YKD-5g@mail.gmail.com>
Subject: Re: [PATCH 2/4] policycoreutils -- Only run setfiles if we found
 read-write filesystems to run it on
From: Eric Paris <eparis@parisplace.org>
To: Laurent Bigonville <bigon@debian.org>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 26, 2012 at 11:33 AM, Laurent Bigonville <bigon@debian.org> wrote:
> Hi,
>
> Only run setfiles if we have a R/W filesystem
>
> Laurent
>
>
> From: Manoj Srivastava <srivasta@debian.org>
> Date: Thu, 5 Jun 2008 22:07:22 -0500
> Subject: Only run setfiles if we found read-write filesystems to run it on
>
> Signed-off-by: Manoj Srivastava <srivasta@debian.org>
> ---
>  scripts/fixfiles |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> index 310fccf..0db4558 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -234,7 +234,12 @@ then
>        done
>  FC=$TEMPFCFILE
>  fi
> -${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1 | cat >> $LOGFILE
> +if [  -n "${FILESYSTEMSRW}" ]; then
> +    echo "Relabeling `echo ${FILESYSTEMSRW}`"
> +    ${SETFILES} -q ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1 | cat >> $LOGFILE
> +else
> +    echo >&2 "fixfiles: No suitable file systems found"
> +fi
>  rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-* $TEMPFCFILE
>
>  UNDEFINED=`get_undefined_type` || exit $?

This patch doesn't apply.  I don't see a "SYSLOGFLAG" in the upstream
tree.  Is that something debian specific?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
