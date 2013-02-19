Message-ID: <51238001.5030804@tycho.nsa.gov>
Date: Tue, 19 Feb 2013 08:37:05 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Brian_Iv=E1n_Mart=EDnez?= <xangelux@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: systemd selinux
References: <CACcxAnHapENU25rsrcjijfdVNdvp9yyGBvVDys=pBg_qssPLGg@mail.gmail.com> <51193FDB.5030506@tycho.nsa.gov> <CACcxAnH-j-A0SkZvsbV7OLpD8o9CfeOu_UmyYTdcKEmjXpxyTQ@mail.gmail.com> <511946AB.10802@tycho.nsa.gov> <CACcxAnHzphj13zgYvkVOu-kptpf5zwR2YN6aY6AtpQ6WwPvAmA@mail.gmail.com> <511951CC.1000607@tycho.nsa.gov> <CACcxAnF8p+zJJ7XeV9JbWmLvxKWH2vJKKZXRcUXTN6U6GKy7BA@mail.gmail.com> <CACcxAnEXkFasdDFKVw8baaXP7bbgx5vndfL=j7dUAsVhrMxxMA@mail.gmail.com> <51195783.5080201@tycho.nsa.gov> <CACcxAnHVdep6fkEFxqwt0ZmoPshDVG1PTvNpEEMGEL_gaZ_d8g@mail.gmail.com> <51195BFC.3000604@tycho.nsa.gov> <CACcxAnEiKMCS6pHj7cizm83OOhq+Zj4nFh7qSMjDFE78Oz5o9w@mail.gmail.com> <CACcxAnEa45SCjEJNxUf_b303-d9QjnyV36nOSBeHQgE6zKP7Bg@mail.gmail.com> <511A3B8F.8000702@tycho.nsa.gov> <CACcxAnGeKe_o4oMTZJZuUk+v2NANcQTQODR6ZMo9CJeTQX7uJg@mail.gmail.com> <511B95E8.9030401@tycho.nsa.gov> <CACcxAnFy6v79Eiz5uA_Ac92c+kuJRhCi3BEw_ZkzG25G4etuSg@mail.gmail.com>
In-Reply-To: <CACcxAnFy6v79Eiz5uA_Ac92c+kuJRhCi3BEw_ZkzG25G4etuSg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/17/2013 01:43 AM, Brian Iván Martínez wrote:
> Thanks for the help, I found the fedora package for policycoreutils and
> copied the unit file to make the daemon run in every boot, you said it
> wasn't necessary but it would be nice to have working everything I can
> and even if I have the time and energy after this getting the gui tools
> too. Anyway, I've downloaded the selinux notebook and the first thing I
> notice is the change in the directories so I'm running thinking selinux
> was in /selinux and no it isn't, should I erase the entry in the fstab
> or should I change it to point to /sys/fs/selinux?. Another thing is, I
> installed an old policy wich is sysvinit compatible but now I can't boot
> in enforcing because it complains about not finding /dev/shm to boot (in
> permissive is fine), in the IRC one guy helped me (I'm really sorry, I
> forgot the username) and said it could be a policy issue so I should
> install a new one either from Fedora's lates packages or from Tresys and
> then try to create one based on those. My question is, could that be the
> issue or should I search somewhere else?

You don't need it in fstab because systemd calls libselinux 
selinux_init_load_policy() which will automatically try to mount 
selinuxfs on /sys/fs/selinux first, and then fall back to /selinux if 
that directory does not exist (which would be the case on older kernels).

Updating to a recent policy certainly wouldn't hurt.  But for policy 
issues, you should:
a) post your actual denials,
b) take your questions to the refpolicy list,
http://oss.tresys.com/mailman/listinfo/refpolicy


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
