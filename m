Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3SIg6gS029312
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 14:42:06 -0400
Received: from mail-gw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3SIfUgg027624
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 18:41:30 GMT
Received: by gwb17 with SMTP id 17so664544gwb.12
        for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 11:42:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BD87A97.9010309@tresys.com>
References: <4BCC69C0.5040502@redhat.com>
	 <u2q10143821004211853jea20406bz355fc111cd449c47@mail.gmail.com>
	 <4BD0513C.40403@redhat.com>
	 <q2s10143821004220729z2e39b1fdqe16997df0cee0574@mail.gmail.com>
	 <w2q10143821004221216j96faf709w8b702c67835197d6@mail.gmail.com>
	 <4BD1B843.1030805@redhat.com>
	 <n2g10143821004280725qcf3ebaf8n44eb53504aa32feb@mail.gmail.com>
	 <4BD85592.10201@redhat.com>
	 <g2r10143821004281053vdc0263bfh605a3e3cc19f7571@mail.gmail.com>
	 <4BD87A97.9010309@tresys.com>
Date: Wed, 28 Apr 2010 14:42:04 -0400
Message-ID: <x2r10143821004281142t4138ff53k54a1084d6dcf49af@mail.gmail.com>
Subject: Re: refpolicy is missing on lots of hits with audit2allow -R.
From: Karl MacMillan <kmacmillan@tresys.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 28, 2010 at 2:12 PM, Joshua Brindle <jbrindle@tresys.com> wrote:
> Karl MacMillan wrote:
>>
>> On Wed, Apr 28, 2010 at 11:34 AM, Daniel J Walsh<dwalsh@redhat.com>
>>  wrote:
>
> <snip>>
>>>
>>> I would argue that
>>>
>>> allow X etc_t:file read;
>>> allow X configfile:file read;
>>>
>>> Should be weighted equivalently if etc_t is a configfile or only
>>> slightly heavier, and just because etc_runtime_t or some other random
>>> types are configfile does not mean we need to add weight.
>>>
>>
>
> I'm going to weigh in here even though policy isn't normally my thing.
>
> I am very against reducing distance based on attribute match over individual
> unrelated types. allow X configfile:file read should be the exact same
> distance as having an allow rule for every type in configfile in the
> interface, otherwise you have inconsistent behavior and are rewarding
> interfaces that are overly broad.
>
> The reason for using sepolgen is to find the best match, not the most broad,
> if we wanted that we could make sepolgen 1000% less complicated and just
> return allow domain filetype:file *;
>
> I suppose there is a fundamental difference in the use of the tool, the
> people I know that use it use it to find the best match, the way you want to
> use it is to fix the denial any way possible. These 2 usages conflict and we
> can't have people thinking they are making secure policy when in fact they
> aren't.
>

While I'm concerned about providing secure options as well, to
characterize Dan's current position as fixing the denial in any way
possible is not fair either. Here are the current matches in order:

# Interface options:
#   automount_exec_config(openvpn_t) # [51]
#   files_exec_etc_files(openvpn_t) # [51]
#   files_delete_etc_files(openvpn_t) # [118]
#   files_relabel_etc_files(openvpn_t) # [136]
#   files_rw_etc_files(openvpn_t) # [161]
#   files_read_etc_files(openvpn_t) # [171]
#   files_manage_etc_files(openvpn_t) # [179]
#   auth_use_nsswitch(openvpn_t) # [1362]
#   seutil_semanage_policy(openvpn_t) # [3532]
#   auth_login_pgm_domain(openvpn_t) # [3736]
#   portage_compile_domain(openvpn_t) # [3902]

Something is clearly wrong - largely because I'm not distinguishing
between exec, delete, relabel, and read/write.

Karl

>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
