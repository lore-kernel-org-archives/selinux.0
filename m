Date: Tue, 23 Jul 2002 08:16:44 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carstengrohmann@gmx.de>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: var_log_ksyms_t
In-Reply-To: <200207221932.TAA02616@jazzswing.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0207230811400.29998-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 22 Jul 2002, Carsten Grohmann wrote:

> Wich program use the var_log_ksyms_t, I don't found anyfing about this. But
> the initrc domain label new files under /var/log with this security context.
> Why?

On RedHat, rc.sysinit rotates any existing /var/log/ksyms.N files and
dumps the contents of /proc/cpuinfo, /proc/modules, and /proc/ksyms to
a newly created /var/log/ksyms.0 file.  Consequently, the initrc.te file
in the example policy includes a rule to place these files into their own
type:  file_type_auto_trans(initrc_t, var_log_t, var_log_ksyms_t).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
