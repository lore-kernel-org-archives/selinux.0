Message-Id: <200207241331.NAA15055@jazzswing.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: var_log_ksyms_t
Date: Wed, 24 Jul 2002 15:20:14 +0200
References: <Pine.GSO.4.33.0207230811400.29998-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0207230811400.29998-100000@raven>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Dienstag, 23. Juli 2002 14:16 schrieb Stephen Smalley:
> On Mon, 22 Jul 2002, Carsten Grohmann wrote:
> > Wich program use the var_log_ksyms_t, I don't found anyfing about this.
> > But the initrc domain label new files under /var/log with this security
> > context. Why?
>
> On RedHat, rc.sysinit rotates any existing /var/log/ksyms.N files and
> dumps the contents of /proc/cpuinfo, /proc/modules, and /proc/ksyms to
> a newly created /var/log/ksyms.0 file.  Consequently, the initrc.te file
> in the example policy includes a rule to place these files into their own
> type:  file_type_auto_trans(initrc_t, var_log_t, var_log_ksyms_t).

If I understand you right, rc.sysinit is the scricpt,  who is starting the 
single rc-scriptes. And then it is not possible to change the domain for this 
job. 

It is possible to overwrite the file_type_auto_trans instruction in an later 
script? This is may be simplier than to edit the init script.

The other is to change the xfs start script. 

On Red Hat the xfs starting with the -daemon option or not ? 

On SuSE it starts via startproc (start_daemon) with -nodaemon option and 
redirect the output to the /var/log directory. And this file is labled with 
the false context. 

Carsten 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
