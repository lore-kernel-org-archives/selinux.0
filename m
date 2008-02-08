Date: Fri, 8 Feb 2008 10:01:14 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        Marshall Miller <mmiller@tresys.com>,
        "Todd C. Miller" <tmiller@tresys.com>
Subject: Re: fixfiles: broken option processing?
Message-ID: <20080208090114.GA16821@bobek.pm.i.cz>
References: <20080206154957.GA28647@bobek.pm.i.cz> <1202419683.27371.306.camel@moss-spartans.epoch.ncsc.mil> <20080208082922.GA26640@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <20080208082922.GA26640@bobek.pm.i.cz>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Feb 08, 2008 at 09:29:22AM +0100, Václav Ovsík wrote:
> The interpreter is changed to /bin/bash.  There are bashisms (getopts,
> PIPESTATUS...), so this can't be interpreted by /bin/sh.

No, getopts is ok (as dash(1) says). The problem is PIPESTATUS at least.

# etch:/home/zito# dash -x fixfiles
+ fullFlag=0
+ FORCEFLAG=
...
+ SELINUXTYPE=refpolicy
+ SETLOCALDEFS=0
+ FC=/etc/selinux/refpolicy/contexts/files/file_contexts
fixfiles: 109: Syntax error: Bad substitution

This code:

rpmlist() {
rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" | grep '^0 ' | cut -f2- -d ' '
[ ${PIPESTATUS[0]} != 0 ] && echo "$1 not found" >/dev/stderr
}

We should use /bin/bash.
Regards
-- 
Zito

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
