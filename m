Date: Mon, 29 Jul 2002 09:03:46 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carstengrohmann@gmx.de>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: run_init
In-Reply-To: <200207271043.KAA05992@jazzband.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0207290858020.10600-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 27 Jul 2002, Carsten Grohmann wrote:

> The run_init program on my SuSE need follow rule
> allow run_init_t initrc_exec_t:file { execute };
> to correct.
> I think it should need this rule. After this I read rule set and found
> this
> # Execute the init scripts
> domain_auto_trans(run_init_t, etc_t, initrc_t)
>
> Now my question:
> The init scripts are labled with initrc_exec_t and so etc_t should be
> initrc_exec_t to run correct. Or?

Only rc scripts that are run directly by init_t need to be labeled with
initrc_exec_t so that init_t will transition to initrc_t.  The
individual program scripts under /etc/init.d (or /etc/rc.d/init.d) are
typically left in etc_t, since they have no specific entry in
file_contexts.  The policy/file_contexts/program/initrc.fc file only
assigns initrc_exec_t to the /etc/rc.d/rc.* scripts.  There is also an
entry for /etc/init.d/rc.*, presumably for some other distribution.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
