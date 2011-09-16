Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8G6stiF025117
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 02:54:55 -0400
Received: from cp-out9.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8G6srpQ026484
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 06:54:54 GMT
Subject: Re: [PATCH 10/67] policycoreutils: fixfiles: FIXME label /root but
 not
From: Guido Trentalancia <guido@trentalancia.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: eparis@redhat.com, selinux@tycho.nsa.gov
Date: Fri, 16 Sep 2011 08:54:42 +0200
In-Reply-To: <4E724EE1.7070408@redhat.com>
References: <4E724EE1.7070408@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316156083.2364.52.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-09-15 at 15:15 -0400, Daniel J Walsh wrote:
> From 0af95817aaac37be5b7bd502df4894bd3e03d4d7 Mon Sep 17 00:00:00 2001
> From: Eric Paris <eparis@redhat.com>
> Date: Sun, 10 Jul 2011 16:25:18 +0200
> Subject: [PATCH 10/67] policycoreutils: fixfiles: FIXME label /root
> but not
>  /var/lib/BackupPC
> 
> This patch removes /root from the excluded dirs.
> 
> This also adds /var/lib/BackupPC to list of directories to ignore
> labeling.  Mainly because this directory tends to be Huge and causes a
> huge spike in the amount of time it takes to relabel.  Especially if
> there is a relabel caused by a policy update.
> 
> I'm not certain if either/both of these changes are appropriate.
> 
> NOT-Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
>  policycoreutils/scripts/fixfiles |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/policycoreutils/scripts/fixfiles
> b/policycoreutils/scripts/fixfiles
> index e4e5f0d..27dcccf 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -103,7 +103,7 @@ exclude_dirs_from_relabelling() {
>  
>  exclude_dirs() {
>      exclude=
> -    for i in /home /root /tmp /dev; do
> +    for i in /var/lib/BackupPC /home /tmp /dev; do

Not everybody uses BackupPC, but just in case, you could make it more
general by adapting at run-time to
http://backuppc.sourceforge.net/faq/BackupPC.html#_conf_topdir_

In other words, could read the BackupPC configuration file, if a
different TopDir is being used instead of default /var/lib/BackupPC then
exclude that.

>          [ -e $i ]  && exclude="$exclude -e $i";
>      done
>      exclude="$exclude `exclude_dirs_from_relabelling`" 

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
