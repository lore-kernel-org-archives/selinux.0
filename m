Date: Wed, 24 Jul 2002 10:36:02 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carstengrohmann@gmx.de>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: var_log_ksyms_t
In-Reply-To: <200207241331.NAA15055@jazzswing.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0207241029220.17252-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 24 Jul 2002, Carsten Grohmann wrote:

> If I understand you right, rc.sysinit is the scricpt,  who is starting the
> single rc-scriptes. And then it is not possible to change the domain for this
> job.

rc.sysinit is run once at boot time for system initialization (the si
entry in /etc/inittab).  We could possibly place it into a different
domain, but I'm not sure that it is worthwhile.

> It is possible to overwrite the file_type_auto_trans instruction in an later
> script? This is may be simplier than to edit the init script.
>
> The other is to change the xfs start script.
>
> On Red Hat the xfs starting with the -daemon option or not ?
>
> On SuSE it starts via startproc (start_daemon) with -nodaemon option and
> redirect the output to the /var/log directory. And this file is labled with
> the false context.

On RedHat 7.1 and 7.2, xfs is run with -daemon.

If your rc scripts do not create a /var/log/ksyms.N file, you can
certainly drop the file_type_auto_trans rule from your copy of the example
policy.  I'm sure that you have to customize it anyway for SuSE.

You could place the init script for xfs into its own domain, and define a
file type transition for it.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
