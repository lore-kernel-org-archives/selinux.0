Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBBGDaqW007403
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 11:13:36 -0500
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBBGDZrO002002
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 16:13:35 GMT
Received: by ug-out-1314.google.com with SMTP id 30so315180ugs.15
        for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 08:13:34 -0800 (PST)
Message-ID: <cadfc0e40712110806j5d6676f6j10a8b1dd3c557fa@mail.gmail.com>
Date: Tue, 11 Dec 2007 10:06:51 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "Reed, Tim (US SSA)" <tim.reed@baesystems.com>
Subject: Re: newrole in the background
Cc: selinux@tycho.nsa.gov
In-Reply-To: <436A69503F99214D9EBC27415F66C40C0F517115@blums0008.bluelnk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
References: <436A69503F99214D9EBC27415F66C40C0F517115@blums0008.bluelnk.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We ended up creating a variant of newrole which doesn't require tty
access. We did this to run some of our applications in the background
but still get newroles ability to set the context/level of the child
and to create a pam session for polyinstantiation. For this to work we
had to configure our apps into our variants equivalent of
/etc/selinux/newrole_pam.conf and provide corresponding /etc/pam.d
files which typically look like :
#%PAM-1.0
auth       required     pam_permit.so
account    required     pam_permit.so
password   required     pam_permit.so
session    required     pam_mkpolydir.so debug
session    required     pam_namespace.so unmnt_remnt
no_unmount_on_close gen_hash ignore_instance_parent_mode debug

This variant was based on a Fedora policysoreutils source rpm because
the RHEL5 version doesn't contain the code to map applications to
/etc/pam.d files using /etc/selinux/newrole_pam.conf.

On Dec 11, 2007 9:21 AM, Reed, Tim (US SSA) <tim.reed@baesystems.com> wrote:
>
>
>
>
> I am currently running RHEL 5 update 1 with the MLS policy.
>
>
>
> The issue that I am now having is that in our code we switched over from
> using runcon to newrole.  The newrole command is executed from within our
> application that is running in the background, so no TTY.  Which is the
> problem.
>
>
>
> Newrole bombs because there is no tty, the call that "fails" is ttyname(0).
>
>
>
> Any suggestions on a workaround or fix?
>
>
>
> I have created a test set of scripts to duplicate the issue
>
>
>
>
> foo.sh
>
> ##########################
>
> #!/bin/bash
>
>
>
> #show the current tty name
>
> printf "caller tty: "
>
> tty
>
>
>
> ./bar.sh &
>
>
>
> ##########################
>
>
>
> bar.sh
>
> ##########################
>
> #!/bin/bash
>
>
>
> #show the current tty name
>
> printf "newrole tty: "
>
> tty
>
>
>
> newrole –l SystemHigh -- -c "ls /var"
>
>
>
> ##########################
>
>
>
> Thanks,
>
> Tim


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
