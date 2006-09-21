Subject: Re: SSH pubkey authentication & MLS policy
From: Erich Schubert <erich@debian.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Michael C Thompson <thompsmc@us.ibm.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20060921160426.GA2487@sergelap.austin.ibm.com>
References: <4511AAF2.8090809@us.ibm.com> <45129698.5080503@redhat.com>
	 <1158852528.14117.48.camel@wintermute.xmldesign.de>
	 <20060921160426.GA2487@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 21:24:09 +0200
Message-Id: <1158866649.16609.2.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
> > http://svn.debian.org/wsvn/selinux/refpolicy/branches/debian/policy/modules/services/ssh.te?op=diff&rev=0&sc=0
> 
> Looks like the statements we need, but why do you have this
> under tunable_policy(`ssh_sysadm_login')?

IIRC it was in the static vs. targeted construct, not in
ssh_sysadm_login.
Or it was because in the case of not allowing sysadm logins, I didn't
want it to be able to scan the sysadm's home directory. YMMV.

Anyway, getattr should be enough. Could you try modifying your sergessh
module to only add getattr attributes, if that is enough? If so, we
should add a new interface which includes getattr, but not full search
to home directories.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
                 Friends are those who reach out for                 //\
                   your hand but touch your heart.                   V_/_
  Es gibt wenig aufrichtige Freunde. Die Nachfrage ist auch gering.
                    --- Marie von Ebner-Eschenbach


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
