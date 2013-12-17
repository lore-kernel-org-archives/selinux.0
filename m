Message-ID: <52B094C0.7080107@tycho.nsa.gov>
Date: Tue, 17 Dec 2013 13:15:28 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Jay Corrales <jscorrales1122@gmail.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: /bin/bash: Bad interpreter: Permission denied.
References: <CACVacMuiN=2GPxdHpCSToAEUJNmMwn1nE+hg-xqywO0crwdDNA@mail.gmail.com>	<52B07D69.70209@tycho.nsa.gov> <CACVacMvNNP3HLAEW_RhzuHxqUvq77nmApstS5V_xKoEG1zbZkA@mail.gmail.com>
In-Reply-To: <CACVacMvNNP3HLAEW_RhzuHxqUvq77nmApstS5V_xKoEG1zbZkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/17/2013 01:03 PM, Jay Corrales wrote:
> type=AVC msg=audit(1387301151.195:82549): avc: denied { execute_no_trans }
> for pid=24492 comm="bash" path="/awips/fxa/bin/test.sh" dev=sda2 ino=800003
> scontext=user_u:user_r:user_t:s0
> tcontext=system_u:object_r:lx_apps_script_exec_t:s0 tclass=file

I don't understand how to correlate this to the policy you listed.
The tcontext above has the script labeled with lx_apps_script_exec_t,
while your policy had it as awips_exec_t.

Also, as a side note, domain transition on a shell script is
fundamentally unsafe unless the caller is strictly more trusted than the
callee.  Only suitable when the caller is trusted.  Use a binary
executable for any situation where the caller is untrusted.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
